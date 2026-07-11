import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirepot/ui/katawa.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappWidget extends StatefulWidget {
  final bool layer;
  final String nmPlg;
  final String nopol;
  final String nohp;
  final String model;
  final List<String> list;

  const WhatsappWidget({
    super.key,
    required this.layer,
    required this.nmPlg,
    required this.nohp,
    required this.nopol,
    required this.model,
    required this.list,
  });

  @override
  State<WhatsappWidget> createState() => _WhatsappWidgetState();
}

class _WhatsappWidgetState extends State<WhatsappWidget> {
  late TextEditingController _textController;
  String? _selectedPic; // PIC Default

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _updateTextMessage(); // Generate pesan pertama kali
  }

  // Fungsi untuk memperbarui teks template secara dinamis jika PIC berubah
  void _updateTextMessage() async {
    final pref = await SharedPreferences.getInstance();
    if (widget.layer) {
      if (pref.containsKey('kata1')) {
        final string1 = pref.getString('kata1');
        _textController.text = string1!
            .replaceAll('@_nama_pelanggan', widget.nmPlg)
            .replaceAll('@_type_kendaraan', widget.model)
            .replaceAll('@_pic', _selectedPic ?? '[PIC]')
            .replaceAll('@_no_polisi', widget.nopol);
      } else {
        _textController.text =
            '*Service Toyota Check*\n\n'
            '*Hallo Semeton Agung Toyota Tabanan*\n'
            'Nama                   : ${widget.nmPlg}\n'
            'Type Kendaraan  : ${widget.model}\n'
            'No Polisi              : ${widget.nopol}\n\n'
            'Perkenalkan saya $_selectedPic Petugas booking service dari Bengkel Agung TOYOTA Tabanan\n'
            'Menginformasikan untuk Kendaraannya sudah waktu nya untuk *Melakukan Service Berkala dan Penggantian Oli Mesin Rutin 6 Bulan*.\n\n'
            '*Ambil Hak Gratis Service Toyota Mu yang berlaku dibulan Juni ini*\n\n'
            'Silahkan melakukan Booking Service, agar kami bisa menyiapkan Waktu, Spare Part dan Teknisi saat servis, dengan balas WA ini🙏.\n\n'
            'Manfaatkan Layanan Gratis untuk :\n'
            '🚗 TMS : Toyota Mobile Service (Service di tempat)\n'
            '🚚 Pick Up Delivery : Antar jemput service\n'
            'Terima kasih, semoga Aktifitasnya diberikan Kelancaran 🙏😇\n\n'
            '_abaikan pesan ini jika sudah melakukan service kendaraan rutin_\n\n'
            'Salam Agung Toyota Tabanan';
      }
    } else {
      if (pref.containsKey('kata2')) {
        final string2 = pref.getString('kata2');
        _textController.text = string2!
            .replaceAll('@_nama_pelanggan', widget.nmPlg)
            .replaceAll('@_type_kendaraan', widget.model)
            .replaceAll('@_pic', _selectedPic ?? '[PIC]')
            .replaceAll('@_no_polisi', widget.nopol);
      } else {
        _textController.text =
            '*Service Toyota Check*\n\n'
            '*Hallo Semeton Agung Toyota Tabanan*\n'
            'Nama                   : ${widget.nmPlg}\n'
            'Category  : ${widget.model}\n'
            'No Polisi              : ${widget.nopol}\n\n'
            'Perkenalkan saya $_selectedPic Petugas booking service dari Bengkel Agung TOYOTA Tabanan\n'
            'Menginformasikan untuk Kendaraannya sudah waktu nya untuk *Melakukan Service Berkala dan Penggantian Oli Mesin Rutin 6 Bulan*.\n\n'
            '*Ambil Hak Gratis Service Toyota Mu yang berlaku dibulan Juni ini*\n\n'
            'Silahkan melakukan Booking Service, agar kami bisa menyiapkan Waktu, Spare Part dan Teknisi saat servis, dengan balas WA ini🙏.\n\n'
            'Manfaatkan Layanan Gratis untuk :\n'
            '🚗 TMS : Toyota Mobile Service (Service di tempat)\n'
            '🚚 Pick Up Delivery : Antar jemput service\n'
            'Terima kasih, semoga Aktifitasnya diberikan Kelancaran 🙏😇\n\n'
            '_abaikan pesan ini jika sudah melakukan service kendaraan rutin_\n\n'
            'Salam Agung Toyota Tabanan';
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 880),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Dialog
              Row(
                children: [
                  const Icon(Icons.chat, color: Colors.teal, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Preview Pesan WhatsApp',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KataWA()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 15, thickness: 1),

              // Bagian Informasi & Dropdown PIC
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menggunakan Expanded agar tidak crash (unbounded width)
                  Expanded(
                    child: Column(
                      children: [
                        _buildInfoRow('Nama Pelanggan', widget.nmPlg),
                        _buildInfoRow('No. Polisi', widget.nopol),
                        _buildInfoRow('No. Handphone', widget.nohp),
                        _buildInfoRow('Model Mobil', widget.model),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 140,
                    child: DropdownButtonFormField<String>(
                      items: widget.list
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),

                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _selectedPic = v.toString();
                            _updateTextMessage(); // Update teks otomatis saat berganti nama PIC
                          });
                        } else {
                          setState(() {
                            _selectedPic = "[Nama PIC]";
                            _updateTextMessage();
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Wajib dipilih";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'PIC',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              const Text(
                'Edit Pesan:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              // Bubble Chat WhatsApp UI
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE5DDD5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _textController,
                  maxLines: 10,
                  minLines: 6,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'monospace',
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFDCF8C6),
                    filled: true,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Kirim WA
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: _selectedPic == null
                    ? null
                    : () async {
                        // String pesanSelesai = _textController.text;
                        String cleanPhone = widget.nohp.replaceAll(
                          RegExp(r'[^0-9]'),
                          '',
                        );

                        // B. Ubah awalan '08' menjadi '62' jika ada
                        if (cleanPhone.startsWith('0')) {
                          cleanPhone = '62${cleanPhone.substring(1)}';
                        }
                        if (cleanPhone.startsWith('8')) {
                          cleanPhone = '62${cleanPhone.substring(0)}';
                        }
                        String isiPesan = _textController.text;
                        String urlString =
                            "https://wa.me/$cleanPhone?text=${Uri.encodeComponent(isiPesan)}";

                        final Uri url = Uri.parse(urlString);
                        try {
                          // E. Jalankan URL (akan otomatis membuka aplikasi WA di HP / Web)
                          if (await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          )) {
                            // Berhasil membuka
                          } else {
                            _showSnackBar(
                              'Tidak dapat membuka WhatsApp',
                              Colors.red,
                            );
                          }
                        } catch (e) {
                          _showSnackBar('Terjadi kesalahan: $e', Colors.red);
                        }
                      },

                icon: const Icon(Icons.send_rounded),
                label: const Text(
                  'Kirim ke WhatsApp',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 13)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
