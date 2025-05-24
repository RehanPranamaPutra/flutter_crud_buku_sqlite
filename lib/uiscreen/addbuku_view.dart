import 'package:flutter/material.dart';
import 'package:sql_buku_flutter/helper/db_helper.dart';
import 'package:sql_buku_flutter/model/model_buku.dart';

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
      appBar: AppBar(title: Text('Add DAta Buku')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Buku',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _judulBukuController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Masukan Judul Buku',
                  labelText: 'Judul Buku',
                  errorText:
                      _validateJudul ? 'Judul Buku tiddak boleh kosong' : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _katergoriBukuComtroller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Masukan Kategori',
                  labelText: 'Kategori Buku',
                  errorText:
                      _validateKategori ? 'Kategoti tidak boleh kosong' : null,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        //validasi kosong
                        _judulBukuController.text.isEmpty
                            ? _validateJudul = true
                            : _validateJudul = false;
                        _katergoriBukuComtroller.text.isEmpty
                            ? _validateKategori = true
                            : _validateKategori = false;
                      });
                      if (_validateJudul == false &&
                          _validateKategori == false) {
                        //kita set data ke db
                        var _buku = ModelBuku(
                          judulBuku: _judulBukuController.text,
                          kategori: _katergoriBukuComtroller.text,
                        );
                        var result = await DatabaseHelper.instance.insertBuku(
                          _buku,
                        );
                        Navigator.pop(context, result);
                      }
                    },
                    child: Text('Save Details'),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Clear Details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
