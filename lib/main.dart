import 'dart:io';
import 'package:byte_budget/bootstrap/bootstrap.dart';
import 'package:byte_budget/presentation/pages/home_page.dart';
import 'package:byte_budget/presentation/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  try {
    await bootstrapDependencies(getIt);
    runApp(const MyApp());
  } catch (error, stack) {
    getIt<Logger>().e('Exception handled $error, \n$stack');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      title: 'ByteBudget',
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
