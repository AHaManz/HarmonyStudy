import { promptAction } from '@kit.ArkUI';
import { MainPage } from './MainPage';

@Extend(TextInput)
function inputStyle() {
  .height('45vp')
  .fontSize('18fp')
  .backgroundColor('#F1F3F5')
  .width('100%')
  .margin({top: 12})
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height('1vp')
  .backgroundColor('#33182431')
}

@Extend(Text)
function blueTextStyle() {
  .fontColor('#007DFF')
  .fontSize('14fp')
  .fontWeight(FontWeight.Medium)
}

@Entry
@Component
struct LoginPage {
  @State account: string = '';
  @State password: string = '';
  pathStack: NavPathStack = new NavPathStack();

  @Builder
  imageButton(src: Resource) {
    Button() {
      Image(src)
    }
    .width('48vp')
    .height('48vp')
    .backgroundColor('#F1F3F5')
  }

  login(result: boolean): void {
    if (this.account === '' || this.password === '') {
      promptAction.showToast({
        message: $r('app.string.input_empty_tips')
      })
    } else {
      this.pathStack.pushPathByName('MainPage', null)
    }
  }

  build() {
    Navigation(this.pathStack) {
      Column() {
        Image($r('app.media.logo'))
          .width('78vp')
          .height('78vp')
          .margin({ top: '150vp', bottom: '8vp' })
        Text('登录界面')
          .fontSize('24fp')
          .fontWeight(FontWeight.Medium)
        Text('登录账号以使用更多服务')
          .fontSize('16fp')
          .fontColor('#99182431')
          .margin({ bottom: '30vp', top: '8vp' })
        TextInput({placeholder: '账号'})
          .maxLength(11)
          .type(InputType.Number)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value
          })
        Line().lineStyle()
        TextInput({placeholder: '密码'})
          .maxLength(8)
          .type(InputType.Password)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value
          })
        Line().lineStyle()

        Row() {
          Text('短信验证码登录').blueTextStyle()
          Text('忘记密码').blueTextStyle()
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({top: '8vp'})

        Button('登录')
          .width('90%')
          .height('40vp')
          .fontSize('16fp')
          .backgroundColor('#007DFF')
          .margin({top: '48vp', bottom: '12vp'})
          .onClick(() => {
            this.login(true)
          })
        Text('注册账号')
          .fontColor('#007DFF')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)

        Text('其他登录方式')
          .fontColor('#838D97')
          .fontSize('12fp')
          .fontWeight(FontWeight.Medium)
          .margin({ top: '50vp', bottom: '12vp' })
        Row({space: 44}) {
          this.imageButton($r('app.media.login_method3'))
          this.imageButton($r('app.media.login_method3'))
          this.imageButton($r('app.media.login_method3'))
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
      .padding({left: '12vp', right: '12vp', bottom: '2 vp'})
    }
    .backgroundColor('#F1F3F5')
  }
}