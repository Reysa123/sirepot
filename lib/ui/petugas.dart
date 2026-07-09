import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetugasPage extends StatefulWidget {
  const PetugasPage({super.key});
  @override
  State<PetugasPage> createState() => _PetugasPageState();
}

class _PetugasPageState extends State<PetugasPage> {
  List<String> listPetugas = [];
  GlobalKey key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final p = await SharedPreferences.getInstance();
    final data = p.getStringList('list_petugas');
    if (data != null) {
      //<<<<<<< HEAD
      setState(() => listPetugas = data);
    } else {
      p.setStringList('list_petugas', ['TIKA', 'DWI', 'FUAH']);
      //final datap.getStringList('list_petugas');
      setState(() {
        listPetugas = ['TIKA', 'DWI', 'FUAH'];
      });
    }
  }

  void _save() async {
    final p = await SharedPreferences.getInstance();
    p.setStringList('list_petugas', listPetugas);
  }

  void _showDialog(BuildContext ctx, {String? initial, int? index}) {
    final c = TextEditingController(text: initial ?? '');
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        // shape:
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(index == null ? "Tambah Petugas" : "Edit Petugas"),
        content: TextField(
          controller: c,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Masukkan nama petugas",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                if (c.text.isNotEmpty) {
                  if (index == null) {
                    listPetugas.add(c.text);
                  } else {
                    listPetugas[index] = c.text;
                  }
                  _save();
                }
              });
              Navigator.of(ctx, rootNavigator: true).pop();
            },
            child: const Text("Simpan"),
          ),
          // >>>>>>> 3bdf5ab7a0f5d091d1f3806237ab22d669170e82
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text(
          "Data Petugas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      // drawer: const AppDrawer(), // Pastikan AppDrawer sudah didefinisikan
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: listPetugas.length,
        itemBuilder: (_, i) => Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            dense: true, // Membuat tampilan lebih compact/kecil
            visualDensity: VisualDensity.compact,
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                listPetugas[i].isNotEmpty ? listPetugas[i][0] : "?",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              listPetugas[i],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 20,
              ),
              onPressed: () {
                setState(() => listPetugas.removeAt(i));
                _save();
              },
            ),
            onTap: () => _showDialog(ctx, initial: listPetugas[i], index: i),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showDialog(ctx),
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
        //>>>>>>> 3bdf5ab7a0f5d091d1f3806237ab22d669170e82
      ),
    );
  }
}
