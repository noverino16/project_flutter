import 'package:flutter/material.dart';
import 'package:project_flutter/model/model_pegawai_sqflite.dart';

class DetailPegawai extends StatelessWidget {
  final ModelPegawaiSqflite pegawai;
  const DetailPegawai(this.pegawai, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
        backgroundColor: Colors.green,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("First Name : ${pegawai.firstName}"),
            Text("Last Name : ${pegawai.lastName}"),
            Text("Mobile No : ${pegawai.mobileNo}"),
            Text("Email id : ${pegawai.emailId}"),

          ],
        ),
      ),
    );
  }
}
