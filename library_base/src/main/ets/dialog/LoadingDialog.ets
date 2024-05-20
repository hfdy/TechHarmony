/**
 * loading弹窗
 */
@CustomDialog
@Component
export struct LoadingDialog{
  @Prop loadingTips: string;
  @State rotateAngle: number = 0;
  private customDialogController: CustomDialogController;
  private timerId = setTimeout(() => {
    this.rotateAngle = 360;
  },500);

  build() {
    Column(){
      Image($r("app.media.load"))
        .width(50)
        .height(50)
        .rotate({angle: this.rotateAngle})
        .animation({
          duration: 500,
          iterations: -1,
          curve: Curve.Friction
        })
      Text(this.loadingTips)
        .fontSize(16)
        .fontColor(Color.White)
        .margin({top: 10})
    }
    .backgroundColor('#99000000')
    .width(150)
    .height(120)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }


}