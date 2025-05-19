import 'package:flutter/material.dart';


class AddbukuView extends StatefulWidget {
  const AddbukuView({super.key});

  @override
  State<AddbukuView> createState() => _AddbukuViewState();
}

class _AddbukuViewState extends State<AddbukuView> {

  var _judulBukuController = TextEditingController();
  var _katergoriBukuComtroller = TextEditingController();

  bool _validateJudul = false;
  bool _validateKategori = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add DAta Buku'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Buku',
              style: TextStyle(
                fontSize: 20,
                color: Colors.teal,
                fontWeight: FontWeight.w600
              ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _judulBukuController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Masukan Judul Buku',
                  labelText: 'Judul Buku',
                  errorText: _validateJudul ? 'Judul Buku tiddak boleh kosong' : null
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _katergoriBukuComtroller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Masukan Kategori',
                  labelText: 'Kategori Buku',
                  errorText: _validateKategori ? 'Kategoti tidak boleh kosong' : null
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                      textStyle: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      onPressed: (){}, child: Text('Save Details')),
                  SizedBox(width: 10,),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      onPressed: (){}, child: Text('Clear Details')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

