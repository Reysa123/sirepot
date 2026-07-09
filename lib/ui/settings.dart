import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sirepot/ui/katawa.dart';
import 'package:sirepot/ui/petugas.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Widget wid = SizedBox();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Setting/Pengaturan")),
        // Menambahkan Drawer di sini
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("Agung Toyota Tabanan"),
                accountEmail: Text("agungtoyotatabanan@email.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.whatsapp),
                title: const Text('Format WhatsApp'),
                onTap: () {
                  // Navigator.of(context,rootNavigator: true).pop();
                  KataWA wa = KataWA(); // Menutup drawer;
                  setState(() {
                    wid = wa;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Petugas'),
                onTap: () {
                  // Navigator.of(context,rootNavigator: true).pop();
                  PetugasPage wa = PetugasPage(); // Menutup drawer;
                  setState(() {
                    wid = wa;
                  });
                },
              ),
            ],
          ),
        ),
        body: wid,
      ),
    );
  }
}
