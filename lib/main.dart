import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  // AuthRepo authRepo = AuthRepo(ApiServices(Dio()));
  getIt<AuthRepo>().login("email@gmail.com", "Password_12");
  // authRepo.register("email@gmail.com", "Password_12", "emailname");

  runApp(const Lungora());
}

class Lungora extends StatelessWidget {
  const Lungora({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
      designSize: Size(defualtWidth, defualtHeight),
      minTextAdapt: false,
      child: MaterialApp.router(
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
