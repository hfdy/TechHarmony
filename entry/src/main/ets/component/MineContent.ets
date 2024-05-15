/**
 * 我的
 */
interface KnowledgeData{
  content: string;
  img: Resource;
}

@Component
export struct MineContent {
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();
  private knowledgeList: Array<KnowledgeData> = [
    { content: "Navigation", img: $r('app.media.mine_coupon_ico')},
    { content: "Lifecycle", img: $r('app.media.mine_comment_lab') },
    { content: "DataBinding", img: $r('app.media.mine_service_ico') },
    { content: "LiveData", img: $r('app.media.mine_reduced_amount') },
    { content: "ViewModel", img: $r('app.media.mine_exp_ico') },
    { content: "Paging", img: $r('app.media.ic_mine_help') },
    { content: "Room", img: $r('app.media.mine_consign_earnings') },
    { content: "Hilt", img: $r('app.media.mine_sale_center') }
  ];
  private list: Array<string> = [
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
    Stack({alignContent: Alignment.TopStart}){
      Image($r('app.media.bg_mine_head'))
        .width('100%')
        .height(200)
      Scroll(this.scrollerForScroll){
        Column(){
          Image($r('app.media.mine_setting_ico'))
            .width(44)
            .height(44)
            .padding(12)
            .alignSelf(ItemAlign.End)
            .margin({top: 50})
            .onClick(()=>{
            })
          this.TopHeader()
          this.TopVideo()
          this.MiddleService()
          this.RecommendList()
        }
      }
      .scrollBar(BarState.Off)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f2f4")
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
      .margin({left: 10})
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
    .margin({top: 20, left: 15, right: 15})
    .backgroundColor("#fff")
    .borderRadius(10)
    .padding(15)
  }

  /**
   * 我的服务
   */
  @Builder
  MiddleService() {
    Column(){
      Text("我的服务")
        .fontColor("#000")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({top: 15, left: 15})
      Line()
        .width('100%')
        .height(1)
        .backgroundColor("#f0f2f4")
        .margin({top: 10})
      Grid(){
        ForEach(this.knowledgeList, (item: KnowledgeData, index: number) => {
          GridItem() {
            Column(){
              Image(item.img)
                .width(15)
                .height(15)
              Text(item.content)
                .fontSize(14)
                .fontColor("#4f5356")
                .margin({top: 5})
            }
            .alignItems(HorizontalAlign.Center)
          }
        }, (index?:number) => `${index}`)
      }
      .rowsTemplate('1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .layoutDirection(GridDirection.Column)
      .width('100%')
      .height(120)
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.PARENT_FIRST
      })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({top: 20, left: 15, right: 15})
    .backgroundColor("#fff")
    .borderRadius(10)
  }

  /**
   * 为你推荐
   */
  @Builder
  RecommendList(){
    Column(){
      Text("为你推荐")
        .fontSize(16)
        .fontColor("#000")
        .fontWeight(FontWeight.Bold)
      List({space: 15, scroller: this.scrollerForList}){
        ForEach(this.list, (item: string, index: number) => {
          ListItem() {
            Column(){
              Row(){
                Text("作者：Zeit")
                  .fontColor("#898e92")
                  .fontSize(12)
                Text("2024-05-15 11:29")
                  .fontColor("#898e92")
                  .fontSize(12)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
              .justifyContent(FlexAlign.SpaceBetween)

              Row(){
                Text("普京总统访华")
                  .fontColor("#222427")
                  .fontSize(12)
                  .maxLines(2)
                  .ellipsisMode(EllipsisMode.END)
                  .layoutWeight(1)
                Image($r('app.media.ic_collect_normal_new'))
                  .width(15)
                  .height(15)
              }
              .alignItems(VerticalAlign.Center)
              .margin({top: 10})

              Row(){
                Text("普京总统访哈尔滨")
                  .fontColor("#898e92")
                  .fontSize(12)
                  .maxLines(2)
                  .ellipsisMode(EllipsisMode.END)
                  .layoutWeight(1)
                Image($r('app.media.ic_collect_selected'))
                  .width(15)
                  .height(15)
              }
              .alignItems(VerticalAlign.Center)
              .margin({top: 10})
            }
            .backgroundColor("#fff")
            .border({ radius: 10 })
            .padding(10)
          }
          .onClick(()=>{
          })
        }, (index:number) => `${index}`)
      }
      .margin({top: 15})
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.PARENT_FIRST
      })
    }
    .margin({top: 20, left: 15, right: 15})
    .alignItems(HorizontalAlign.Start)
  }
}