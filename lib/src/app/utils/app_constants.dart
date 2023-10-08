abstract class Connection {
  Connection._();
  static const base = 'banknote.dev.tqnia.me';
  static const baseURL = 'https://$base/api/';
  static const storage = '${baseURL}uploads/';
  
}

class AppConstants {
  static const String APP_NAME = 'banknote';
  static const String THEME = 'theme';
}
