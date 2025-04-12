import { useDispatch } from 'react-redux'
import { AppStore } from 'store'

let store: AppStore

export type AppDispatch = typeof store.dispatch

export const useAppDispatch = () => useDispatch<AppDispatch>()
