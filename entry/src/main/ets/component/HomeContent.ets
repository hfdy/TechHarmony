/**
 * 首页
 */
@Component
export struct HomeContent {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#0159a5'
  @State currentIndex: number = 0
  private swiperController: SwiperController = new SwiperController();
  private controller: TabsController = new TabsController()

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
    Scroll(){
      Column(){
        this.TopBanner()
        List({space: 10}){
          ListItemGroup({ header: this.MiddleTab() }) {
            ForEach(this.listData, (item: string, index: number) => {
              ListItem() {
                Text(item)
              }
            }, (index?:number) => `${index}`)
          }
        }
        .sticky(StickyStyle.Header)  // 设置吸顶，实现粘性标题效果
        .width('100%')
        .height('100%')
        .layoutWeight(1)
      }
    }
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
    .height(150)
    .loop(true)
    .autoPlay(true)
    .interval(2000)
    .indicatorStyle({
      size: 20,
      color: '#0159a5'
    })
  }

  /**
   * 中间吸顶tab
   */
  @Builder
  MiddleTab() {
    Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
      ForEach(this.tabData, (item: string, index: number) => {
        TabContent() {
        }
        .tabBar(this.TabBuilder(index))
      }, (item: string) => item)
    }
    .vertical(false)
    .barMode(BarMode.Scrollable)
    .animationDuration(400)
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width('100%')
    .height(56)
    .backgroundColor('#F1F3F5')
  }

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(this.tabData[index])
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }
}