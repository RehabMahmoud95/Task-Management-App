part of 'connectivity_bloc.dart';

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}


final class ChangeConnectivityValue extends ConnectivityEvent {
  ConnectivityResult result;
  ChangeConnectivityValue(this.result);
   @override
  List<Object> get props => [result];
}
