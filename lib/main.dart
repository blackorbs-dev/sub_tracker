import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sub_tracker/di/di.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_cubit.dart';
import 'di/get_it.dart';
import 'features/shared/data/app_database.dart';
import 'features/subscription/data/repository/background_task.dart';
import 'router/router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  initBackgroundWorker();
  await setupDependencies();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path
    ),
  );
  final database = await AppDatabase.create();

  runApp(
    DependencyContainer(
        database: database,
        child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (_, themeMode) =>
            MaterialApp.router(
              title: 'SubTracker',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            )
    );
  }
}
