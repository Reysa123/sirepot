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
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan berdasarkan tab yang dipilih
  final List<Widget> _pages = [const KataWA(), const PetugasPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo, // Warna tema dasar yang modern
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Setting/Pengaturan",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.indigo,
                unselectedItemColor: Colors.grey.shade400,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: FaIcon(FontAwesomeIcons.whatsapp, size: 22),
                    ),
                    label: 'Format WhatsApp',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(Icons.person_outline, size: 24),
                    ),
                    activeIcon: Icon(Icons.person, size: 24),
                    label: 'Petugas',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
