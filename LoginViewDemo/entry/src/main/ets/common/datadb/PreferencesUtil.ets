import { preferences } from "@kit.ArkData";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { BusinessError } from "@kit.BasicServicesKit";

const TAG = 'PreferencesUtil'
const KEY_APP_FONT_SIZE = 'appFontSize'

export class PreferenceUtil {
  preference?: preferences.Preferences;
  getFontPreference(context: Context) {
    this.preference = preferences.getPreferencesSync(context, {name: 'FontPreference'});
    hilog.info(0x0000, TAG, 'create success')
  }

  saveChangeFontSize(fontSizeOffset: number) {
    this.preference?.putSync(KEY_APP_FONT_SIZE, fontSizeOffset)
    this.preference?.flush((err: BusinessError) => {
      if (err) {
        hilog.error(0x0000, TAG, 'Failed to flush. code =' + err.code + ',' +
          ' message =' + err.message);
      } else {
        hilog.info(0x0000, TAG, 'Succeeded in flushing.');
      }
    })
  }

  getChangeFontSize(): number {
    let fontSizeOffset: number = 0;
    fontSizeOffset = this.preference?.getSync(KEY_APP_FONT_SIZE, 0) as number;
    return fontSizeOffset;
  }
}

export default new PreferenceUtil();