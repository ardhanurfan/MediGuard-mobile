class UrlService {
  // String baseUrl = 'https://gens.my.id/api/';
  static String baseUrl = 'https://mediguard.ardhanurfan.my.id/api/';
  // static String baseUrl = 'http://10.0.2.2:3000/api/';
  static Uri api(String param) {
    return Uri.parse(baseUrl + param);
  }
}
