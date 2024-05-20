import { SystemAreaBean } from './SystemAreaBean';

export class WindowHelper{
  public static statusBarHeight: number;
  public static navigationBarHeight: number;

  public static setSystemArea(bean: SystemAreaBean) {
    WindowHelper.statusBarHeight = bean.statusBarHeight;
    WindowHelper.navigationBarHeight = bean.navigationBarHeight;
  }
}