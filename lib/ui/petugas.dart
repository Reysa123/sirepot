import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetugasPage extends StatefulWidget {
  const PetugasPage({super.key});
  @override
  State<PetugasPage> createState() => _PetugasPageState();
}

class _PetugasPageState extends State<PetugasPage> {
  List<String> listPetugas = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final p = await SharedPreferences.getInstance();
    final data = p.getString('list_petugas');
    if (data != null) {
      setState(() => listPetugas = List<String>.from(jsonDecode(data)));
    } else {
      // Perbaikan: Simpan sebagai List agar bisa di-decode dengan benar
      List<String> initialData = ['TIKA', 'DWI', 'FUAH'];
      setState(() => listPetugas = initialData);
      _save();
    }
  }

  void _save() async {
    final p = await SharedPreferences.getInstance();
    p.setString('list_petugas', jsonEncode(listPetugas));
  }

  void _showDialog({String? initial, int? index}) {
    final c = TextEditingController(text: initial ?? '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              setState(() {
                if (c.text.isNotEmpty) {
                  if (index == null) listPetugas.add(c.text);
                  else listPetugas[index] = c.text;
                  _save();
                }
              });
              Navigator.pop(context);
            }, 
            child: const Text("Simpan")
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Petugas", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      // drawer: const AppDrawer(), // Pastikan AppDrawer sudah didefinisikan
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: listPetugas.length,
        itemBuilder: (_, i) => Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            dense: true, // Membuat tampilan lebih compact/kecil
            visualDensity: VisualDensity.compact,
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(listPetugas[i][0], style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(listPetugas[i], style: const TextStyle(fontWeight: FontWeight.w500)),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
              onPressed: () {
                setState(() => listPetugas.removeAt(i));
                _save();
              },
            ),
            onTap: () => _showDialog(initial: listPetugas[i], index: i),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showDialog(),
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
