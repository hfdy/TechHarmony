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
      List({space: 5}) {
        ForEach(this.leftListData, (item: string, index: number) => {
          ListItem() {
            Text(item)
              .width(100)
              .height(50)
              .fontSize(18)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIndex === index?"#fff":"#aaa")
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
              .height(80)
              .fontSize(18)
              .backgroundColor("#0159a5")
              .border({radius: 10})
          }
        }, (index?:number) => `${index}`)
      }
      .columnsTemplate('1fr 1fr')
      .layoutDirection(GridDirection.Row)
      .rowsGap(10)
      .columnsGap(10)
    }
    .width('100%')
    .height('100%')
  }
}