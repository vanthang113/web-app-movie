import axios from 'axios'
import type { AxiosInstance, InternalAxiosRequestConfig } from 'axios'

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api'

const api: AxiosInstance = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,PATCH,OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        'Access-Control-Allow-Credentials': 'true'
    },
    withCredentials: true,
    timeout: 10000,
    validateStatus: function (status) {
        return status >= 200 && status < 500
    }
})

// Thêm interceptor để xử lý token
api.interceptors.request.use(
    (config: InternalAxiosRequestConfig) => {
        console.log('Making request to:', config.url)
        const token = localStorage.getItem('token')
        if (token) {
            config.headers.Authorization = `Bearer ${token}`
        }
        return config
    },
    (error: any) => {
        console.error('Request error:', error)
        return Promise.reject(error)
    }
)

// Thêm interceptor để xử lý response
api.interceptors.response.use(
    (response) => {
        console.log('Response from:', response.config.url, response.status)
        return response
    },
    (error) => {
        console.error('Response error:', {
            message: error.message,
            url: error.config?.url,
            status: error.response?.status,
            data: error.response?.data
        })
        if (error.response?.status === 401) {
            localStorage.removeItem('token')
            window.location.href = '/login'
        }
        return Promise.reject(error)
    }
)

export default api 