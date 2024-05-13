/**
 * 启动页
 */
import router from '@ohos.router';
import { RoutePath } from '../constants/RoutePath';
@Entry
@Component
struct SplashPage {
  @State countDownTimer: number = 5;
  intervalID: number = 0;

  aboutToAppear() {
    this.intervalID = setInterval(()=>{
      this.countDownTimer--;
      if (this.countDownTimer === 1) {
        clearInterval(this.intervalID);
        router.pushUrl({url: RoutePath.MAIN_PAGE});
      }
    }, 1000);
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