/**
 * 分类
 */
@Component
export struct CategoriesContent {
  @State currentIndex: number = 0

  private leftListData: Array<string> = [
    "常用网站",
    "速查",
    "查看源码",
    "优秀的博客",
    "个人博客",
    "公司博客",
    "Flutter",
    "开发社区"
  ];
  private rightListData: Array<string> = [
    "google开发者",
    "Github",
    "掘金",
    "CSDN",
    "简书",
    "开发者头条",
    "leetcode",
    "maven仓库"
  ];

  build(){
    Row(){
      List({space: 3}) {
        ForEach(this.leftListData, (item: string, index: number) => {
          ListItem() {
            Text(item)
              .width(100)
              .height(50)
              .fontSize(14)
              .fontColor('#222427')
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIndex === index?"#fff":"#f0f2f4")
              .borderRadius({topRight: this.currentIndex + 1 === index? 5 : 0, bottomRight: this.currentIndex - 1 === index? 5 : 0})
          }
          .onClick(()=>{
            this.currentIndex = index;
          })
        }, (index?:number) => `${index}`)
      }
      .backgroundColor('#fff')
      .alignListItem(ListItemAlign.Center)
      .width(100)
      .height('100%')

      Grid() {
        ForEach(this.rightListData, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .width('100%')
              .height(60)
              .fontSize(12)
              .fontColor("#4F5356")
              .backgroundColor("#b2d0e9")
              .border({radius: 10})
              .textAlign(TextAlign.Center)
          }
        }, (index?:number) => `${index}`)
      }
      .columnsTemplate('1fr 1fr')
      .layoutDirection(GridDirection.Column)
      .rowsGap(10)
      .columnsGap(10)
      .layoutWeight(1)
      .margin({ left: 10, right: 10})
    }
    .width('100%')
    .height('100%')
  }
}