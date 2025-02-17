import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/Home/presentation/widgets/custom_service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CustomServiceCard(
            imagePath: 'assets/images/Scan_XRay_Service.png',
            serviceName: 'Scan your X-Ray',
          ),
          SizedBox(width: 8.w),
          CustomServiceCard(
            imagePath: 'assets/images/Chat_With_Bot_Service.png',
            serviceName: 'Chat with Medical Bot',
          ),
        ],
      ),
    );
  }
}
