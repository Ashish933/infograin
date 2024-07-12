
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slice_ledger/session/session_key.dart';



class Session {
  static late Session _appPreferences;
  static SharedPreferences? sharedPreferences;

  Session._internal() {
    init();
  }

  factory Session() {
    _appPreferences = Session._internal();
    return _appPreferences;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }





  static String? idToken() => sharedPreferences!.getString(SessionKey.idToken.toString()) ?? "";


  static bool isLogin() =>
      sharedPreferences!.getBool(SessionKey.isLogin) ?? false;



  static String userName() =>
      sharedPreferences!.getString(SessionKey.userName) ?? "";
  static String userPassword() =>
      sharedPreferences!.getString(SessionKey.userPassword) ?? "";

  // save
  static Future<void> saveToken(String idToken) async {
    await sharedPreferences!.setString(SessionKey.idToken, idToken);
  }



  static Future<void> saveUser(String user) async {
    try {
      await sharedPreferences!.setString(SessionKey.user, user);
    } catch (e) {
      print("erorr on $e");
    }
  }

  static Future<void> saveIsLogin(bool isLogin) async {
    await sharedPreferences!.setBool(SessionKey.isLogin, isLogin);
  }

  static Future<void> saveUserName(String userName) async {
    await sharedPreferences!.setString(SessionKey.userName, userName);
  }

  static Future<void> saveUserPassword(String userPassword) async {
    await sharedPreferences!.setString(SessionKey.userPassword, userPassword);
  }

  static sessionClear() {
    sharedPreferences!.clear();
    print("session clear");
  }
}
