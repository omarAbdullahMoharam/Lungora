import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';

import '../widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) => SettingsCubit(getIt<ApiServices>()),
        child: EditProfileViewBody(),
      )),
    );
  }
}
