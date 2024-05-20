import { EKeyType, EKeyboardType, IKeyAttribute } from '../constants/KeyboardConstants';

/**
 * 自定义键盘
 */
@CustomDialog
@Component
export struct CustomKeyboard {
  @Prop items: IKeyAttribute[];
  @Prop curKeyboardType: EKeyboardType;
  @Link inputValue: string;
  private controller: TextInputController = new TextInputController();
  private keyboardController: CustomDialogController;

  private onKeyboardEvent: Function | null = null;
  private rowSpace: number = 5; // 行间距
  private rowCount: number = 5; // 行数
  private columnSpace: number = 5; // 列间距
  private itemHeight: number = 42; // Item尺寸

  @Builder
  myGridItem(item: IKeyAttribute) {
    if (typeof item.label === 'object') {
      Image(item.label)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
    } else {
      Text(item.label)
        .fontSize(item.fontSize)
        .fontColor(item.fontColor)
        .fontWeight(FontWeight.Bold)
    }
  }

  build() {
    Column() {
      Grid() {
        // 性能知识点：此处数据项较少，一屏内可以展示所有数据项，使用了ForEach。在数据项多的列表git滚动场景下，推荐使用LazyForEach。
        ForEach(this.items, (item: IKeyAttribute) => {
          GridItem() {
            this.myGridItem(item)
          }
          .width("100%")
          .height(this.itemHeight)
          .rowStart(item?.position?.[0])
          .rowEnd(item?.position?.[1])
          .columnStart(item?.position?.[2])
          .columnEnd(item?.position?.[3])
          .backgroundColor(item.backgroundColor)
          .borderRadius(4)
          .onClick(() => {
            this.onKeyboardEvent?.(item);
            if (item.type === EKeyType.CAPSLOCK && typeof item.label === 'object') {
              if (this.curKeyboardType === EKeyboardType.LOWERCASE) {
                item.label = $r("app.media.capslock_white");
              } else {
                item.label = $r("app.media.capslock_black");
              }
            }
          })
        }, (item: IKeyAttribute, index: number) => JSON.stringify(item) + index)
      }
      .margin({ top: 20, bottom: 20 })
      .columnsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")
      .rowsTemplate("1fr 1fr 1fr 1fr 1fr") // Grid高度均分成4份
      .rowsGap(this.rowSpace) // 设置行间距
      .columnsGap(this.columnSpace) // 设置列间距
      .width("100%")
      .height(this.itemHeight * this.rowCount + this.rowSpace * (this.rowCount - 1))
    }
    .width("100%")
    .padding({ left: this.columnSpace, right: this.columnSpace})
    .backgroundColor(Color.Black)
  }
}