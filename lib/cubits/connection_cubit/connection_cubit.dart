import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/cubits/connection_cubit/connection_states.dart';

class ConnectionCubit extends Cubit<ShopConnectionState>{
  ConnectionCubit() : super(ConnectionInitialState());
  static ConnectionCubit get(context) => BlocProvider.of(context);
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  void checkConnection(){
    _connectivitySubscription=_connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>;
  }
  void _updateConnectionStatus(ConnectivityResult? onData){
    if(onData == ConnectivityResult.mobile || onData == ConnectivityResult.wifi){
      emit(ConnectedState());
    }else{
      emit(NotConnectedState());
    }
  }
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}