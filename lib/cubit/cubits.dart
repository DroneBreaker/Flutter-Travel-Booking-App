import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripmania/cubit/state.dart';
import 'package:tripmania/models/data.dart';
import 'package:tripmania/pages/detail.dart';
import 'package:tripmania/services/data.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  final Data data;
  late final places;

  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    } catch (e) {}
  }

  detailPage(DataModel data) {
    emit(DetailState(data));
  }

  goHome() {
    emit(LoadedState(places));
  }
}
