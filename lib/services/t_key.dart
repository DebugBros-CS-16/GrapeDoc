
import 'localiziation.dart';

enum TKeys{
  settings,
  account,
  notifications,
  language,
  privacy,
  newforu,
  accountability,
  opportunity,
  develop,
  contact,
  about,
  policy,
  scan,
  Scantest,
  chat,
  blog,
  graphed,
  click,
  enjoy,
  rate,
  rateus,
  homenav,
  settingsnav,
  aboutnav,
  privacynav,
  ratenav,
  us,
  message

}

//TKeys.hello
extension TKeysExtention on TKeys {
  String get _string => toString().split('.')[1];

  String translate(context) {
    return LocalizationService.of(context).translate(_string) ?? '';
  }
}