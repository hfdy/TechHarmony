import preferences from '@ohos.data.preferences';
import dataPreferences from '@ohos.data.preferences'
/**
 * 项目全局存储，使用ohos.data.preferences
 */
const defaultPreferenceName = "NK"

export class StorageUtils {
  private constructor() {
  }

  static context = getContext();

  /**
   * 获取Prefer实例
   * @param preferenceName
   * @returns
   */
  static async getPreferences(preferenceName: string = defaultPreferenceName):Promise<preferences.Preferences>{
    return await dataPreferences.getPreferences(StorageUtils.context, preferenceName)
  }

  static async put(key: string, value: Object, preferenceName: string = defaultPreferenceName){
    // 获取实例
    StorageUtils.getPreferences(preferenceName).then((preferences)=>{
      preferences.put(key, value as preferences.ValueType);
      preferences.flush();
    });
  }
  /**
   * 获取值
   * @param key
   * @param defaultValue
   * @param preferenceName
   * @returns
   */
  static async get(key: string, defaultValue: Object = "", preferenceName: string = defaultPreferenceName) : Promise<Object>{
    // 获取实例
    let preferences = await StorageUtils.getPreferences(preferenceName)
    return preferences.get(key, defaultValue as preferences.ValueType);
  }

  /**
   * 删除值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(key: string, preferenceName: string = defaultPreferenceName) {
    let preferences = await StorageUtils.getPreferences(preferenceName)
    preferences.delete(key)
  }

  /**
   * 清空
   * @param preferenceName
   * @returns
   */
  static async clear(preferenceName: string = defaultPreferenceName) {
    let preferences = await StorageUtils.getPreferences(preferenceName)
    preferences.clear()
  }
}