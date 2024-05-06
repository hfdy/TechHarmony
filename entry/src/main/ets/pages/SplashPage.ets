/**
 * 启动页
 */
@Entry
@Component
struct SplashPage {
  @State countDownTimer: number = 5;
  intervalID: number = 5;

  aboutToAppear() {
    this.intervalID = setInterval(function() {
      this.countDownTimer--;
    }, 1000);
  }

  build() {
    Stack({alignContent: Alignment.TopStart}){
      Image($r("app.media.icon"))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
      Text(`${this.countDownTimer}`)
        .fontColor("#fff")
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .border({radius: 10})
        .backgroundColor('#aaa')
        .width(100)
        .height(50)
        .align(Alignment.TopEnd)
    }
  }

  aboutToDisappear(){
    clearInterval(this.intervalID);
  }
}