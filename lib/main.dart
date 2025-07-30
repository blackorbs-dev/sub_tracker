import 'package:flutter/material.dart';
import 'package:sub_tracker/di.dart';

import 'core/theme/theme.dart';
import 'features/shared/data/database/database.dart';
import 'router/router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp.router(
      title: 'SubTracker',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
