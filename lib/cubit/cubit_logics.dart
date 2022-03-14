import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripmania/cubit/cubits.dart';
import 'package:tripmania/cubit/state.dart';
import 'package:tripmania/pages/detail.dart';
import 'package:tripmania/pages/mainpage.dart';
import 'package:tripmania/pages/welcome.dart';

class CubitLogics extends StatefulWidget {
  const CubitLogics({Key? key}) : super(key: key);

  @override
  _CubitLogicsState createState() => _CubitLogicsState();
}

class _CubitLogicsState extends State<CubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(builder: (_, state) {
        if (state is WelcomeState) {
          return const WelcomePage();
        }
        if (state is LoadedState) {
          return const MainPage();
        }
        if (state is DetailState) {
          return const DetailPage();
        }
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
