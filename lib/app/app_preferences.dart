
import 'package:domina_app/app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG="PREFS_KEY_LANG";
const String PREFS_KEY_LS_USER_LOGGED_IN="PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN="PREFS_KEY_TOKEN";
const String PREFS_KEY_USER_FIRSTNAME="PREFS_KEY_USER_FIRSTNAME";
const String PREFS_KEY_USER_LASTNAME="PREFS_KEY_USER_LASTNAME";
const String PREFS_KEY_USER_EMAIL="PREFS_KEY_USER_EMAIL";
const String PREFS_KEY_USER_WHATSAPP="PREFS_KEY_USER_WHATSAPP";
const String PREFS_KEY_USER_IMAGE="PREFS_KEY_USER_IMAGE";
const String PREFS_KEY_Type="PREFS_KEY_Type";

class  AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);


  // on board is logging
  Future<bool> setLoggedIn(String token,int type)async{
    await   _sharedPreferences.setBool(PREFS_KEY_LS_USER_LOGGED_IN, true);
    await  _sharedPreferences.setString(PREFS_KEY_TOKEN,token );
    await _sharedPreferences.setInt(PREFS_KEY_Type,type);
    // reload();
    return true;
  }

  Future<bool> isUserLoggedIn()async{
    Constants.type= _sharedPreferences.getInt(PREFS_KEY_Type)??0 ;
    return _sharedPreferences.getBool(PREFS_KEY_LS_USER_LOGGED_IN) ?? false;
  }


  Future<String?> getToken()async{
    return _sharedPreferences.getString(PREFS_KEY_TOKEN)  ;
  }
  Future<void> signOut()async{
    await _sharedPreferences.remove(PREFS_KEY_TOKEN);
    await _sharedPreferences.remove(PREFS_KEY_LS_USER_LOGGED_IN);
    await _sharedPreferences.remove(PREFS_KEY_Type);

  }
  reload()async{
    await _sharedPreferences.reload();

  }


}