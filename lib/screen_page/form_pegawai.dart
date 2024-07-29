import 'package:flutter/material.dart';
import 'package:project_flutter/model/model_pegawai_sqflite.dart';
import 'package:project_flutter/utils/db_helper_sqflite.dart';
import 'package:sqflite/sqflite.dart';

class FormPegawai extends StatefulWidget {
  final ModelPegawaiSqflite? pegawai;

  const FormPegawai({super.key, this.pegawai});

  @override
  State<FormPegawai> createState() => _FormPegawaiState();
}

class _FormPegawaiState extends State<FormPegawai> {

  DatabaseHelper db = DatabaseHelper();
  TextEditingController? firstName, lastName, mobileNo, emailId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = TextEditingController(text: widget.pegawai == null ? '' : widget.pegawai?.firstName);
    lastName = TextEditingController(text: widget.pegawai == null ? '' : widget.pegawai?.lastName);
    mobileNo = TextEditingController(text: widget.pegawai == null ? '' : widget.pegawai?.mobileNo);
    emailId = TextEditingController(text: widget.pegawai == null ? '' : widget.pegawai?.emailId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pegawai'),
        backgroundColor: Colors.green,
      ),

      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: 10,),
          TextField(
            controller: firstName,
            decoration: InputDecoration(
              label: Text('First Name'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: lastName,
            decoration: InputDecoration(
                label: Text('Last Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: mobileNo,
            decoration: InputDecoration(
                label: Text('Mobile No'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: emailId,
            decoration: InputDecoration(
                label: Text('Email Id'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
          ),
          SizedBox(height: 10,),
          MaterialButton(
            onPressed: (){
              //untuk submit data

            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.green,
            child: (widget.pegawai == null) ? Text('Add', style: TextStyle(color: Colors.white),)
              : Text('Update', style: TextStyle(color: Colors.white),)

          )

        ],
      ),

    );
  }

  //method untuk update dan add data
  Future<void> updateInsertData() async{
    if(widget.pegawai != null){
      //update data

      await db.updatePegawai(ModelPegawaiSqflite.fromMap({
        'id' : widget.pegawai?.id,
        'firstName' : firstName?.text,
        'lastName' : lastName?.text,
        'mobileNo' : mobileNo?.text,
        'emailId' : emailId?.text,
      }));

      Navigator.pop(context);
    }else{
      //save
      await db.savePegawai(ModelPegawaiSqflite(firstName?.text,
          lastName?.text,
          mobileNo?.text,
          emailId?.text));

      Navigator.pop(context, 'save');
    }
  }
}
