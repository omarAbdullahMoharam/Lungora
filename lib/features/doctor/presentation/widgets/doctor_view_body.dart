import 'package:flutter/material.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';

import '../../data/working_time.dart';
import 'doctor_card.dart';

class DoctorViewBody extends StatelessWidget {
  const DoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    //instead data untill we get from dio
    DoctorModel doctorModel = DoctorModel(
        name: 'Dr. Harucon',
        imageUrl: 'assets/images/doctor_test.jpg',
        specialty: 'Cardiologist',
        about:
            'Dr. Mahmud Nik is the top most Cardiologist specialist in Dhaka Medical College Hospital at Dhaka. He achived several awards for his wonderful contribution in his own field. He is avaliable for private consultation.',
        phone: '01023456789',
        email: 'harucon@gmail.com',
        available: 'Available from 10 AM to 4 PM',
        location: 'New York, USA',
        telephone: '555 1234 567',
        workingTime: [
          WorkingTime(
            day: 'Sat',
            from: '10:00 AM',
            to: '6:00 PM',
          ),
          WorkingTime(
            day: 'Sun',
            from: '9:00 AM',
            to: '5:00 PM',
          ),
          WorkingTime(
            day: 'Mon',
            from: '10:00 AM',
            to: '6:00 PM',
          ),
          WorkingTime(
            day: 'Tues',
            from: '10:00 AM',
            to: '6:00 PM',
          ),
          WorkingTime(
            day: 'wed',
            from: '10:00 AM',
            to: '6:00 PM',
          ),
          WorkingTime(
            day: 'Thu',
            from: '10:00 AM',
            to: '6:00 PM',
          ),
        ]);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 12,
      itemBuilder: (context, index) {
        return DoctorCard(
          doctorModel: doctorModel,
        );
      },
    );
  }
}
