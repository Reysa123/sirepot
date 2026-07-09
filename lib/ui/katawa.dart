import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KataWA extends StatefulWidget {
  const KataWA({super.key});

  @override
  State<KataWA> createState() => _KataWAState();
}

class _KataWAState extends State<KataWA> {
  late SharedPreferences pref;

  final text1 = TextEditingController();
  final text2 = TextEditingController();

  bool edit1 = false;
  bool edit2 = false;

  final String defaultKata1 = '''
*Service Toyota Check*

*Hallo Semeton Agung Toyota Tabanan*

Nama                   : @_nama_pelanggan
Type Kendaraan  : @_type_kendaraan
No Polisi              : @no_polisi

Perkenalkan saya @_pic Petugas booking service dari Bengkel Agung TOYOTA Tabanan.

Menginformasikan untuk Kendaraannya sudah waktunya melakukan *Service Berkala dan Penggantian Oli Mesin Rutin 6 Bulan.*

*Ambil Hak Gratis Service Toyota Mu yang berlaku bulan ini.*

Silahkan melakukan Booking Service agar kami dapat menyiapkan waktu, spare part dan teknisi dengan membalas WA ini 🙏

Manfaatkan Layanan Gratis:
🚗 Toyota Mobile Service
🚚 Pick Up Delivery

Terima kasih, semoga aktivitasnya diberikan kelancaran 🙏😇

_Abaikan pesan ini jika sudah melakukan service rutin._

Salam Agung Toyota Tabanan
''';

  final String defaultKata2 = '''
*Service Toyota Check*

*Hallo Semeton Agung Toyota Tabanan*

Nama                   : @_nama_pelanggan
Type Kendaraan  : @_type_kendaraan
No Polisi              : @_no_polisi

Perkenalkan saya @_pic Petugas booking service dari Bengkel Agung TOYOTA Tabanan.

Menginformasikan untuk Kendaraannya sudah waktunya melakukan *Service Berkala dan Penggantian Oli Mesin Rutin 6 Bulan.*

*Ambil Hak Gratis Service Toyota Mu yang berlaku bulan ini.*

Silahkan melakukan Booking Service agar kami dapat menyiapkan waktu, spare part dan teknisi dengan membalas WA ini 🙏

Manfaatkan Layanan Gratis:
🚗 Toyota Mobile Service
🚚 Pick Up Delivery

Terima kasih, semoga aktivitasnya diberikan kelancaran 🙏😇

_Abaikan pesan ini jika sudah melakukan service rutin._

Salam Agung Toyota Tabanan
''';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    pref = await SharedPreferences.getInstance();

    if (!pref.containsKey("kata1")) {
      await pref.setString("kata1", defaultKata1);
    }

    if (!pref.containsKey("kata2")) {
      await pref.setString("kata2", defaultKata2);
    }

    text1.text = pref.getString("kata1")!;
    text2.text = pref.getString("kata2")!;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> saveText(String key, String value) async {
    await pref.setString(key, value);
    if (!mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Berhasil disimpan"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    text1.dispose();
    text2.dispose();
    super.dispose();
  }

  Widget buildCard({
    required String title,
    required TextEditingController controller,
    required bool edit,
    required VoidCallback onEdit,
    required VoidCallback onSave,
  }) {
    print(edit);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.message, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: edit ? onSave : onEdit,
                  icon: Icon(edit ? Icons.save : Icons.edit),
                  label: Text(edit ? "Simpan" : "Edit"),
                ),
              ],
            ),

            const SizedBox(height: 15),
            TextFormField(
              controller: controller,
              enabled: edit,
              minLines: 8,
              maxLines: 12,
              decoration: InputDecoration(
                filled: true,
                fillColor: edit
                    ? Colors.yellowAccent.shade100
                    : Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 8),
            edit
                ? TextField(
                    maxLines: 7,
                    minLines: 7,
                    controller: TextEditingController(
                      text:
                          "Huruf Tebal => *tulisan tebal*\n"
                          "Huruf Miring => -tulisan miring-\n"
                          "Nama Pelanggan => @_nama_pelanggan\n"
                          "Type Kendaraan => @_type_kendaraan\n"
                          "No Polisi => @_no_polisi\n"
                          "PIC => @_pic\n"
                          "Untuk icon kemungkinan tidak bisa dibaca sesuai keinginan kecuali di buka melalui smartphone\n",
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.yellow.shade50,
                      labelText: 'Panduan Format Tulisan',
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan WhatsApp"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildCard(
              title: "Ucapan WhatsApp Service Reminder",
              controller: text1,
              edit: edit1,
              onEdit: () {
                setState(() => edit1 = true);
              },
              onSave: () async {
                await saveText("kata1", text1.text);
                setState(() => edit1 = false);
              },
            ),
            const SizedBox(height: 20),
            buildCard(
              title: "Ucapan WhatsApp CR7",
              controller: text2,
              edit: edit2,
              onEdit: () {
                setState(() => edit2 = true);
              },
              onSave: () async {
                await saveText("kata2", text2.text);
                setState(() => edit2 = false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
