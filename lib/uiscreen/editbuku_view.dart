import 'package:flutter/material.dart';
import 'package:sql_buku_flutter/helper/db_helper.dart';
import 'package:sql_buku_flutter/model/model_buku.dart';

class EditbukuView extends StatefulWidget {
  final ModelBuku buku;
  const EditbukuView({super.key, required this.buku});

  @override
  State<EditbukuView> createState() => _EditbukuViewState();
}

class _EditbukuViewState extends State<EditbukuView> {
  var _judulBukuController = TextEditingController();
  var _katergoriBukuComtroller = TextEditingController();

  bool _validateJudul = false;
  bool _validateKategori = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _judulBukuController = TextEditingController(text: widget.buku.judulBuku);
    _katergoriBukuComtroller = TextEditingController(
      text: widget.buku.kategori,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Data Buku')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit New Buku',
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
                    style: TextButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () async {
                      setState(() {
                        _validateJudul = _judulBukuController.text.isEmpty;
                        _validateKategori =
                            _katergoriBukuComtroller.text.isEmpty;
                      });

                      if (!_validateJudul && !_validateKategori) {
                        // Update buku ke database
                        await DatabaseHelper.instance.updateBuku(
                          ModelBuku(
                            id: widget.buku.id,
                            judulBuku: _judulBukuController.text,
                            kategori: _katergoriBukuComtroller.text,
                          ),
                        );
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      }
                    },
                    child: Text(
                      'Update Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        _judulBukuController.clear();
                        _katergoriBukuComtroller.clear();
                      });
                    },
                    child: Text(
                      'Clear Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              //TASK
              //buat Naviogasi agar page edit dan add muncul ketika di klik
              //posisi klik untuk saat ini bebas(kirim video demo di wa group maksimal 5 soew
            ],
          ),
        ),
      ),
    );
  }
}
