import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';

import 'doctor_card.dart';

class DoctorViewBody extends StatelessWidget {
  // final List<DoctorModel> doctorsList;
  const DoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetDoctorsCubit>(context).getDoctors();

    return BlocBuilder<GetDoctorsCubit, GetDoctorsState>(
      builder: (context, state) {
        if (state is GetDoctorsLoading) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animation/searching.json",
                  width: 300,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  "Finding nearest doctor for you...",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is GetDoctorsFailure) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/no_available_doctors.json",
                width: 300,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                "Sorry, we couldn't find any doctors at the moment.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ));
        } else if (state is GetDoctorsEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/no_available_doctors.json",
                width: 300,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                "No doctors available at the moment.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ));
        } else if (state is GetDoctorsSuccess) {
          return _buildDoctorsList(state.doctorsList);
        }

        return const Center(child: Text("Unknown Error Happened"));
      },
    );
  }

  Widget _buildDoctorsList(List<DoctorModel> doctors) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctorModel: doctors[index]);
      },
    );
  }
}
