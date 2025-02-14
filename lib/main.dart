import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/features/auth/Presentation/views/auth_view.dart';

void main() {
  runApp(const Lungora());
}

class Lungora extends StatelessWidget {
  const Lungora({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lungora',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: kPrimaryColor,
            secondary: kSecondaryColor,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AuthView(),
      ),
    );
  }
}
