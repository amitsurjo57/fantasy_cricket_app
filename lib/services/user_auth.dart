import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  final String _userToken = "user-token";

  Future<void> saveUserToken(String? token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_userToken, token ?? '');
  }

  Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_userToken);
    return token;
  }


  Future<bool> isLoggedIn() async {
    String? token = await getUserToken();
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<void> clearData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
