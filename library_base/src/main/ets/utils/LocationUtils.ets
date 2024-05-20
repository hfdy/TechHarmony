import geoLocationManager from '@ohos.geoLocationManager';
import { ToastUtils } from './ToastUtils';
import { CallBackResult, sendFailCallBack, sendSuccessCallBack } from '../bean/DataCallBack';
import { Logger } from './Logger';
import SysPermissionUtils from './SysPermissionUtils';

/**
 * 定位
 */
export interface LocationInfo {
  latitude: number;
  longitude: number;
  adCode?: string;
  address?: string;
  city?: string;
  cityCode?: string;
  district?: string;
  poiName?: string;
  province?: string;
  street?: string;
  streetNum?: string;
}

export class LocationUtils {
  /**
   * 当前位置
   * @param context
   */
  static async getCurrentLocation(context: Context): Promise<CallBackResult> {
    return new Promise((resolve)=>{
      SysPermissionUtils.request(context, async (isGranted: boolean, permission: string) => {
        if (permission === "ohos.permission.LOCATION") {
          if (isGranted) {
            //定位开关是否开启
            let locationEnabled = geoLocationManager.isLocationEnabled();
            if (locationEnabled) {
              try {
                let location = await geoLocationManager.getCurrentLocation();
                if (location) {
                  Logger.info(`---------当前位置---------经度：${location.longitude} 纬度${location.latitude}`);
                  let data = await geoLocationManager.getAddressesFromLocation({
                    "locale": "zh",
                    "latitude": location.latitude,
                    "longitude": location.longitude,
                    "maxItems": 1
                  });
                  Logger.info(`---------当前位置逆地理编码---------：${JSON.stringify(data[0])}`);
                  let address: geoLocationManager.GeoAddress|null = null;
                  let desc = '';
                  if (data != null && data.length > 0) {
                    address = data[0];
                    if (address.descriptions != null && address.descriptions.length > 0) {
                      desc = address.descriptions[0];
                    }
                  } else {
                    address = null;
                  }
                  if (address != null) {
                    let info: LocationInfo = {
                      latitude: location.latitude,
                      longitude: location.longitude,
                      adCode: address.postalCode ? address.postalCode : "",
                      address: desc,
                      city: address.locality ? address.locality : "",
                      cityCode: '',
                      district: address.subLocality ? address.subLocality : "",
                      poiName: address.placeName ? address.placeName : "",
                      province: address.administrativeArea ? address.administrativeArea : "",
                      street: address.roadName ? address.roadName : "",
                      streetNum: address.subRoadName ? address.subRoadName : ""
                    };
                    resolve(sendSuccessCallBack(info));
                  } else {
                    let info: LocationInfo = {
                      latitude: location.latitude,
                      longitude: location.longitude,
                    };
                    resolve(sendSuccessCallBack(info));
                  }
                } else {
                  resolve(sendFailCallBack());
                }
              } catch (err) {
                if (err) {
                  Logger.info('location getCurrentLocation err = ' + err.code);
                }
                let info: LocationInfo = {
                  latitude: 0,
                  longitude: 0,
                };
                resolve(sendFailCallBack(info));
              }
            } else {
              ToastUtils.show("请开启定位");
              let info: LocationInfo = {
                latitude: 0,
                longitude: 0,
              };
              resolve(sendFailCallBack(info));
            }
          } else {
            ToastUtils.show("请开启定位权限");
            let info: LocationInfo = {
              latitude: 0,
              longitude: 0,
            };
            resolve(sendFailCallBack(info));
          }
        }
      }, 'ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION');
    });
  }
}