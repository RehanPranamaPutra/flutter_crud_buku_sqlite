import 'package:flutter/material.dart';
import 'package:sql_buku_flutter/helper/db_helper.dart';
import 'package:sql_buku_flutter/uiscreen/addbuku_view.dart';
import 'package:sql_buku_flutter/uiscreen/editbuku_view.dart';
import '../model/model_buku.dart';

class Listdatabuku extends StatefulWidget {

  const Listdatabuku({super.key});
  @override
  State<Listdatabuku> createState() => _ListdatabukuViewState();
}

class _ListdatabukuViewState extends State<Listdatabuku> {
  List<ModelBuku> _buku = [];
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.dummyBuku();
    _fetchDataBuku();
  }

  Future<void> _fetchDataBuku() async {
    setState(() {
      _isloading = true;
    });
    final bukuMaps = await DatabaseHelper.instance.queryAllBuku();
    setState(() {
      _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
      _isloading = false;
    });
  }

  _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  _deleteFormDialog(BuildContext context, bukuId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: Text(
            'Are You sure to Delete ?',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                var result = await DatabaseHelper.instance.deleteBuku(bukuId);
                if (result != null) {
                  Navigator.pop(context);
                  _fetchDataBuku();
                  _showSuccessSnackbar(
                    "Buku id $bukuId telah berhasil dihapus",
                  );
                }
              },
              child: Text("Hapus"), // ✅ Ini wajib
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Data Buku'),
        actions: [
          IconButton(
            onPressed: () {
              _fetchDataBuku();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
     body: _isloading
    ? const Center(child: CircularProgressIndicator())
    : ListView.builder(
        itemCount: _buku.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_buku[index].judulBuku),
            subtitle: Text(_buku[index].kategori),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditbukuView(buku: _buku[index],)),
                    );
                    _fetchDataBuku(); // Refresh setelah kembali dari edit
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteFormDialog(context, _buku[index].id);
                  },
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddbukuView()),
          );
          _fetchDataBuku();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
