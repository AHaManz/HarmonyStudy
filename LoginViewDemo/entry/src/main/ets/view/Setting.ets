@Preview
@Component
export default struct Setting {
  build() {
    Column() {
      Text('我的')
        .width('100%')
        .margin({
          top: '48vp',
          bottom: '12vp'
        })
        .fontWeight(700)
        .fontSize('26fp')
      Row() {
        Image($r('app.media.account'))
          .width('48vp')
          .height('48vp')
        Column() {
          Text('李先生').fontSize('20fp')
          Text('2010230@qq.com')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: '12vp'})
      }.alignItems(VerticalAlign.Center).width('100%')
    }
    .width('100%')
    .height('100%')
  }
}