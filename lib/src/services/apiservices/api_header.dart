

import '../../../session/session.dart';

class ApiHeader {
  // api header
  static Map<String, String> header() => {
    'Content-Type': 'application/json'
  };

  static Map<String, String> tokenHeader() => {
        // "Accept": "application/json",
        // "Content-Type": "application/json",
        // "Content-Type": "/*",
        "Authorization": "Bearer ${Session.idToken() ?? ""}",
        
      };

  static Map<String, String> tokenWithContentTypeHeader() =>{
     "Content-Type": "application/json",
    "Authorization": "Bearer ${Session.idToken() ?? ""}",
  };

  // api token header
  static Map<String, String> tokenMultipart() => {
        'accept': 'application/json',
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer ${Session.idToken()}",
      };

  // api token header for add service
  static Map<String, String> tokenHeaderService(String token) => {
        "X-Requested-With": "XMLHttpRequest",
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
}
