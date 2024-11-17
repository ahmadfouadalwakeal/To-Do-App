import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/theme/app_theme.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/auth/presentation/screens/splash_screen/splash_screen.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_cubit.dart';
import 'package:to_do_app/features/tasks/presentation/cubit/cubit/task_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return MaterialApp(
                theme: getAppLightTheme(),
                darkTheme: getAppDarkTheme(),
                themeMode: BlocProvider.of<TaskCubit>(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.dark,
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
              );
            },
          );
        });
  }
}
