import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/kpi_bloc.dart';
import 'package:sirepot/bloc/kpi_event.dart';
import 'package:sirepot/bloc/kpi_state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:sirepot/ui/widgetwhatsapp.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'dart:typed_data';

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpiBloc, KpiState>(
      builder: (context, state) {
        if (state is KpiLoading) {
          return SizedBox.expand(
            child: Center(
              child: Column(
                children: [
                  Spacer(),
                  CircularProgressIndicator(color: Colors.white),
                  Text("Loading...", style: TextStyle(color: Colors.white)),
                  Spacer(),
                ],
              ),
            ),
          );
        }
        if (state is KpiLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FILTER & SEARCH AREA
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: _buildFilterSection(context, state),
                  ),
                ),
                const SizedBox(height: 8),

                // TABLE AREA dibungkus Expanded agar tabel bisa scrollable
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        child: _buildDataTable(context, state.data),
                      );
                    },
                  ),
                ),

                // FOOTER PAGINATION tetap di bawah setelah tabel
                // _buildPaginationFooter(),
              ],
            ),
          );
        }
        return const Center(child: Text('Tidak ada data ditemukan'));
      },
    );
  }

  Widget _buildFilterSection(BuildContext ctx, KpiLoaded state) {
    return Row(
      spacing: 8,
      children: [
        _filterDropdown("Repair Type", state.selectedRepair, state.repair, (v) {
          ctx.read<KpiBloc>().add(
            FilterKpiData(
              repair: v,
              sbe: state.selectedSbe,
              program: state.selectedProgram,
              month: state.selectedMonth,
              nopol: state.selectedNopol,
            ),
          );
        }),
        _filterDropdown("Potensi Service", state.selectedSbe, state.sbe, (v) {
          ctx.read<KpiBloc>().add(
            FilterKpiData(
              repair: state.selectedRepair,
              sbe: v,
              program: state.selectedProgram,
              month: state.selectedMonth,
              nopol: state.selectedNopol,
            ),
          );
        }),
        _filterDropdown(
          "Program Service",
          state.selectedProgram,
          state.program,
          (v) {
            ctx.read<KpiBloc>().add(
              FilterKpiData(
                repair: state.selectedRepair,
                sbe: state.selectedSbe,
                program: v,
                nopol: state.selectedNopol,
                month: state.selectedMonth,
              ),
            );
          },
        ),
        _filterDropdown("Month", state.selectedMonth, state.month, (v) {
          ctx.read<KpiBloc>().add(
            FilterKpiData(
              repair: state.selectedRepair,
              sbe: state.selectedSbe,
              program: state.selectedProgram,
              month: v,
              nopol: state.selectedNopol,
            ),
          );
        }),
        _filterDropdown("Area", state.selectedArea, state.area, (v) {
          ctx.read<KpiBloc>().add(
            FilterKpiData(
              repair: state.selectedRepair,
              sbe: state.selectedSbe,
              program: state.selectedProgram,
              month: state.selectedMonth,
              nopol: state.selectedNopol,
              area: v,
            ),
          );
        }),
        // TOMBOL PREVIEW DATA
        InkWell(
          onTap: () async {
            _showLoadingDialog(ctx, "Menyiapkan data...");
            await Future.delayed(const Duration(milliseconds: 300));

            // 3. Panggil fungsi untuk memproses dan membuka dialog pratinjau
            if (ctx.mounted) {
              Navigator.pop(ctx);

              _showPreviewDialog(ctx, state.data);
            }
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Icon(Icons.file_open, color: Colors.white),
          ),
        ),

        // TOMBOL EXPORT EXCEL
        InkWell(
          onTap: () async {
            _showLoadingDialog(ctx, "Menyiapkan data...");
            await Future.delayed(const Duration(milliseconds: 300));

            // 3. Panggil fungsi untuk memproses dan membuka dialog pratinjau
            if (ctx.mounted) {
              Navigator.pop(ctx);

              _exportToExcel(ctx, state.data);
            }
            //_exportToExcel(ctx, state.data);
          },
          child: Container(
            height: 45,
            width: 45,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const FaIcon(
              FontAwesomeIcons.fileExcel,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 43,
          width: 150, // Memberi lebar tetap pada search bar
          child: TextField(
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: "Search...",
              suffixIcon: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onSubmitted: (value) {
              ctx.read<KpiBloc>().add(SearchKpiData(value));
            },
          ),
        ),
      ],
    );
  }

  // ==================== DIALOG LOADING MELAYANG ====================
  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Pengguna tidak bisa menutup dialog secara manual
      builder: (BuildContext ctx) {
        return PopScope(
          canPop: false, // Mencegah tombol back menutup loading
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: Color(0xFFEB0A1E)),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== LOGIKA PREVIEW DIALOG ====================
  void _showPreviewDialog(BuildContext context, List data) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Preview Data Sebelum Export",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.amber.shade100,
                  width: double.infinity,
                  child: Text(
                    "Total data yang akan diexport: ${data.length} baris.",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.grey.shade200,
                        ),
                        columns: const [
                          DataColumn(label: Text('NO')),
                          DataColumn(label: Text('Police No')),
                          DataColumn(label: Text('NCS')),
                          DataColumn(label: Text('Model')),
                          DataColumn(label: Text('Nama Pelanggan')),
                          DataColumn(label: Text('NO HP')),
                          DataColumn(label: Text('Potensi')),
                          DataColumn(label: Text('Program')),
                        ],
                        rows: data.map((item) {
                          int index = data.indexOf(item) + 1;
                          return DataRow(
                            cells: [
                              DataCell(Text(index.toString())),
                              DataCell(Text(item.policeNo ?? '-')),
                              DataCell(Text(item.ncs ?? '-')),
                              DataCell(Text(item.model ?? '-')),
                              DataCell(Text(item.namaPelanggan ?? '-')),
                              DataCell(
                                Text(item.nomerTelephone?.toString() ?? '-'),
                              ),
                              DataCell(Text(item.potensi ?? '-')),
                              DataCell(Text(item.program ?? '-')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(ctx);
                _showLoadingDialog(context, "Menyiapkan data...");
                await Future.delayed(const Duration(milliseconds: 300));

                // 3. Panggil fungsi untuk memproses dan membuka dialog pratinjau
                if (context.mounted) {
                  Navigator.pop(context);

                  _exportToExcel(ctx, data);
                }
              },
              icon: const Icon(Icons.download),
              label: const Text("Export ke Excel Sekarang"),
            ),
          ],
        );
      },
    );
  } // ==================== LOGIKA EXPORT EXCEL ====================

  // ==================== LOGIKA EXPORT EXCEL (FLUTTER WEB) ====================

  Future<void> _exportToExcel(BuildContext context, List<dynamic> data) async {
    try {
      // Membuat workbook
      final workbook = xlsio.Workbook();

      final sheet = workbook.worksheets[0];
      sheet.name = 'Service Remainder';

      // Header
      final headers = [
        'NO',
        'Police No',
        'NCS',
        'Model',
        'Nama Pelanggan',
        'NO HP',
        'Last Service',
        'Last Job',
        'Potensi',
        'Program',
        'Area',
      ];

      // Style Header
      final headerStyle = workbook.styles.add('HeaderStyle');
      headerStyle.bold = true;
      headerStyle.fontSize = 11;
      headerStyle.hAlign = xlsio.HAlignType.center;
      headerStyle.vAlign = xlsio.VAlignType.center;

      // Isi Header
      for (int i = 0; i < headers.length; i++) {
        final cell = sheet.getRangeByIndex(1, i + 1);
        cell.setText(headers[i]);
        cell.cellStyle = headerStyle;
      }

      // Isi Data
      for (int i = 0; i < data.length; i++) {
        final item = data[i];
        final row = i + 2;

        sheet.getRangeByIndex(row, 1).setText('${i + 1}');
        sheet.getRangeByIndex(row, 2).setText(item.policeNo ?? '');
        sheet.getRangeByIndex(row, 3).setText(item.ncs ?? '');
        sheet.getRangeByIndex(row, 4).setText(item.model ?? '');
        sheet.getRangeByIndex(row, 5).setText(item.namaPelanggan ?? '');
        sheet
            .getRangeByIndex(row, 6)
            .setText(item.nomerTelephone?.toString() ?? '');
        sheet
            .getRangeByIndex(row, 7)
            .setText(item.lastServiceTgl?.toString() ?? '');
        sheet.getRangeByIndex(row, 8).setText(item.lastJob ?? '');
        sheet.getRangeByIndex(row, 9).setText(item.potensi ?? '');
        sheet.getRangeByIndex(row, 10).setText(item.program ?? '');
        sheet.getRangeByIndex(row, 11).setText(item.area ?? '');
        sheet.getRangeByIndex(row, 12).setText(item.ncs ?? '');
        sheet.getRangeByIndex(row, 13).setText(item.cai ?? '');
      }

      // Auto Fit Kolom
      for (int i = 1; i <= headers.length; i++) {
        sheet.autoFitColumn(i);
      }

      // Freeze Header
      // sheet.freezePanes(2, 1);

      // Generate Excel
      final List<int> bytes = workbook.saveAsStream();

      workbook.dispose();

      // Download ke Browser
      final blob = web.Blob(
        [Uint8List.fromList(bytes).toJS].toJS,
        web.BlobPropertyBag(
          type:
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        ),
      );

      final url = web.URL.createObjectURL(blob);

      final anchor = web.HTMLAnchorElement()
        ..href = url
        ..download =
            'Data-Remainder-Service-${DateTime.now().millisecondsSinceEpoch}.xlsx';

      web.document.body?.append(anchor);

      anchor.click();

      anchor.remove();

      web.URL.revokeObjectURL(url);

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Export Excel berhasil')));
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Export gagal : $e')));
      }
    }
  }

  Widget _buildDataTable(BuildContext context, List<ServiceReminder> data) {
    // Inisialisasi source data
    final source = ServiceReminderSource(data, context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: PaginatedDataTable2(
          // Konfigurasi Visual
          headingRowColor: WidgetStateProperty.all(const Color(0xFFEB0A1E)),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          dataTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          columnSpacing: 16,
          dataRowHeight: 30, // Tinggi baris sedikit diperbesar untuk kenyamanan
          headingRowHeight: 35,
          horizontalMargin: 12,
          minWidth: 1300,
          fit: FlexFit.loose,

          // Konfigurasi Pagination
          rowsPerPage: 13, // Jumlah baris per halaman
          autoRowsToHeight: true, // Otomatis menyesuaikan tinggi layar
          renderEmptyRowsInTheEnd: false,

          // Source Data
          source: source,

          // Kolom Tetap
          fixedLeftColumns: 2,

          columns: const [
            DataColumn2(label: Text('NO'), fixedWidth: 50),
            DataColumn2(label: Text('Police No'), size: ColumnSize.L),
            DataColumn2(label: Text('NCS'), size: ColumnSize.L),

            DataColumn2(label: Text('Model'), size: ColumnSize.M),
            DataColumn2(label: Text('Nama Pelanggan'), size: ColumnSize.L),
            DataColumn2(label: Text('NO HP'), size: ColumnSize.M),
            DataColumn(label: Text('Last Service')),
            DataColumn(label: Text('Last Job')),
            DataColumn2(label: Text('Potensi'), size: ColumnSize.L),
            DataColumn(label: Text('Program')),
            DataColumn2(label: Text('Area'), size: ColumnSize.L),
            DataColumn(label: Text('Action')),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(
    String label,
    String? selectedValue,
    List<String> list,
    Function(String? value) onKlik,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 135,
      child: DropDownTextField(
        dropDownItemCount: 12,
        // controller: controller,
        initialValue: selectedValue,
        clearOption: true, // 2. Aktifkan tombol clear bawaan (ikon silang)
        // 3. Konfigurasi Ikon Dropdown (Panah Bawah)
        dropDownIconProperty: IconProperty(
          icon: Icons.keyboard_arrow_down_rounded,
          color: Colors.red,
          size: 20,
        ),
        clearIconProperty: IconProperty(
          icon: Icons.clear,
          color: Colors.red,
          size: 20,
        ),
        listTextStyle: TextStyle(fontSize: 11),
        textStyle: TextStyle(fontSize: 11),
        // 4. Transformasi List<String> Anda menjadi List<DropDownValueModel>
        dropDownList: list.map((item) {
          return DropDownValueModel(name: item, value: item);
        }).toList(),

        // 5. Logika ketika item dipilih ATAU dihapus (clear)
        onChanged: (dynamic value) {
          if (value == null || value == "") {
            //  controller.clearDropDown;
            onKlik("null"); // Terpanggil saat tombol clear ditekan
          } else if (value is DropDownValueModel) {
            onKlik(value.value.toString()); // Terpanggil saat item dipilih
          }
        },

        // 6. Validasi Form (Optional, return null jika aman)
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Wajib dipilih";
          }
          return null;
        },

        // 7. Styling Input & Dekorasi
        textFieldDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 11, color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}

class ServiceReminderSource extends DataTableSource {
  final List<ServiceReminder> data;
  final BuildContext context;

  ServiceReminderSource(this.data, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];

    return DataRow2(
      cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.policeNo!)),
        DataCell(Text(item.ncs!)),
        DataCell(Text(item.model!)),
        DataCell(Text(item.namaPelanggan!)),
        DataCell(Text(item.nomerTelephone.toString())),
        DataCell(Text(item.lastServiceTgl.toString())),
        DataCell(Text(item.lastJob!)),
        DataCell(Text(item.potensi!)),
        DataCell(Text(item.program!)),
        DataCell(Text(item.area!)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => WhatsappWidget(
                      layer: true,
                      nmPlg: item.namaPelanggan ?? "Pelanggan",
                      nohp: item.nomerTelephone ?? '0',
                      nopol: item.policeNo ?? "No Plat",
                      model: item.model ?? "No Model",
                    ),
                  );
                },
                icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 20),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () async {
                  final result = await showDialog<List<dynamic>>(
                    context: context,
                    builder: (_) => const CallStatusDialog(),
                  );

                  if (result != null) {
                    debugPrint(result[0].title);
                    debugPrint(result[0].category);
                    debugPrint(result[1]);
                    //addKpiData(rows,[ncs,cai])
                    await KpiRepository().addKpiData(index + 2, [
                      result[1],
                      result[0].title,
                    ]);
                    context.read<KpiBloc>().add(FetchKpiData());
                  }
                },
                icon: const FaIcon(FontAwesomeIcons.phoneVolume, size: 16),
                color: item.ncs!.isNotEmpty()?Colors.yellow:Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class StatusItem {
  final String category;
  final String title;

  const StatusItem({required this.category, required this.title});
}

class CallStatusDialog extends StatefulWidget {
  const CallStatusDialog({super.key});

  @override
  State<CallStatusDialog> createState() => _CallStatusDialogState();
}

class _CallStatusDialogState extends State<CallStatusDialog> {
  SingleValueDropDownController dropDownController =
      SingleValueDropDownController();
  StatusItem? selectedStatus;
  String? ncs;
  final List<StatusItem> notConnected = [
    const StatusItem(category: 'Tidak Tersambung', title: 'Salah Sambung'),
    const StatusItem(category: 'Tidak Tersambung', title: 'Tidak Aktif'),
  ];

  final List<StatusItem> connected = [
    const StatusItem(category: 'Tersambung', title: 'Booking'),
    const StatusItem(category: 'Tersambung', title: 'Sibuk Orang'),
    const StatusItem(category: 'Tersambung', title: 'Sibuk Kendaraan'),
    const StatusItem(category: 'Tersambung', title: 'Kend. Jarang dipakai'),
    const StatusItem(category: 'Tersambung', title: 'Tlp. Tidak dijawab'),
    const StatusItem(category: 'Tersambung', title: 'Kend. Sudah dijual'),
    const StatusItem(category: 'Tersambung', title: 'Belum ada Biaya'),
    const StatusItem(category: 'Tersambung', title: 'Operasional Luar'),
    const StatusItem(category: 'Tersambung', title: 'Konfirmasi Pihak lain'),
    const StatusItem(
      category: 'Tersambung',
      title: 'Kend. Sudah servis AT Lain',
    ),
    const StatusItem(
      category: 'Tersambung',
      title: 'Kend. Sudah servis di AT TBN/ToSS',
    ),
    const StatusItem(
      category: 'Tersambung',
      title: 'Kend. Sudah servis Bengkel lain',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final allItems = [...notConnected, ...connected];

    return Dialog(
      backgroundColor: const Color(0xffC60000),
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        child: SizedBox(
          width: 900,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: RadioGroup<StatusItem>(
              groupValue: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "STATUS FOLLOW UP",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildCategoryCard(
                          title: "Tidak Tersambung",
                          icon: Icons.phone_disabled,
                          children: notConnected,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        flex: 6,
                        child: _buildCategoryCard(
                          title: "Tersambung",
                          icon: Icons.phone_in_talk,
                          children: connected,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  SizedBox(
                    width: 140,
                    child: DropDownTextField(
                      controller: dropDownController,
                      dropDownItemCount: 4,
                      clearOption: true,
                      dropDownIconProperty: IconProperty(
                        icon: Icons.keyboard_arrow_down_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                      clearIconProperty: IconProperty(
                        icon: Icons.clear,
                        color: Colors.red,
                        size: 20,
                      ),
                      listTextStyle: const TextStyle(fontSize: 12),
                      textStyle: const TextStyle(fontSize: 12),
                      // Perbaikan: Memisahkan string array dengan benar
                      dropDownList: const [
                        DropDownValueModel(name: "TIKA", value: "TIKA"),
                        DropDownValueModel(name: "DWI", value: "DWI"),
                        DropDownValueModel(name: "FUAH", value: "FUAH"),
                      ],
                      onChanged: (dynamic value) {
                        if (value is DropDownValueModel) {
                          setState(() {
                            ncs = value.value
                                .toString(); // Update teks otomatis saat berganti nama PIC
                          });
                        } else {
                          setState(() {
                            ncs = "[Nama PIC]";
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Wajib dipilih";
                        }
                        return null;
                      },
                      textFieldDecoration: const InputDecoration(
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
                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      selectedStatus == null
                          ? "Belum ada status dipilih"
                          : "Status terpilih : ${selectedStatus!.title}, PIC : $ncs",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("BATAL"),
                      ),

                      const SizedBox(width: 10),

                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                        ),
                        onPressed:
                            selectedStatus == null ||
                                ncs == "[Nama PIC]" ||
                                ncs == null
                            ? null
                            : () {
                                Navigator.pop(context, [selectedStatus, ncs]);
                              },
                        icon: const Icon(Icons.check),
                        label: const Text("SIMPAN"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required IconData icon,
    required List<StatusItem> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24, width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            // height: 20,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(10),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: children.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),

                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 8),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(14),
                      // ),
                      child: RadioListTile<StatusItem>(
                        //contentPadding: EdgeInsets.only(bottom: 10),
                        value: item,
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        activeColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
