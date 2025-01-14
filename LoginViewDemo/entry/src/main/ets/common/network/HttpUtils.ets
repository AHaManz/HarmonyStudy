import { http } from '@kit.NetworkKit';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import ListInfo from '../../viewModel/ResponseData/ListInfo'
import ResponseData from '../../viewModel/ResponseData/ResponseData';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG: string = 'HttpUtils'

class Header {
  contenType: string;

  constructor(contenType: string) {
    this.contenType = contenType;
  }
}

export class HttpUtils {
  httpRequest: http.HttpRequest;

  constructor() {
    this.httpRequest = http.createHttp()
  }

  async getHttpRequest(cachDir: string): Promise<string> {
    let responsePictureUrl: string = '';
    await this.httpRequest.request("https://developer.huawei.com/system/modules/org.opencms.portal.template.core/resources/harmony/img/jiantou_right.svg", {
      method: http.RequestMethod.GET
    }).then((data: http.HttpResponse) => {
      let filePath = cachDir + '/test.svg';
      let file = fileIo.openSync(filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE);
      responsePictureUrl = fileUri.getUriFromPath(filePath)
      fileIo.writeSync(file.fd, data.result as ArrayBuffer);
      fileIo.closeSync(file.fd)
    })
    return responsePictureUrl
  }

  async postHttpRequest(): Promise<ListInfo[]> {
    let responseData: Array<ListInfo> = [];
    await this.httpRequest.request('https://svc-drcn.developer.huawei.com/community/servlet/consumer/partnerActivityService/v1/developer/activity/terminalActivities/list', {
      method: http.RequestMethod.POST,
      extraData: {
        'status': '1',
        'belong': '1',
        'language': 'cn',
        'needTop': 1,
        'displayChannel': [1, 3],
        'count': 4,
        'pagestart': 1,
        'type': '1,4,5,6'
      },
      header: new Header('application/json;charset=UTF-8')
    }).then((data: http.HttpResponse) => {
      let result: ResponseData = JSON.parse(data.result as string)
      responseData = result.value.list
    }).catch((err: Error) => {
      hilog.info(0x0000, TAG, JSON.stringify(err))
    })
    return responseData;
  }

  destoryHttpRequest() {
    this.httpRequest.destroy();
  }

}