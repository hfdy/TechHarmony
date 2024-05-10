/**
 * 体系
 */
@Component
export struct FindContent {
  private listData: Array<string> = [
    "常用网站",
    "速查",
    "查看源码",
    "优秀的博客",
    "个人博客",
    "公司博客",
    "Flutter",
    "开发社区"
  ];
  private innerListData: Array<string> = [
    "常用网站",
    "速查",
    "查看源码",
    "优秀的博客",
    "个人博客",
    "公司博客",
    "Flutter",
    "开发社区"
  ];

  build(){
    List({space: 5}) {
      ForEach(this.listData, (item: string, index: number) => {
        ListItem() {
          Row(){
            Column(){
              Text(item)
                .fontColor("#000")
                .fontSize(16)
                .fontWeight(300)
              this.TagContent()
            }
            .layoutWeight(1)
            Image($r('app.media.ic_next'))
              .width(18)
              .height(18)
              .align(Alignment.Center)
              .margin({left: 15, right: 10})
          }
          .backgroundColor("#fff")
          .border({ radius: 5 })
        }
        .onClick(()=>{
        })
      }, (index?:number) => `${index}`)
    }
    .width('100%')
    .height('100%')
    .margin({left: 15, right: 15})
    .backgroundColor('#aaa')
    .alignListItem(ListItemAlign.Center)
  }

  @Builder
  TagContent(){
    List({ space: 10 }) {
      ForEach(this.innerListData, (item) => {
        ListItem() {
          Text(item)
            .fontSize(14)
            .fontColor("#f5f5f5")
        }
      }, item => item)
    }
    .alignListItem(ListItemAlign.Start)
    .margin({ top: 10 })
  }
}