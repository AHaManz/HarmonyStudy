import { rcp } from "@kit.RemoteCommunicationKit"
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import ListInfo from '../../viewModel/ResponseData/ListInfo'
import ResponseData from '../../viewModel/ResponseData/ResponseData';

const TAG: string = 'RCPUtils'

export class RCPUtils {
    rcpSession: rcp.Session;

  constructor() {
    this.rcpSession = rcp.createSession();
  }

  async getHttpRequest(cachDir: string): Promise<string> {
    let responsePictureUrl: string = '';
    await this.rcpSession.get("https://developer.huawei.com/system/modules/org.opencms.portal.template.core/resources/harmony/img/jiantou_right.svg")
      .then((response) => {
      let filePath = cachDir + '/test.svg';
      let file = fileIo.openSync(filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE);
      responsePictureUrl = fileUri.getUriFromPath(filePath)
      fileIo.writeSync(file.fd, response.body);
      fileIo.closeSync(file.fd)
    }).catch((err: BusinessError) => {
        hilog.info(0x0000, TAG, JSON.stringify(err))
    })
    return responsePictureUrl
  }

  async postHttpRequest(): Promise<ListInfo[]> {
    let responseData: Array<ListInfo> = [];
    let requestContent: rcp.RequestContent = {
      'status': '1',
      'belong': '1',
      'language': 'cn',
      'needTop': 1,
      'displayChannel': [1, 3],
      'count': 4,
      'pagestart': 1,
      'type': '1,4,5,6'
    }
    await this.rcpSession
      .post('https://svc-drcn.developer.huawei.com/community/servlet/consumer/partnerActivityService/v1/developer/activity/terminalActivities/list'
        ,requestContent)
      .then((response) => {
      let result: ResponseData = response.toJSON() as ResponseData;
      responseData = result.value.list
    }).catch((err: BusinessError) => {
      hilog.info(0x0000, TAG, JSON.stringify(err))
    })
    return responseData;
  }

  destoryHttpRequest() {
    this.rcpSession.close();
  }
}