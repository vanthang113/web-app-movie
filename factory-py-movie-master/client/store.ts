import { configureStore, combineReducers } from "@reduxjs/toolkit";
import { createWrapper } from "next-redux-wrapper";
import {
    persistStore,
    persistReducer,
    FLUSH,
    REHYDRATE,
    PAUSE,
    PERSIST,
    PURGE,
    REGISTER,
} from "redux-persist";
import storage from "redux-persist/lib/storage";
import createWebStorage from "redux-persist/lib/storage/createWebStorage";

import {
    userLoginSlice,
    userRegisterSlice,
    userDetailsSlice,
    userUpdateProfileSlice,
} from "reducers/user";
import {
    movieListSlice,
    movieDetailSlice,
    movieTopSlice,
    createMovieReviewSlice,
} from "reducers/movie";
import { actorListSlice, actorDetailSlice } from "reducers/actor";

// Kiểm tra môi trường trước khi sử dụng storage
const createNoopStorage = () => ({
    getItem: async () => null,
    setItem: async () => {},
    removeItem: async () => {},
});

const storageClient = typeof window !== "undefined" ? createWebStorage("local") : createNoopStorage();

// Cấu hình persist
const persistConfig = {
    key: "root",
    storage: storageClient, // Dùng storage phù hợp với môi trường
    whitelist: ["userLogin"], // Chỉ lưu Redux state của userLogin
};

// Kết hợp reducers
const rootReducer = combineReducers({
    userLogin: userLoginSlice.reducer,
    userRegister: userRegisterSlice.reducer,
    userDetails: userDetailsSlice.reducer,
    userUpdateProfile: userUpdateProfileSlice.reducer,
    movieList: movieListSlice.reducer,
    movieDetail: movieDetailSlice.reducer,
    movieTopRated: movieTopSlice.reducer,
    movieCreateReview: createMovieReviewSlice.reducer,
    actorList: actorListSlice.reducer,
    actorDetail: actorDetailSlice.reducer,
});

// Bọc rootReducer với persistReducer
const persistedReducer = persistReducer(persistConfig, rootReducer);

// Định nghĩa các kiểu dữ liệu cho Redux store
export type ReduxState = ReturnType<typeof rootReducer>;
export type AppStore = ReturnType<typeof makeStore>;
export type RootState = ReturnType<AppStore["getState"]>;
export type AppDispatch = AppStore["dispatch"];

// Hàm tạo store
const makeStore = () => {
    const isServer = typeof window === "undefined";

    if (isServer) {
        return configureStore({
            reducer: rootReducer,
            middleware: (getDefaultMiddleware) =>
                getDefaultMiddleware({
                    serializableCheck: false,
                }),
            devTools: process.env.NODE_ENV !== "production",
        });
    }

    const store = configureStore({
        reducer: persistedReducer,
        middleware: (getDefaultMiddleware) =>
            getDefaultMiddleware({
                serializableCheck: {
                    ignoredActions: [FLUSH, REHYDRATE, PAUSE, PERSIST, PURGE, REGISTER],
                },
            }),
        devTools: process.env.NODE_ENV !== "production",
    });

    (store as any).__persistor = persistStore(store);
    return store;
};

// Khởi tạo wrapper
export const wrapper = createWrapper<AppStore>(makeStore, { debug: process.env.NODE_ENV !== "production" });
