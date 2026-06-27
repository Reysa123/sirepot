import 'package:flutter/material.dart';

class WhatsappWidget extends StatefulWidget {
  final String nmPlg;
  final String nopol;
  final String nohp;
  final String model;
  const WhatsappWidget({
    super.key,
    required this.nmPlg,
    required this.nohp,
    required this.nopol,
    required this.model,
  });

  @override
  State<WhatsappWidget> createState() => _WhatsappWidgetState();
}

class _WhatsappWidgetState extends State<WhatsappWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController text = TextEditingController();
    FocusNode node = FocusNode();
    text.text =
        ('*Service Toyota Check*\n\n*Hallo Semeton Agung  Toyota Tabanan*\nNama                   : ${widget.nmPlg}\nType Kendaraan : ${widget.model}\nNo Polisi              : ${widget.nopol}\n\nPerkenalkan saya TIKA Petugas booking service  dari Bengkel Agung TOYOTA Tabanan\nMenginformasikan untuk Kendaraannya sudah waktu nya untuk *Melakukan Service Berkala dan Penggantian Oli Mesin Rutin 6 Bulan*.\n\n*Ambil Hak Gratis Service Toyota Mu yang berlaku dibulan Juni ini*\n\nSilahkan melakukan Booking Service, agar kami bisa menyiapkan Waktu, Spare Part dan Teknisi saat servis, dengan balas WA ini🙏.\n\nManfaatkan Layanan Gratis untuk :\n✅ TMS : Toyota Mobile Service (Service di tempat)\n✅ Pick Up Delivery : Antar jemput service \nTerima kasih, semoga Aktifitasnya diberikan Kelancaran 🙏😇\n\n_abaikan pesan ini jika sudah melakukan service kendaraan rutin_\n\nSalam Agung Toyota Tabanan');
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 158, 238, 230),
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 200, child: Text('Nama Pelanggan')),
                SizedBox(width: 18, child: Text(':')),
                SizedBox(child: Text(widget.nmPlg)),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 200, child: Text('No Polisi')),
                SizedBox(width: 18, child: Text(':')),
                SizedBox(child: Text(widget.nopol)),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 200, child: Text('No Handphone')),
                SizedBox(width: 18, child: Text(':')),
                SizedBox(child: Text(widget.nohp)),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.white,
              ),
              //color: Colors.white,
              child: EditableText(
                controller: text,
                focusNode: node,
                style: TextStyle(fontSize: 12),
                cursorColor: Colors.black,
                backgroundCursorColor: Colors.white,
                minLines: 8,
                maxLines: 18,
              ),
            ),
            Spacer(),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                elevation: 5,
                shadowColor: Colors.yellow,
              ),
              onPressed: () {},
              iconAlignment: IconAlignment.end,
              icon: Icon(Icons.send, color: Colors.blue),
              label: Text('Kirim'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
