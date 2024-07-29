import 'package:flutter/material.dart';
import 'package:project_flutter/model/model_pegawai_sqflite.dart';
import 'package:project_flutter/screen_page/detail_pegawai.dart';
import 'package:project_flutter/screen_page/form_pegawai.dart';
import 'package:project_flutter/utils/db_helper_sqflite.dart';

class PageListPegawaiSqflite extends StatefulWidget {
  const PageListPegawaiSqflite({super.key});

  @override
  State<PageListPegawaiSqflite> createState() => _PageListPegawaiSqfliteState();
}

class _PageListPegawaiSqfliteState extends State<PageListPegawaiSqflite> {

  List<ModelPegawaiSqflite> listPegawai = [];
  DatabaseHelper db = DatabaseHelper();

  //method untuk get semua data pegawai
  Future<void> _getAllPegawai() async{
    var list = await db.getAllPegawai();
    setState((){
      listPegawai.clear();
      list?.forEach((pegawai){
        listPegawai.add(ModelPegawaiSqflite.fromMap(pegawai));
      });
    });
  }

  Future<void> _openFormCreate()async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)
      => FormPegawai()
    ));

    if(result == 'save'){
      await _getAllPegawai();
    }
  }

  Future<void> _deletePegawai(ModelPegawaiSqflite pegawai, int position) async{
    await db.deletePegawai(pegawai.id);
    setState(() {
      listPegawai.removeAt(position);
    });
  }

  Future<void> _openFormEdit(ModelPegawaiSqflite pegawai) async{

    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)
      => FormPegawai(pegawai: pegawai)
    ));

    if(result == 'update'){
      await _getAllPegawai();
    }
  }

  @override
  void initState(){
    super.initState();
    _getAllPegawai();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Pegawai Sqflite'),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: listPegawai.length,
        itemBuilder: (context, index){
          ModelPegawaiSqflite pegawai = listPegawai[index];
          return Card(
            child: ListTile(
              onTap: (){
                //edit form
                _openFormEdit(pegawai);
              },
              contentPadding: EdgeInsets.all(10),
              title: Text('${pegawai.firstName} ${pegawai.lastName}',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.green[700]
                ),
              ),
              subtitle: Text('${pegawai.emailId}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  //untuk proses delete
                  AlertDialog hapus = AlertDialog(
                    title: Text('Information'),
                    content: Container(
                      height: 100,
                      child: Column(
                        children: [
                          Text('Apakah anda yakin ingin menghapus data ${pegawai.emailId} ini?')
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        //delete --> Yes
                        _deletePegawai(pegawai, index);
                        Navigator.pop(context);
                      },
                          child: Text('Yes')),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          child: Text('No'))
                    ],
                  );
                  showDialog(context: context, builder: (context) => hapus);
                },
              ),
              leading: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                    =>DetailPegawai(pegawai)
                  ));
                },
                icon: Icon(Icons.visibility),
              ),
            ),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _openFormCreate();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
