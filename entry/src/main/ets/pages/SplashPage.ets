/**
 * 启动页
 */
import router from '@ohos.router';
import { WindowHelper } from 'library_base/Index';
import { RoutePath } from '../constants/RoutePath';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct SplashPage {
  @State countDownTimer: number = 5;
  @StorageProp("MainWindow") mainWindow: window.Window | null = null;
  intervalID: number = 0;
  private statusBarHeight = WindowHelper.statusBarHeight;

  aboutToAppear() {
    this.intervalID = setInterval(()=>{
      this.countDownTimer--;
      if (this.countDownTimer === 1) {
        clearInterval(this.intervalID);
        router.pushUrl({url: RoutePath.MAIN_PAGE});
      }
    }, 1000);
    let names: Array<'status' | 'navigation'> = ['status'];
    this.mainWindow?.setWindowSystemBarEnable(names, (err) => {
      if (err.code) {
        return;
      }
    });
    this.mainWindow?.setWindowLayoutFullScreen(true);
  }

  build() {
    Stack({alignContent: Alignment.TopEnd}){
      Image($r("app.media.bg_welcome"))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
      Text(`${this.countDownTimer}s`)
        .fontColor("#fff")
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .border({radius: 10})
        .backgroundColor('#aaa')
        .height(40)
        .padding({left: 30, right: 30})
        .margin({top: 15, right: 15})
        .onClick(()=>{
          clearInterval(this.intervalID);
          router.pushUrl({url: RoutePath.MAIN_PAGE});
        })
    }
  }

  aboutToDisappear(){
    clearInterval(this.intervalID);
  }
}