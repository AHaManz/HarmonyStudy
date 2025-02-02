import { HttpUtils } from "../common/network/HttpUtils";
import ItemData from "../viewModel/ItemData"
import mainViewModel from "../viewModel/MainViewModel"
import ListInfo from "../viewModel/ResponseData/ListInfo";
import { common } from '@kit.AbilityKit';
import { RCPUtils } from "../common/network/RCPUtils";

@Preview
@Component
export default struct Home {
  @State httpGridItems: Array<ListInfo> = [];
  @State pictureUrl: string = '';
  @StorageLink('fontSizeOffset') fontSizeOffset: number = 0;

  private context = getContext(this) as common.UIAbilityContext;
  private applicationContext = this.context.getApplicationContext();
  private cachDir = this.applicationContext.filesDir;

  async aboutToAppear(): Promise<void> {
    // let httpUtil = new HttpUtils();
    // await httpUtil.postHttpRequest().then((value: ListInfo[]) => {
    //   this.httpGridItems = value;
    // });
    // await httpUtil.getHttpRequest(this.cachDir).then((value: string) => {
    //   this.pictureUrl = value;
    // })
    // httpUtil.destoryHttpRequest();

    let rcpUtils = new RCPUtils();
    await rcpUtils.postHttpRequest().then((value: ListInfo[]) => {
      this.httpGridItems = value;
    });
    await rcpUtils.getHttpRequest(this.cachDir).then((value: string) => {
      this.pictureUrl = value;
    })
    rcpUtils.destoryHttpRequest();
  }

  build() {
    Column() {
      Text('首页')
        .width('100%')
        .margin({top: '48vp', bottom: '12vp'})
        .fontSize(26 + this.fontSizeOffset)
        .fontWeight(700)
      Scroll() {
        Column() {
          Swiper() {
            ForEach(mainViewModel.getSwiperImages(), (img: Resource) => {
              Image(img)
                .width('100%')
                .borderRadius('16vp')
            }, (img: Resource) => JSON.stringify(img.id))
          }
          .autoPlay(true)
          Grid() {
            ForEach(mainViewModel.getFirstGridData(), (item: ItemData) => {
              GridItem() {
                Column() {
                  Image(item.img)
                    .width('40vp').height('40vp')
                  Text(item.title).fontSize(12 + this.fontSizeOffset).margin({top: '4vp'})
                }
              }
            }, (item: ItemData) => JSON.stringify(item))
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .rowsGap('12vp')
          .padding({top: '12vp', bottom: '12vp'})
          .backgroundImage($r('app.media.backgroundImage'))
          .backgroundColor('#ffffff')
          .width('100%')
          .height('156vp')
          .borderRadius('16fp')
          .margin({top: '12vp'})

          Text('列表')
            .fontSize(18 + this.fontSizeOffset)
            .fontWeight(700)
            .width('100%')
            .margin({
              top: '18vp',
              bottom: '8vp'
            })

          List() {
            ForEach(this.httpGridItems, (secondItem: ListInfo) => {
              ListItem() {
                Row() {
                  Image(secondItem.indexNavPic)
                    .width('130vp')
                    .height('80vp')
                    .objectFit(ImageFit.TOP_START)
                    .borderRadius('8vp')
                    .margin({right: '12vp'})
                  Column() {
                    Text(secondItem.activityName)
                      .width('190vp')
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .maxLines(1)
                      .fontSize(16 + this.fontSizeOffset)
                      .fontWeight(FontWeight.Medium)
                    Text(secondItem.theme)
                      .width('190vp')
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .maxLines(2)
                      .margin({ top: '4vp' })
                      .fontSize(12 + this.fontSizeOffset)
                      .fontColor('#99182431')
                    Row() {
                      Image(this.pictureUrl)
                        .width('20vp')
                        .opacity(0.5)
                    }
                    .width('170vp')
                    .margin({ top: '10.5vp' })
                    .justifyContent(FlexAlign.End)
                    .alignItems(VerticalAlign.Bottom)
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .padding({
                  left: '12vp',
                  right: '12vp',
                  top: '12vp',
                  bottom: '12vp'
                })
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .margin({
                bottom: '8vp'
              })
              .borderRadius('16vp')
              .backgroundColor('#ffffff')
              .borderRadius(20)
              .align(Alignment.TopStart)
              .width('100%')
            }, (item: ListInfo) => JSON.stringify(item))
          }
          .width('100%')
        }

      }
      .height('85%')
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)
      }

    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
  }
}