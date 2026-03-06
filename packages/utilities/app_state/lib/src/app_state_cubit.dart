import 'package:flutter_bloc/flutter_bloc.dart';

class AppState {
  const AppState({this.totalDiscoveries = 0});
  final int totalDiscoveries;
}

class AppStateCubit extends Cubit<AppState> {
  AppStateCubit() : super(const AppState());

  void recordDiscovery() {
    emit(AppState(totalDiscoveries: state.totalDiscoveries + 1));
  }
}
