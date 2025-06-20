import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_loading_indicator.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/url_luncher_url.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';
import 'package:lungora/features/doctor/repo/doctors_repo.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorCard({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Color(0xFFF1F1F1),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.h)),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: CachedNetworkImage(
                imageUrl: doctorModel.imageDoctor,
                placeholder: (context, url) => const Center(
                  child: CustomLoadingIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                width: 85.w,
                height: 85.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorModel.name,
                    style: Styles.textStyleInter16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${doctorModel.categoryName} Specialist",
                    // doctorModel.available ? "Available" : "Not Available",
                    style: Styles.textStyle12.copyWith(
                      color: kSecondaryColor,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final doctorsRepo = getIt<DoctorsRepo>();
                          final doctorDetails =
                              await doctorsRepo.getDoctorDetails(
                            id: doctorModel.id,
                          );
                          if (!context.mounted) return;
                          context.push(
                            AppRouter.kDoctorDetailsView,
                            extra: doctorDetails,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(60.w, 30.h),
                          side:
                              const BorderSide(color: kPrimaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                        ),
                        child: Text(
                          "More details",
                          style: Styles.textStyle12,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        onPressed: () {
                          if (doctorModel.whatsAppLink.isEmpty) {
                            SnackBarHandler.showSnackBar(
                              message:
                                  "WhatsApp is not available for this doctor.",
                            );
                            return;
                          }
                          UrlLauncher.launchWhatsAppByLink(
                            doctorModel.whatsAppLink,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: Size(80.w, 30.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                        ),
                        child: Text(
                          "Chat",
                          style: Styles.textStyle12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
