import router from '@ohos.router';
import { Action, HeaderStyleConfig } from '../constants/HeaderStyleConfig';
import { VisiableState } from '../constants/Style';

@Component
export struct ActionHeaderComponent {
  headerStyle!: HeaderStyleConfig;
  private onBackClick?: () => void;
  @State customPopup: boolean = false;

  build() {
    if (VisiableState.HIDE != this.headerStyle.barState) {
      Column(){
        Stack({ alignContent: Alignment.Start }) {
          //背景
          Stack()
            .height($r('app.float.size_50'))
            .width("100%")
            .backgroundColor(this.headerStyle?.barColor)
          //中间文本
          Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
            Text(this.headerStyle?.title)
              .flexGrow(1)
              .textAlign(TextAlign.Center)
              .fontColor(this.headerStyle?.titleColor)
              .fontSize($r('app.float.size_text_16'))
              .align(Alignment.Center)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .height($r('app.float.size_50'))
          .margin({ left: $r('app.float.size_50'), right: $r('app.float.size_50') })
          .alignSelf(ItemAlign.Center)
          //返回、关闭
          this.leftComponent();
          //右边
          this.rightComponent();
        }
        .height($r('app.float.size_50'))
        .width("100%")
        //分割线
        Divider()
          .color("#999999")
          .height($r('app.float.size_1'))
          .width("100%")
      }
    }
  }

  @Builder
  leftComponent() {
    Row() {
      // 返回
      if (VisiableState.DEFAULT == this.headerStyle?.backState) {
        this.backComponent($r('app.media.core_ic_tob_bar_back_black'), ()=>{
          if (this.onBackClick != null) {
            this.onBackClick?.();
          } else {
            router.back();
          }
        });
      } else if (VisiableState.CUSTOM == this.headerStyle?.backState){
        this.backComponent($r('app.media.core_ic_tob_bar_back_white'), ()=>{
          if (this.onBackClick != null) {
            this.onBackClick?.();
          } else {
            router.back();
          }
        });
      }
      // 关闭
      if (VisiableState.DEFAULT == this.headerStyle?.closeState) {
        this.backComponent($r('app.media.core_ic_tob_bar_close_black'), ()=>{
          router.back();
        });
      } else if (VisiableState.CUSTOM == this.headerStyle?.closeState) {
        this.backComponent($r('app.media.core_ic_tob_bar_close_white'), ()=>{
          router.back();
        });
      }
    }
  }

  /**
   * 返回/关闭
   */
  @Builder
  backComponent(backRes: Resource, backClick: ()=>void) {
    Stack() {
      Image(backRes)
        .height($r('app.float.size_16'))
        .width($r('app.float.size_16'))
        .align(Alignment.Center)
        .onClick(() => {
          backClick();
        })
    }
    .height($r('app.float.size_50'))
    .width($r('app.float.size_50'))
  }

  @Builder
  rightComponent() {
    if (VisiableState.DEFAULT == this.headerStyle?.moreState) {
      this.moreComponent($r('app.media.core_ic_tob_bar_more_black'));
    } else if (VisiableState.CUSTOM == this.headerStyle?.moreState) {
      this.moreComponent($r('app.media.core_ic_tob_bar_more_white'));
    }
  }

  //更多
  @Builder
  moreComponent(res: Resource) {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.End, alignItems: ItemAlign.Center}) {
      Stack() {
        Image(res)
        .height($r('app.float.size_16'))
        .width($r('app.float.size_16'))
        .onClick(() => {
          this.customPopup = !this.customPopup;
        })
        .bindPopup(this.customPopup,{
          builder: this.popupBuilder,
          placement: Placement.Bottom,
          maskColor: '#33000000',
          popupColor: '#ffffff',
          enableArrow: true,
          showInSubWindow: false,
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.customPopup = false
            }
          }
        })
      }
      .height($r('app.float.size_50'))
      .width($r('app.float.size_50'))
    }
    .width("100%")
    .height($r('app.float.size_50'))
  }

  // popup构造器定义弹框内容
  @Builder
  popupBuilder() {
    Column() {
      if (this.headerStyle.moreAction != null && this.headerStyle.moreAction.length > 0) {
        List({initialIndex: 0 }) {
          ForEach(this.headerStyle.moreAction, (item: Action, index: number) => {
            ListItem() {
              Text(item.name)
                .width('100%').height(40).fontSize(16).fontColor('#333333')
                .textAlign(TextAlign.Center).backgroundColor('#ffffff')
            }.onClick(()=>{
              this.customPopup = false;
            })
          }, (item: Action, index: number) => index+"")
        }
        .listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 1, color: '#999999' }) // 每行之间的分界线
        .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
        .width('100%')
      }
    }
    .width($r('app.float.size_80'))
  }

}