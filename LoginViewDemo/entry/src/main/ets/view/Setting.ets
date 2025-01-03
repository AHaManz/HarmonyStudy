@Preview
@Component
export default struct Setting {
  @Builder
  settingCell(title: ResourceStr, img: Resource, others?: ResourceStr) {
    Row() {
      Row() {
        Image(img)
          .height('22vp')
          .margin({left: '16vp', right: '16vp'})
        Text(title)
          .fontSize('16fp')
      }
      if (others == undefined) {
        Image($r('app.media.right_grey'))
          .width('12vp')
          .height('24vp')
      } else {
        Toggle({type: ToggleType.Switch})
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: '8vp',
      right: '22vp'
    })
  }

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
          Text('李先生')
            .fontSize('20fp')
          Text('2010230@qq.com')
            .fontSize('12fp')
            .margin({top: '4vp'})
        }
        .alignItems(HorizontalAlign.Start)
        .margin({left: '12vp'})
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      List() {
        ListItem() {
          this.settingCell('推送通知', $r('app.media.news'), '开关')
        }
        .height('48vp')
        ListItem() {
          this.settingCell('字体调节大小', $r('app.media.data'))
        }
        .height('48vp')
        ListItem() {
          this.settingCell('菜单设置', $r('app.media.menu'))
        }
        .height('48vp')
        ListItem() {
          this.settingCell('清除缓存', $r('app.media.storage'))
        }
        .height('48vp')
        ListItem() {
          this.settingCell('隐私协议', $r('app.media.person_shield'))
        }
        .height('48vp')
        ListItem() {
          this.settingCell('关于', $r('app.media.about'))
        }
        .height('48vp')
      }
    }
    .width('100%')
    .height('100%')
  }
}