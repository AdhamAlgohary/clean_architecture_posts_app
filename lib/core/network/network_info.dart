import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplWithConnectionChecker implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  NetworkInfoImplWithConnectionChecker(
      {required this.internetConnectionChecker});
  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
