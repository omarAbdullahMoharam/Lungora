import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:provider/provider.dart';

import 'core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  // AuthRepo authRepo = AuthRepo(ApiServices(Dio()));
  // getIt<AuthRepo>().login("email@gmail.com", "Password_12");
  // getIt<AuthRepo>().forgetUserPassword("omarmoharam790@gmail.com");
  // authRepo.register("email@gmail.com", "Password_12", "emailname");
  // getIt<AuthRepo>()
  //     .register("Adel", "adel@gmail.com", "Adel@1234", "Adel@1234");

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..loadTheme(),
      child: const Lungora(),
    ),
  );
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class Lungora extends StatelessWidget {
  const Lungora({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return ScreenUtilInit(
      designSize: Size(defualtWidth, defualtHeight),
      minTextAdapt: false,
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              scaffoldMessengerKey: scaffoldMessengerKey,
              routerConfig: AppRoture.router,
              debugShowCheckedModeBanner: false,
              title: 'Lungora',
              theme: ThemeData(
                brightness: Brightness.light,
                colorScheme: const ColorScheme.light(
                  primary: kPrimaryColor,
                  secondary: kSecondaryColor,
                ),
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(
                  bodyLarge: TextStyle(color: Colors.black),
                  bodyMedium: TextStyle(color: Colors.black87),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: const ColorScheme.dark(
                  primary: kPrimaryColor,
                  secondary: kSecondaryColor,
                ),
                scaffoldBackgroundColor: Colors.black87,
                textTheme: TextTheme(
                  bodyLarge: TextStyle(color: Colors.white),
                  bodyMedium: TextStyle(color: Colors.white70),
                ),
              ),
              themeMode: themeProvider.themeMode,
            );
          },
        ),
      ),
    );
  }
}
