/**
 * 首页
 */
@Component
export struct HomeContent {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#0159a5'
  @State currentIndex: number = 0
  private swiperController: SwiperController = new SwiperController();
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();

  private bannerData: Array<Resource> = [
    $r('app.media.ic_navi_home'),
    $r('app.media.ic_navi_categories'),
    $r('app.media.ic_navi_find'),
    $r('app.media.ic_navi_mine'),
  ];
  private tabData: Array<string> = [
    "短视频",
    "完整项目",
    "跨平台应用",
    "资源聚合",
    "短视频",
    "完整项目",
    "跨平台应用",
    "资源聚合"
  ];
  private listData: Array<string> = [
    "短视频",
    "完整项目",
    "跨平台应用",
    "资源聚合",
    "短视频",
    "完整项目",
    "跨平台应用",
    "资源聚合"
  ];

  build(){
    Scroll(this.scrollerForScroll){
      Column(){
        this.TopBanner()
        this.MiddleTab()
      }
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }

  /**
   * 顶部轮播
   */
  @Builder
  TopBanner() {
    Swiper(this.swiperController) {
      ForEach(this.bannerData, (item: Resource, index: number) => {
        Image(item)
          .width('100%')
          .height('100%')
      }, (index?: number) => `${index}`)
    }
    .width('100%')
    .height(160)
    .loop(true)
    .autoPlay(true)
    .interval(2000)
    .indicator(
      Indicator.dot()
      .itemWidth(8)
      .itemHeight(8)
      .selectedItemWidth(13)
      .selectedItemHeight(8)
      .color($r('app.color.color_aaa'))
      .selectedColor($r('app.color.color_0159a5'))
    )
  }

  /**
   * 中间吸顶tab
   */
  @Builder
  MiddleTab() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.tabData, (item: string, index: number) => {
        TabContent() {
          List({scroller: this.scrollerForList}){
            ForEach(this.listData, (item: string, index: number) => {
              ListItem() {
                Text(item)
                  .height(150)
              }
            }, (index?:number) => `${index}`)
          }
          .width('100%')
          .height('100%')
          .edgeEffect(EdgeEffect.None)
          .scrollBar(BarState.Off)
          .nestedScroll({
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
        }
        .tabBar(this.TabBuilder(index))
      }, (item: string) => item)
    }
    .vertical(false)
    .barMode(BarMode.Scrollable)
    .animationDuration(400)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({left: 10, right: 10})
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(this.tabData[index])
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .margin({ top: 18, bottom: 8 })
      Line()
        .width(20)
        .height(5)
        .borderRadius(5)
        .backgroundColor($r('app.color.color_0159a5'))
        .opacity(this.currentIndex === index ? 1 : 0)
    }
    .margin({right: 15})
  }
}