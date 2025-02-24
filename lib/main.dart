import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  // AuthRepo authRepo = AuthRepo(ApiServices(Dio()));
  // getIt<AuthRepo>().login("email@gmail.com", "Password_12");
  // getIt<AuthRepo>().forgetUserPassword("omarmoharam790@gmail.com");
  // authRepo.register("email@gmail.com", "Password_12", "emailname");
  // authRepo.verifyUserOTP(email: "omarmoharam790@gmail.com", otp: "1234");
  // getIt<AuthRepo>()
  //     .register("Adel", "adel@gmail.com", "Adel@1234", "Adel@1234");
  runApp(const Lungora());
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
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: AppRoture.router,
        debugShowCheckedModeBanner: false,
        title: 'Lungora',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: kPrimaryColor,
            secondary: kSecondaryColor,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
