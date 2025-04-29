import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
import 'package:lungora/features/Scan/presentation/widgets/scan_view_body.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lungora/core/helpers/api_services.dart';
// import 'package:lungora/core/utils/app_router.dart';
// import 'package:lungora/core/utils/dependency_injection.dart';
// import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
// import 'package:lungora/features/Scan/presentation/widgets/scan_view_body.dart';
// import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lungora/features/auth/services/secure_storage_service.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(getIt<ApiServices>()),
      child: const ScanViewContent(),
    );
  }
}

class ScanViewContent extends StatefulWidget {
  const ScanViewContent({super.key});

  @override
  State<ScanViewContent> createState() => _ScanViewContentState();
}

class _ScanViewContentState extends State<ScanViewContent> {
  String? _userImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final cachedImage = await SecureStorageService.getUserImage();
      if (cachedImage != null) {
        setState(() {
          _userImage = cachedImage;
        });
      }

      final token = await SecureStorageService.getToken();
      if (token != null) {
        BlocProvider.of<SettingsCubit>(context, listen: false)
            .getUserData(token: token);
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            String imagePath;

            if (state is SettingsGetUserDataSuccess) {
              imagePath = state.userModel.imageUser;
              SecureStorageService.saveUserImage(imagePath); // cache it
            } else {
              imagePath = _userImage ??
                  'https://res.cloudinary.com/deoayl2hl/image/upload/v1742340954/Users/f446ff10-d23b-42ed-bb90-be18f88d9f01_2025_03_19_profile_avatar_brm2oi.jpg';
            }

            return buildCustomAppBar(
              onPressed: () {
                AppRouter.router.go(AppRouter.kProfileView);
              },
              context: context,
              imagePath: imagePath,
            );
          },
        ),
      ),
      body: const ScanViewBody(),
    );
  }
}
