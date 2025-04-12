import React from 'react'
import Head from 'next/head'
import { Header, Footer } from 'components/core'

interface LayoutProps {
    children: React.ReactNode
    title?: string
}

const Layout: React.FC<LayoutProps> = ({ children, title = 'WebFILM' }) => {
    return (
        <>
            <Head>
                <title>{title}</title>
                <meta name="description" content="WebFILM - Xem phim trực tuyến" />
                <link rel="icon" href="/favicon.ico" />
            </Head>
            <Header />
            <main className="lg:container mx-auto py-3">
                {children}
            </main>
            <Footer />
        </>
    )
}

export default Layout 