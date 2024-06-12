import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { GlobalThis, Logger, StorageUtils, SystemAreaBean, WindowHelper } from 'library_base';
import { common } from '@kit.AbilityKit';
import { AppUtil } from '@pura/harmony-utils';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    let context: common.UIAbilityContext = this.context;
    AppUtil.init(this.context,windowStage);
    GlobalThis.getInstance().setContext("EntryAbility", context);
    StorageUtils.context = context;
    // 1.获取应用主窗口
    let windowClass: window.Window;
    windowStage.getMainWindow((err, data: window.Window) => {
      if (err.code) {
        return;
      }
      windowClass = data;
      //设置系统状态栏颜色
      const systemBarProperties: window.SystemBarProperties = {
        //顶部状态栏颜色
        statusBarColor: "#ffffff",
        statusBarContentColor: "#000000",
        isStatusBarLightIcon: true
      }
      windowClass.setWindowSystemBarProperties(systemBarProperties);
      //获取状态栏和导航栏的高度
      let avoidArea: window.AvoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      let vpStatusBarHeight: number = px2vp(avoidArea.topRect.height)/3;
      let vpNavigationBarHeight: number = px2vp(avoidArea.bottomRect.height);

      let targetSystemArea: SystemAreaBean = {
        statusBarHeight: vpStatusBarHeight,
        navigationBarHeight: vpNavigationBarHeight
      }
      Logger.info("-------状态栏高度："+vpStatusBarHeight);
      // 保存到工具类中
      WindowHelper.setSystemArea(targetSystemArea);
    });

    windowStage.loadContent('pages/SplashPage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
