import axios, { AxiosResponse } from 'axios'
import { message } from 'antd'
import { TOKEN_KEY } from '../base/constants'
import { ApiResponse } from './types'

// 创建axios实例，并指定响应数据类型为 ApiResponse
// Docker 环境下使用相对路径，通过 nginx 代理访问后端
export const http = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '', // 使用相对路径，通过 nginx 代理
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
})

// 请求拦截器
http.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem(TOKEN_KEY)
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    // 添加请求调试信息
    console.log('发送请求:', {
      url: config.url,
      method: config.method,
      data: config.data,
      headers: config.headers,
      baseURL: config.baseURL,
      token: token ? '存在' : '不存在',
    })
    return config
  },
  (error) => {
    console.error('请求错误:', error)
    return Promise.reject(error)
  },
)

// 响应拦截器
http.interceptors.response.use(
  (response: AxiosResponse<ApiResponse<any>>) => {
    // 添加响应调试信息
    console.log('收到响应:', {
      url: response.config.url,
      status: response.status,
      data: response.data,
      headers: response.headers,
    })

    // 如果是登录接口，直接返回完整响应
    if (response.config.url?.includes('/api/auth/login')) {
      return response
    }

    const res = response.data
    if (res.code !== 200) {
      // 401: 未登录状态
      if (res.code === 401) {
        console.log('用户未登录或登录已过期')
        localStorage.removeItem(TOKEN_KEY)
        localStorage.removeItem('currentUser')
        // 如果当前不在登录页面，才跳转
        if (!window.location.pathname.includes('/login')) {
          message.error('登录已过期，请重新登录')
          window.location.href = '/login'
        }
        return Promise.reject(new Error('未登录或登录已过期'))
      }
      // 其他业务错误码，显示错误信息
      message.error(res.message || '请求失败')
      return Promise.reject(res)
    }
    // 返回响应数据
    return response
  },
  (error) => {
    // 添加错误调试信息
    console.error('响应错误:', {
      url: error.config?.url,
      status: error.response?.status,
      data: error.response?.data,
      message: error.message,
    })

    // 网络错误、服务器错误等才显示错误提示
    if (error.response) {
      // 服务器返回了错误状态码
      if (error.response.status === 401) {
        console.log('用户未登录或登录已过期')
        localStorage.removeItem(TOKEN_KEY)
        localStorage.removeItem('currentUser')
        // 如果当前不在登录页面，才跳转
        if (!window.location.pathname.includes('/login')) {
          message.error('登录已过期，请重新登录')
          window.location.href = '/login'
        }
      } else {
        message.error(error.response.data?.message || '请求失败，请稍后重试')
      }
    } else if (error.request) {
      // 请求发出去了但没有收到响应
      console.error('网络错误:', error.request)
      message.error('网络连接失败，请检查网络')
    } else {
      // 请求配置出错
      console.error('请求配置错误:', error.message)
      message.error('请求配置错误')
    }
    return Promise.reject(error)
  },
)
