import { AxiosError, AxiosRequestHeaders, AxiosResponse } from '@ohos/axios';
import { Logger } from '../utils/Logger';
import { hideLoadingDialog, showLoadingDialog } from '../utils/DialogUtils';
import { StorageUtils } from '../utils/StorageUtils';
import { StorageKeys } from '../constants/StorageKeys';
import { ToastUtils } from '../utils/ToastUtils';
import { JsonUtils } from '../utils/JsonUtils';
import { AxiosHttpRequest, HttpRequestConfig } from './AxiosHttp';
import { BusinessError } from '@ohos.base';

export interface HttpApiResp extends AxiosResponse{
  config: HttpRequestConfig;
}

/**
 * axios请求客户端创建
 */
export const axiosClient = new AxiosHttpRequest({
  baseURL: "/api",
  timeout: 10 * 1000,
  checkResultCode: false,
  headers: {
    'Content-Type': 'application/json'
  } as AxiosRequestHeaders,
  interceptorHooks: {
    requestInterceptor: async (config: HttpRequestConfig) => {
      // 在发送请求之前做一些处理，例如打印请求信息
      Logger.debug('网络请求Request 请求方法:' + `${config.method}`);
      Logger.debug('网络请求Request 请求链接:' + `${config.url}`);
      Logger.debug('网络请求Request Params:' + `\n${JsonUtils.stringify(config.params)}`);
      Logger.debug('网络请求Request Data:' + `${JsonUtils.stringify(config.data)}`);
      axiosClient.config.showLoading = config.showLoading
      if (config.showLoading) {
        showLoadingDialog("加载中...")
      }
      let userToken = await StorageUtils.get(StorageKeys.USER_TOKEN);
      config.headers?.set("Authorization", `Bearer ${userToken as string}`);
      if (config.checkLoginState) {
        Logger.debug('网络请求Request 登录状态校验>>>' + `${userToken}`);
        if (userToken) {
          return config
        } else {
          if (config.needJumpToLogin) {
            // Router.push(RoutePath.WebPage)
          }
          throw new Error("请登录");
        }
      }
      return config;
    },
    requestInterceptorCatch: (err) => {
      Logger.error("网络请求RequestError" + err.toString())
      if (axiosClient.config.showLoading) {
        hideLoadingDialog()
      }
      return err;
    },
    responseInterceptor: (response: HttpApiResp) => {
      //优先执行自己的请求响应拦截器，在执行通用请求request的
      if (axiosClient.config.showLoading) {
        hideLoadingDialog()
      }
      Logger.debug('网络请求响应Response:' + `\n${JsonUtils.stringify(response.data)}`);
      if (response.status === 200) {
        const checkResultCode = response.config.checkResultCode;
        if (checkResultCode && response.data.errorCode != 0) {
          ToastUtils.show(response.data.errorMsg)
          return Promise.reject(response)
        }
        return Promise.resolve(response.data);
      } else {
        return Promise.reject(response);
      }
    },
    responseInterceptorCatch: (error: object) => {
      if (axiosClient.config.showLoading) {
        hideLoadingDialog();
      }
      Logger.error("网络请求响应异常" + error.toString())
      errorHandler(error);
      return Promise.reject(error);
    },
  }
});

export function errorHandler(error: object) {
  if (error instanceof AxiosError) {
    // ToastUtils.show(error.message)
  } else if (error != undefined && error['response'] != undefined && error['response']['status']) {
    switch (error['response']['status']) {
    // 401: 未登录
    // 未登录则跳转登录页面，并携带当前页面的路径
    // 在登录成功后返回当前页面，这一步需要在登录页操作。
      case 401:
        StorageUtils.put(StorageKeys.USER_TOKEN, "");
        break;
    // 403 token过期
    // 登录过期对用户进行提示
    // 清除本地token和清空vuex中token对象
    // 跳转登录页面
      case 403:
        // ToastUtils.show("登录过期，请重新登录");
      // 清除token
      // localStorage.removeItem('token');
        break;
    // 404请求不存在
      case 404:
        ToastUtils.show("网络请求不存在")
        break;

    // 其他错误，直接抛出错误提示
      default:
        ToastUtils.show(error['response']['data']['message'])
    }

  }
}