import 'package:flutter/material.dart';
import 'package:sql_buku_flutter/helper/db_helper.dart';
import 'package:sql_buku_flutter/uiscreen/addbuku_view.dart';
import 'package:sql_buku_flutter/uiscreen/editbuku_view.dart';
import '../model/model_buku.dart';

class Listdatabuku extends StatefulWidget {
  const Listdatabuku ({super.key});
  @override
  State<Listdatabuku > createState() => _ListdatabukuViewState();
}

class _ListdatabukuViewState extends State<Listdatabuku> {

  List<ModelBuku> _buku = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.dummyBuku();
    _fetchDataBuku();
  }

  Future<void> _fetchDataBuku() async{
    final bukuMaps = await DatabaseHelper.instance.queryAllBuku();
    setState(() {
      _buku = bukuMaps.map((bukuMaps)=> ModelBuku.fromMap(bukuMaps)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Data Buku'),
      ),
      body: ListView.builder(
        itemCount: _buku.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(_buku[index].judulBuku),
            subtitle: Text(_buku[index].kategori),
            onTap: (){
              Navigator.push(context, (MaterialPageRoute(builder: (context)=>const EditbukuView())));
            },
            trailing: Icon(Icons.edit),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, (MaterialPageRoute(builder: (context)=> const AddbukuView())));
      },
      child: Icon(Icons.add),),
    );
  }
}