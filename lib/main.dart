import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  await dotenv.load();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool onBoarding = sharedPreferences.getBool('onboarding') ?? false;
  final isValid = await SecureStorageService.isTokenValid();

  late final String initialRoute;
  if (!onBoarding) {
    initialRoute = AppRouter.kOnbordingView;
  } else if (isValid) {
    initialRoute = AppRouter.kHomeView;
  } else {
    initialRoute = AppRouter.kAuthView;
  }
  AppRouter.router.go(initialRoute);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..loadTheme(),
      child: Lungora(onBoarding: onBoarding),
    ),
  );
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class Lungora extends StatefulWidget {
  final bool onBoarding;
  const Lungora({
    super.key,
    required this.onBoarding,
  });

  @override
  State<Lungora> createState() => _LungoraState();
}

class _LungoraState extends State<Lungora> {
  @override
  void initState() {
    super.initState();
    if (!widget.onBoarding) {
      Future.delayed(Duration.zero, () {
        AppRouter.router.go(AppRouter.kOnbordingView);
      });
    }
  }

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
              routerConfig: AppRouter.router,
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
