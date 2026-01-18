import React, { createContext, useState, useEffect } from 'react'
import { UserState } from '../types/types'
import { userService } from '../service/userService'
import { TOKEN_KEY } from '../../../base/constants'

interface UserContextType {
  currentUser: UserState | null
  setCurrentUser: (user: UserState | null) => void
  reloadUser: () => Promise<void>
}

export const UserContext = createContext<UserContextType>({
  currentUser: null,
  setCurrentUser: () => {},
  reloadUser: async () => {},
})

export const UserProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [currentUser, setCurrentUser] = useState<UserState | null>(() => {
    // 尝试从 localStorage 获取用户信息
    const savedUser = localStorage.getItem('currentUser')
    return savedUser ? JSON.parse(savedUser) : null
  })

  const reloadUser = async () => {
    console.log('开始重新加载用户信息')
    try {
      const token = localStorage.getItem(TOKEN_KEY)
      console.log('从localStorage获取的token:', token ? '存在' : '不存在')

      if (!token) {
        console.log('未找到token，清除当前用户')
        setCurrentUser(null)
        localStorage.removeItem('currentUser')
        return
      }

      const resp = await userService.whoamiService()
      console.log('获取用户信息响应:', resp)

      if (resp && resp.data) {
        console.log('设置当前用户:', resp.data)
        setCurrentUser(resp.data)
        localStorage.setItem('currentUser', JSON.stringify(resp.data))
      } else {
        console.log('响应中没有用户数据，清除当前用户')
        setCurrentUser(null)
        localStorage.removeItem('currentUser')
        localStorage.removeItem(TOKEN_KEY)
      }
    } catch (error) {
      console.error('加载用户信息失败:', error)
      setCurrentUser(null)
      localStorage.removeItem('currentUser')
      localStorage.removeItem(TOKEN_KEY)
    }
  }

  // 组件挂载时，如果有 token 就自动加载用户信息
  useEffect(() => {
    const token = localStorage.getItem(TOKEN_KEY)
    if (token && !currentUser) {
      reloadUser()
    }
  }, [])

  useEffect(() => {
    console.log('用户状态更新:', currentUser)
    if (currentUser) {
      localStorage.setItem('currentUser', JSON.stringify(currentUser))
    } else {
      localStorage.removeItem('currentUser')
    }
  }, [currentUser])

  const contextValue = {
    currentUser,
    setCurrentUser: (user: UserState | null) => {
      console.log('设置用户状态:', user)
      setCurrentUser(user)
      if (!user) {
        localStorage.removeItem('currentUser')
        localStorage.removeItem(TOKEN_KEY)
      } else {
        localStorage.setItem('currentUser', JSON.stringify(user))
      }
    },
    reloadUser,
  }

  return (
    <UserContext.Provider value={contextValue}>{children}</UserContext.Provider>
  )
}
