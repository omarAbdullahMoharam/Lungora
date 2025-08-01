import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/core/utils/floting_action_button.dart';
import 'package:lungora/features/Home/presentation/widgets/home_view_body.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SettingsCubit(getIt<ApiServices>()),
        child: HomeViewBody(),
      ),
      floatingActionButton: FlotingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.question_mark, size: 24.sp, color: Colors.white),
        onPressed: () {
          context.go(AppRouter.kAboutUsView);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
