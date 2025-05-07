import {createAsyncThunk,createSlice,} from '@reduxjs/toolkit'
import { Movie, MovieList } from 'interfaces'
import api from 'utils/api'

export const listMovies = createAsyncThunk<
    MovieList,
    { keyword: string, pageNumber?: number }>('MOVIE_LIST', async (args, { rejectWithValue }) => {
    try {
        const { keyword } = args
        const pageNumber = args.pageNumber ?? 1
        const response = await api.get(
            `/movies?keyword=${keyword ?? ''}&page=${pageNumber}`
        )
        return response.data as MovieList
    } catch (error: any) {
        console.error('Error fetching movies:', error)
        return rejectWithValue(error.response?.data?.message || 'Error fetching movies')
    }
})

export type MovieListState = {
    loading: boolean
    movies: Movie[]
    error?: string
    page: number
    pages: number
}

const initialMovieListState: MovieListState = {
    loading: false,
    movies: [],
    page: 1,
    pages: 1,
}

export const movieListSlice = createSlice({
    name: 'movieList',
    initialState: initialMovieListState,
    reducers: {},
    extraReducers: (builder) => {
        builder.addCase(listMovies.pending, (state) => {
            state.loading = true
            state.movies = []
            state.error = undefined
            state.page = 1
            state.pages = 1
        })
        builder.addCase(listMovies.fulfilled, (state, { payload }) => {
            state.loading = false
            state.movies = payload.movies
            state.pages = payload.pages
            state.page = payload.page
            state.error = undefined
        })
        builder.addCase(listMovies.rejected, (state, action) => {
            state.loading = false
            state.error = action.payload as string || action.error.message
            state.movies = []
        })
    }
})