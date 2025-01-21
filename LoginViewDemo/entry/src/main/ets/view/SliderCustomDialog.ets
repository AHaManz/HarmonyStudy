import  PreferenceUtil  from "../common/datadb/PreferencesUtil";

@Preview
@CustomDialog
export struct SliderCustomDialog {
  SliderCustomDialogController?: CustomDialogController;
  @State curValue: number = 0;
  @StorageLink('fontSizeOffset') fontSizeOffset: number = 0;

  build() {
    Column() {
      Text("字体大小调节")
        .fontSize('28fp')
        .fontWeight(FontWeight.Medium)
      Row() {
        Text('A')
          .fontSize('14fp')
          .fontColor(Color.Black)
        Slider({
          min: -4,
          max: 4,
          value: this.fontSizeOffset
        })
          .width('304vp')
          .margin({left: '4vp', right: '4vp'})
          .onChange((value) => {
            this.curValue = value;
          })
        Text('A')
          .fontSize('18fp')
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
      }

      .margin({top: '12vp'})
      Row() {
        Button('取消')
          .width('151vp')
          .height('41vp')
          .margin({left: '16vp', right: '16vp'})
          .onClick(() => {
            this.SliderCustomDialogController?.close();
          })
        Button('确认')
          .width('151vp')
          .height('41vp')
          .margin({right: '16vp'})
          .onClick(() => {
            PreferenceUtil.saveChangeFontSize(this.curValue)
            this.fontSizeOffset = this.curValue;
            this.SliderCustomDialogController?.close();
          })
      }
      .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding('16vp')
    .width('360vp')
    .borderRadius('16vp')
    .backgroundColor('#ffffff')
  }
}