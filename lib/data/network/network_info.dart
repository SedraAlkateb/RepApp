

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo{
Future <bool>get isConnected;
}

class NetWorkInfoImpl implements NetworkInfo{
final  InternetConnectionChecker _internetConnectionChecker;
  NetWorkInfoImpl(this._internetConnectionChecker);
  @override
  Future<bool> get isConnected async => await _internetConnectionChecker.isActivelyChecking;

}