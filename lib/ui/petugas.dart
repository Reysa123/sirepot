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
    if (data != null){ setState(() => listPetugas = List<String>.from(jsonDecode(data)));}else{
      p.setString('list_petugas','TIKA');
      p.setString('list_petugas','DWI');
      p.setString('list_petugas','FUAH');
      final data1 = p.getString('list_petugas');
      setState(() { 
        
        listPetugas = List<String>.from(jsonDecode(data1));
      });
    };
  }

  void _save() async {
    final p = await SharedPreferences.getInstance();
    p.setString('list_petugas', jsonEncode(listPetugas));
  }

  void _showDialog({String? initial, int? index}) {
    final c = TextEditingController(text: initial ?? '');
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(index == null ? "Tambah Petugas" : "Edit Petugas"),
      content: TextField(controller: c, autofocus: true),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
        ElevatedButton(onPressed: () {
          setState(() {
            if (index == null) listPetugas.add(c.text);
            else listPetugas[index] = c.text;
            _save();
          });
          Navigator.pop(context);
        }, child: const Text("Simpan"))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Petugas")),
      drawer: const AppDrawer(),
      body: ListView.separated(
        itemCount: listPetugas.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) => ListTile(
          title: Text(listPetugas[i]),
          trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
            setState(() => listPetugas.removeAt(i));
            _save();
          }),
          onTap: () => _showDialog(initial: listPetugas[i], index: i),
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () => _showDialog()),
    );
  }
}
