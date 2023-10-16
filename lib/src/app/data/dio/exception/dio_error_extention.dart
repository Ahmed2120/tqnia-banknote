import 'package:easy_localization/easy_localization.dart';

String readableError(e) {
  if (e is Map<String, dynamic>) {
    if (!e['status'] && e['message'] != null) {
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
