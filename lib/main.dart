import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/app/app.dart';
import 'package:to_do_app/core/bloc/bloc_observer.dart';
import 'package:to_do_app/core/database/cache_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  Bloc.observer = MyBlocObserver();
  await sl<CacheHelper>().init();
  sl<SqfliteHelper>().initDb();
  await ScreenUtil.ensureScreenSize();
  runApp(BlocProvider(
    create: (context) => TaskCubit()
      ..getTheme()
      ..getTasks(),
    child: const MyApp(),
  ));
}
