import http from '@ohos.net.http';
import RequestMethod from '@ohos.net.http';
import ResponseCode from '@ohos.net.http';
import { Logger } from './Logger';

/**
 * http请求
 * @param url
 */
export async function httpRequest(url: string, method: string, reqHeader: Object, timeout: number, data: Object) :Promise<Object> {
  return new Promise(async (resolve, reject)=>{
    try {
      let httpRequest = http.createHttp();
      let response = await httpRequest.request(url,
        {
          method: method == "get"?RequestMethod.RequestMethod.GET:RequestMethod.RequestMethod.POST,
          header: reqHeader,
          readTimeout: timeout,
          connectTimeout: timeout,
          extraData: data
        }
      );
      let code = response.responseCode;
      let result = "";
      if(ResponseCode.ResponseCode.OK == code) {
        result = JSON.stringify(response.result);
        Logger.info("result: " + result);
      } else {
        result = "";
        Logger.info("response code: " + code);
      }
      resolve(result);
    }catch (error) {
      Logger.info("response: " + error);
      reject(error);
    }
  });
}