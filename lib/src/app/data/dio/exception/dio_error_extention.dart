import 'package:easy_localization/easy_localization.dart';

String readableError(e) {
  if (e is Map<String, dynamic>) {
    print('111111111111111111');
    if ( e['message'] != null) {
      print('222222222222222');
      return '${e['message']}';
    }
    if (e.values.first is List) {
      return '${e.values.first.first}';
    }
    return '${e.values.first}';
  }
  // IDK what the wrong is this. so something weird happened;
  return tr('something_wrong');
}
