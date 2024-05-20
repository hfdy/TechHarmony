/**
 * 定义接口响应包装类
 */
import http from '@ohos.net.http';

interface HttpRequestConfig extends http.HttpRequestOptions {
  showLoading?: boolean; //是否展示请求loading
  checkResultCode?: boolean; //是否检验响应结果码
  checkLoginState?: boolean //校验用户登陆状态
  needJumpToLogin?: boolean //是否需要跳转到登陆页面
  url?: string, //请求网络链接
}


/**
 * 网络请求构造器
 * 基于鸿蒙默认的http框架实现
 */
class HttpBuilder {
  httpClient: http.HttpRequest
  config: HttpRequestConfig

  constructor(options: HttpRequestConfig) {
    this.httpClient = http.createHttp()
    this.config = options
    this.setupInterceptor()
  }
  /**
   * 配置属性拦截器
   */
  setupInterceptor() {

  }

  request<T = object>(config: HttpRequestConfig): Promise<T> {
    return new Promise<T>((resolve, reject) => {
      this.httpClient.request(
        config.url,
        config,
        (error, data) => {
          if (!error) {
            resolve(data.result as T);
          } else {
            reject(error)
          }
          // 当该请求使用完毕时，调用destroy方法主动销毁x
          this.httpClient.destroy()
        }
      )
    })
  }

  get<T = object>(config: HttpRequestConfig): Promise<T> {
    config.method = http.RequestMethod.GET;
    return this.request(config);
  }

  post<T = object>(config: HttpRequestConfig): Promise<T> {
    config.method = http.RequestMethod.POST;
    return this.request(config);
  }
}

export default HttpBuilder