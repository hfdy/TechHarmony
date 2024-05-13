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
    List({space: 15}) {
      ForEach(this.listData, (item: string, index: number) => {
        ListItem() {
          Row(){
            Column(){
              Text(item)
                .fontColor("#222427")
                .fontSize(15)
                .fontWeight(500)
              this.TagContent()
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            Image($r('app.media.ic_next'))
              .width(18)
              .height(18)
              .align(Alignment.Center)
              .margin({left: 15, right: 10})
          }
          .backgroundColor("#fff")
          .border({ radius: 10 })
          .padding({top: 10, bottom: 10, left: 10})
        }
        .onClick(()=>{
        })
      }, (index:number) => `${index}`)
    }
    .width('100%')
    .height('100%')
    .padding({left: 15, right: 15, top: 15})
    .backgroundColor('#f0f2f4')
    .alignListItem(ListItemAlign.Center)
  }

  @Builder
  TagContent(){
    Flex({direction: FlexDirection.Row, wrap: FlexWrap.Wrap}) {
      ForEach(this.innerListData, (item: string) => {
          Text(item)
            .fontSize(13)
            .fontColor("#898e92")
            .margin({top: 10, right: 10})
      }, (index:number) => `${index}`)
    }
  }
}