import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityEvent>((event, emit) {
      try {
        if (event is ChangeConnectivityValue) {
          late StreamSubscription<ConnectivityResult> _connectivitySubscription;
          // ConnectivityResult? result;
          _connectivitySubscription = Connectivity()
              .onConnectivityChanged
              .listen((ConnectivityResult _result) {
            print("result of connectivity : ${_result.name}");
            emit(ConnectivityValue(event.result));
          });
        }
      } catch (e) {
        print("error in connectivity bloc : $e");
      }
    });
  }
}
