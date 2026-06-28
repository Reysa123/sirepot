import 'package:flutter/material.dart';

class KpiTableWidget extends StatelessWidget {
  const KpiTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> kmHeaders = [
      '1.000 KM',
      '10.000 KM',
      '20.000 KM',
      '30.000 KM',
      '40.000 KM',
      '50.000 KM',
      '70.000 KM',
      '80.000 KM',
      '90.000 KM',
      '100.000 KM',
      '>100 KM',
    ];

    final List<Map<String, String>> reasons = [
      {'status': 'Tidak\nTersambung', 'reason': 'Salah Sambung'},
      {'status': 'Tidak\nTersambung', 'reason': 'Tidak Aktif'},
      {'status': 'Tersambung', 'reason': 'Booking'},
      {'status': 'Tersambung', 'reason': 'Sibuk Orang'},
      {'status': 'Tersambung', 'reason': 'Sibuk Kendaraan'},
      {'status': 'Tersambung', 'reason': 'Kend. Jarang dipakai'},
      {'status': 'Tersambung', 'reason': 'Tlp. Tidak dijawab'},
      {'status': 'Tersambung', 'reason': 'Kend. Sudah dijual'},
      {'status': 'Tersambung', 'reason': 'Belum ada Biaya'},
      {'status': 'Tersambung', 'reason': 'Operational Luar'},
      {'status': 'Tersambung', 'reason': 'Konfirmasi Pihak Lain'},
      {'status': 'Tersambung', 'reason': 'Kend. Sudah servis AT Lain'},
      {'status': 'Tersambung', 'reason': 'Kend. Sudah servis Bengkel lain'},
    ];

    final List<String> agents = ['TIKA', 'DWI', 'FUAH'];

    const double rowHeight = 30.0;
    int tidakTersambungCount = reasons
        .where((e) => e['status'] == 'Tidak\nTersambung')
        .length;
    int tersambungCount = reasons
        .where((e) => e['status'] == 'Tersambung')
        .length;

    return SingleChildScrollView(
      scrollDirection:
          Axis.vertical, // Scroll vertikal untuk melihat agent ke bawah
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: agents.map((agent) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32.0, right: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================================================
                // 1. BAGIAN KIRI: FIX / FROZEN (TIDAK IKUT COLOUMN SCROLL)
                // =========================================================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Kiri
                    Row(
                      children: [
                        _buildHeaderCell(agent, width: 100, height: 50),
                        _buildHeaderCell('REASON', width: 180, height: 50),
                      ],
                    ),
                    // Data Kiri (Merged Status & List Reason)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            _buildDataCell(
                              'Tidak\nTersambung',
                              width: 100,
                              height: tidakTersambungCount * rowHeight,
                            ),
                            _buildDataCell(
                              'Tersambung',
                              width: 100,
                              height: tersambungCount * rowHeight,
                            ),
                          ],
                        ),
                        Column(
                          children: reasons.map((item) {
                            return _buildDataCell(
                              item['reason']!,
                              width: 180,
                              height: rowHeight,
                              alignment: Alignment.centerLeft,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    // Total Call Spacer Kiri
                    Container(
                      width: 100 + 180,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                // =========================================================
                // 2. BAGIAN KANAN: SCROLLABLE (BISA DIGESER HORIZONTAL)
                // =========================================================
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Kanan
                        Row(
                          children: [
                            Column(
                              children: [
                                _buildHeaderCell(
                                  'REPAIR TYPE',
                                  width: 11 * 80.0,
                                  height: 25,
                                ),
                                Row(
                                  children: kmHeaders
                                      .map(
                                        (km) => _buildHeaderCell(
                                          km,
                                          width: 80,
                                          height: 25,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                            _buildHeaderCell('SUM', width: 60, height: 50),
                            _buildHeaderCell('%', width: 50, height: 50),
                          ],
                        ),
                        // Data Kanan (Grid Angka/KM, Sum, %)
                        Column(
                          children: reasons.map((_) {
                            return Row(
                              children: [
                                ...List.generate(
                                  11,
                                  (_) => _buildDataCell(
                                    '',
                                    width: 80,
                                    height: rowHeight,
                                  ),
                                ),
                                _buildDataCell(
                                  '',
                                  width: 60,
                                  height: rowHeight,
                                ),
                                _buildDataCell(
                                  '',
                                  width: 50,
                                  height: rowHeight,
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        // Total Call Kanan
                        Row(
                          children: [
                            Container(
                              width: 11 * 80.0,
                              height: 30,
                              color: Colors.grey[200],
                            ),
                            _buildHeaderCell(
                              'TOTAL CALL',
                              width: 60,
                              height: 30,
                              color: Colors.grey[300]!,
                              textColor: Colors.black,
                            ),
                            _buildDataCell('', width: 50, height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper Widget Cell Header
  Widget _buildHeaderCell(
    String text, {
    required double width,
    required double height,
    Color color = const Color(0xFFB71C1C),
    Color textColor = Colors.white,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey[400]!, width: 0.5),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper Widget Cell Data
  Widget _buildDataCell(
    String text, {
    required double width,
    required double height,
    Alignment alignment = Alignment.center,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]!, width: 0.5),
      ),
      alignment: alignment,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: Colors.black87),
      ),
    );
  }
}
