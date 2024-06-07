// import 'dart:async';

// import 'package:connectivity/connectivity.dart';

// class ConnectivityClass {
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   ConnectivityResult listenToConnectivityChange() {
//     ConnectivityResult? result;
//     _connectivitySubscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult _result) {
//       print("connectivity result :::::::::::::::::::::::: ${_result.name}");
//       result = _result;
//       // Got a new connectivity status!
//     });
//     return result!;
//   }
// }
