import 'package:flutter/material.dart';

import '../models/Doctor.dart';
import '../widgets/DoctorCard.dart';
import '../services/UserDatabaseService.dart';

class AllDoctorsScreen extends StatelessWidget {
  final userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Doctor>>(
      stream: userDatabaseService.streamAllDoctors(),
      builder: (context, snapshot) {
        final doctors = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (doctors.isEmpty) {
          return Center(
            child: Text(
              'No Doctors available',
              style: Theme.of(context).textTheme.headline2,
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (ctx, index) => DoctorCard(doctors[index]),
          itemCount: doctors.length,
        );
      },
    );
  }
}
