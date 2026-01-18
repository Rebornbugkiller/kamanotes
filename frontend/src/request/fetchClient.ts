import { Code, HttpClient, Options, RequestTuple, Response } from './types.ts'
import { kamanoteUserToken } from '../base/constants'

export default class FetchClient implements HttpClient {
  private readonly baseURL = import.meta.env.VITE_API_BASE_URL || ''
  constructor() {}

  // 处理路径参数
  private processPathParams(path: string, pathParams: Array<any>): string {
    let paramIndex = 0
    // 替换路径中的占位符
    return path.replace(/\{(\w+)\}/g, () => {
      const param = pathParams[paramIndex++]
      if (param === undefined) {
        throw new Error('Missing path parameter')
      }
      return encodeURIComponent(param)
    })
  }

  async request<T>(
    requestTuple: RequestTuple,
    options?: Options,
  ): Promise<Response<T>> {
    const [method, requestPath] = requestTuple

    // 最终的请求路径
    let requestURL = `${this.baseURL}${requestPath}`

    // 默认请求头
    const headers: HeadersInit = {
      'Content-Type': 'application/json',
      ...(options?.headers || {}),
    }

    // 如果存在 token，则需要携带 token
    if (localStorage.getItem(kamanoteUserToken)) {
      headers['Authorization'] =
        `Bearer ${localStorage.getItem(kamanoteUserToken)}`
    }

    // Fetch API 配置
    const fetchOptions: RequestInit = {
      method,
      headers,
    }

    // 处理路径参数
    if (options?.pathParams) {
      try {
        requestURL = this.processPathParams(requestURL, options.pathParams)
      } catch (err) {
        console.error(err)
        throw new Error('Failed to process path parameters')
      }
    }

    /**
     * 处理 GET 请求的 query 参数
     */
    if (method === 'GET' && options?.queryParams) {
      /**
       * 对 queryParams 中的值为 undefined 的 key 进行过滤
       */
      const queryParams = Object.fromEntries(
        Object.entries(options.queryParams).filter(
          ([, value]) => value !== undefined,
        ),
      )
      const queryString = new URLSearchParams(queryParams).toString()
      requestURL += queryString ? `?${queryString}` : ''
    }

    // 处理 GET 方法以外的其它方法
    if (method !== 'GET' && options?.body) {
      if (options.body instanceof FormData) {
        // 如果是 FormData，移除 Content-Type
        delete headers['Content-Type']
        fetchOptions.body = options.body
      } else {
        // TODO: JSON.stringify 会自动过滤 undefined 属性？?
        fetchOptions.body = JSON.stringify(options.body)
      }
    }

    try {
      const response = await fetch(requestURL, fetchOptions)
      const result = (await response.json()) as Response<T>

      if (result.code !== Code.SUCCESS) {
        // 事先判断
        throw new Error(result.msg)
      }

      return result
      // 包装返回的结果，符合接口定义
    } catch (error) {
      // 捕获错误并包装为统一响应格式
      console.error('error', error)
      throw new Error(error instanceof Error ? error.message : 'Unknown error')
    }
  }
}
