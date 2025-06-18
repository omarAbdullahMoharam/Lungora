import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/get_doctors_cubit.dart';
import 'package:lungora/features/doctor/presentation/widgets/doctor_view_body.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    // final DoctorDetailsModel sampleDoctorDetails = DoctorDetailsModel(
    //   doctor: DoctorInfoModel(
    //     name: "Mohamed",
    //     numOfPatients: 345,
    //     about: "mohamed ahmed",
    //     emailDoctor: "mohamed2@gmail.com",
    //     phone: "01277590930",
    //     teliphone: "01277590930",
    //     experianceYears: 22,
    //     location: "Giza",
    //     locationLink:
    //         "https://www.google.com/maps?q=29.977660580298032,31.250000559839346",
    //     whatsAppLink: "#www",
    //     imageDoctor:
    //         "https://res.cloudinary.com/deoayl2hl/image/upload/v1746817798/Doctors/68b151b1-2c28-4535-87ef-d36a16e8d2d2_2025_05_09_doc18_at_01.49.00_04c1569d_lyonzj.jpg",
    //     latitude: 29.977660580298032,
    //     longitude: 31.250000559839346,
    //     categoryName: "Neuro",
    //   ),
    //   workingHours: [
    //     WorkingHours(
    //       dayOfWeek: "Monday",
    //       startTime: "09:00:00",
    //       endTime: "17:00:00",
    //       doctorId: 11,
    //     ),
    //   ],
    // );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => GetDoctorsCubit(),
        child: DoctorViewBody(),
      ),
    );
  }
}
