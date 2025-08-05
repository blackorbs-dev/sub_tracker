import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/shared/presentation/cubit/home_cubit.dart';
import 'constants.dart';

extension ContextX on BuildContext{
  bool get isMobile =>
      MediaQuery.of(this).size.width < Breakpoints.mobile;

  void safePush(String route){
    if(isMobile) {
      push(route);
    } else{
      read<HomeCubit>().changeScreen(route);
    }
  }
}