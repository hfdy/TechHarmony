/**
 * 我的
 */
@Component
export struct MineContent {
  build(){
    Stack({alignContent: Alignment.TopStart}){
      Image($r('app.media.bg_mine_head'))
        .width('100%')
        .height(236)
      Stack({alignContent: Alignment.TopEnd}){
        Image($r('app.media.mine_setting_ico'))
          .width(44)
          .height(44)
          .padding(12)
          .margin({top: 46})
          .onClick(()=>{
          })
      }
      .width('100%')
      Column(){
        this.TopHeader()
        this.TopVideo()
      }
      .margin({top: 100})
    }
    .width("100%")
    .height("100%")
  }

  /**
   * 顶部
   */
  @Builder
  TopHeader() {
    Row(){
      Image($r('app.media.default_head'))
        .width(54)
        .height(54)
        .margin({left: 12})
      Column(){
        Text("未登录")
          .fontColor("#222427")
          .fontSize(18)
        Text("登录后了解更多知识")
          .fontColor("#4F5356")
          .fontSize(14)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .margin({top: 5})
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }

  /**
   * 顶部视频
   */
  @Builder
  TopVideo() {
    Row(){
      Row(){
        Image($r('app.media.ic_mine_work'))
          .width(20)
          .height(20)
        Text("短视频")
          .fontColor("#000")
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .margin({left: 5})
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)
      Text("-我的作品")
        .fontColor("#000")
        .fontSize(12)
      Line()
        .width(1)
        .height(12)
        .backgroundColor("#898989")
        .margin({left: 16, right: 16})
      Text("-我喜欢的")
        .fontColor("#000")
        .fontSize(12)
    }
    .margin({top: 10, left: 15, right: 15})
    .backgroundColor("#fff")
    .borderRadius(10)
    .padding(15)
  }

}