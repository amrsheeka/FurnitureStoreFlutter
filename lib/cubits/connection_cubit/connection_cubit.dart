import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/cubits/connection_cubit/connection_states.dart';

class ConnectionCubit extends Cubit<ShopConnectionState> {
  ConnectionCubit() : super(ConnectionInitialState());
  static ConnectionCubit get(context) => BlocProvider.of(context);

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  void checkConnection() {
    // Listen for changes in connectivity status
    // _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      emit(ConnectedState());
    } else {
      emit(NotConnectedState());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
