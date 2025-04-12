import 'styles/global.css';
import Router from 'next/router';
import NProgress from 'nprogress';
import { AppProps } from 'next/app';
import React from 'react';
import { Provider } from 'react-redux';

import { Header, Footer } from 'components/core';
import { wrapper } from 'store';

// Bắt đầu và dừng tiến trình NProgress khi thay đổi route
Router.events.on('routeChangeStart', () => NProgress.start());
Router.events.on('routeChangeComplete', () => NProgress.done());
Router.events.on('routeChangeError', () => NProgress.done());

function MyApp({ Component, ...rest }: AppProps) {
    // Sử dụng useWrappedStore để lấy store và props
    const { store, props } = wrapper.useWrappedStore(rest);

    return (
        <Provider store={store}>
            <Header />
            <main className="lg:container mx-auto py-3">
                <Component {...props.pageProps} />
            </main>
            <Footer />
        </Provider>
    );
}

// Không cần wrapper.withRedux nữa, vì chúng ta đã sử dụng useWrappedStore trong MyApp
export default MyApp;
