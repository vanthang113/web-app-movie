import React, { FunctionComponent, useEffect } from 'react'
import { Swiper, SwiperSlide } from 'swiper/react';
import { Navigation, Pagination, Autoplay } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import { listTopMovies, MovieTopRatedState } from 'reducers/movie'
import { ReduxState } from 'store'
import { useAppDispatch } from 'hooks'
import { useSelector } from 'react-redux'
import { Loader, Message } from 'components/shared'
import { imageUrl } from 'utils'
import Link from 'next/link'
import { Rating } from '.';

const TopMovie: FunctionComponent = () => {
    const dispatch = useAppDispatch()

    const movieTopRated = useSelector(
        (state: ReduxState) => state.movieTopRated as MovieTopRatedState
    )
    const { loading, movies, error } = movieTopRated

    useEffect(() => {
        dispatch(listTopMovies())
    }, [dispatch])

    return (
        <div>
            {loading ? (
                <Loader />
            ) : error ? (
                <Message>{error}</Message>
            ) : (
                <Swiper
                    modules={[Navigation, Pagination, Autoplay]}
                    spaceBetween={30}
                    slidesPerView={3}
                    navigation
                    pagination={{ clickable: true }}
                    autoplay={{
                        delay: 3000,
                        disableOnInteraction: false,
                    }}
                    breakpoints={{
                        320: {
                            slidesPerView: 1,
                        },
                        768: {
                            slidesPerView: 2,
                        },
                        1024: {
                            slidesPerView: 3,
                        },
                    }}
                >
                    {movies.map((movie) => (
                        <SwiperSlide key={movie._id}>
                            <div className='mx-5'>
                                <div className="py-3 sm:max-w-xl sm:mx-auto">
                                    <div className="text-white shadow shadow-gray-100 max-h-80 sm:rounded-3xl p-8 flex space-x-8">
                                        <div className="h-56 overflow-visible w-1/2">
                                            <img className="rounded-3xl shadow-lg" src={imageUrl(movie.image)} alt={movie.name} />
                                        </div>
                                        <div className="flex flex-col w-1/2 space-y-4">
                                            <div className="mt-0">
                                                <h2 className="text-xl font-bold">{movie.name}</h2>
                                                <Rating value={movie.rating} />
                                                <div className="text-sm text-gray-400">{movie.releasedAt}</div>
                                                <div className="text-sm text-gray-400">{movie.description.substring(0, 40)} ...</div>
                                            </div>
                                            <Link href={`/movie/${movie._id}`}>
                                                <button className="flex inline-flex items-center bg-orange-500 text-white-900 p-2.5 rounded font-semibold hover:bg-orange-600 transition ease-in-out duration-150" >
                                                    <svg className="w-6 fill-current" viewBox="0 0 24 24">
                                                        <path d="M0 0h24v24H0z" fill="none" />
                                                        <path d="M10 16.5l6-4.5-6-4.5v9zM12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z" />
                                                    </svg>
                                                    <span className="ml-2">Watch Now</span>
                                                </button>
                                            </Link>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </SwiperSlide>
                    ))}
                </Swiper>
            )}
        </div>
    )
}

export default TopMovie
