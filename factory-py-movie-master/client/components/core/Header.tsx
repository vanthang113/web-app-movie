import React, { FunctionComponent, useCallback } from 'react'
import { useSelector } from 'react-redux'
import { FaUser, FaSignOutAlt } from 'react-icons/fa'

import { logout } from 'reducers/user'
import { ReduxState } from 'store'
import { useAppDispatch } from 'hooks'
import Link from 'next/link'
import Search from './Search'

const Header: FunctionComponent = () => {
    const userLogin = useSelector((state: ReduxState) => state.userLogin)
    const { userInfo } = userLogin
    const dispatch = useAppDispatch()
    const logoutHandler = useCallback(() => {
        dispatch(logout())
    }, [dispatch])

    return (
        <nav className="border-b border-gray-800">
            <div className="container mx-auto px-4 flex flex-col md:flex-row items-center justify-between px-4 py-6">
                <ul className="flex flex-col md:flex-row items-center">
                    <li>
                        <Link href="/">
                            <svg className="w-32" viewBox="0 0 96 24" fill="none">
                                {/* SVG content here */}
                            </svg>
                        </Link>
                    </li>
                    <li className="md:ml-16 mt-3 md:mt-0">
                        <Link href="/actor" className="hover:text-gray-300">Movie</Link>
                    </li>
                    <li className="md:ml-6 mt-3 md:mt-0">
                        <Link href="/actor" className="hover:text-gray-300">TV Show</Link>
                    </li>
                    <li className="md:ml-6 mt-3 md:mt-0">
                        <Link href="/actor" className="hover:text-gray-300">Actors</Link>
                    </li>
                </ul>
                <Search />
                <div>
                    {userInfo ? (
                        <div className="flex flex-col md:flex-row items-center">
                            <Link href="/profile" className="md:mr-4 mt-3 md:mt-0">
                                {userInfo.name}
                            </Link>
                            <button onClick={logoutHandler}>
                                <FaSignOutAlt />
                            </button>
                        </div>
                    ) : (
                        <div className="flex flex-col md:flex-row items-center">
                            <Link href="/login">
                                <button>Login</button>
                            </Link>
                            <Link href="/register" className="md:ml-4 mt-3 md:mt-0">
                                <button>Register</button>
                            </Link>
                        </div>
                    )}
                </div>
            </div>
        </nav>
    )
}

export default Header