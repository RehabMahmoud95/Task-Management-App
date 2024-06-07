part of 'connectivity_bloc.dart';

sealed class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

final class ConnectivityInitial extends ConnectivityState {}


final class ConnectivityValue extends ConnectivityState {
  ConnectivityResult result;
  ConnectivityValue(this.result);
   @override
  List<Object> get props => [result];
}


