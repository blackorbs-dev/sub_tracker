import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../router/routes.dart';

class HomeCubit extends Cubit<String> {
  HomeCubit() : super(Screen.wallet);

  void changeScreen(String screen) => emit(screen);
}
