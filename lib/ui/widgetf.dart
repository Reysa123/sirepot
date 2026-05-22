import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_bloc.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetF extends StatelessWidget {
  const WidgetF({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpesialOrderPartBloc, SpesialOrderPartState>(
      builder: (context, state) {
        if (state is SpesialOrderPartLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SpesialOrderPartLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FILTER & SEARCH AREA
                _buildFilterSection(state.sales,state.vin,state.model),
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

  Widget _buildFilterSection(List<String> sales,List<String> vin,List<String> model,) {
    return Row(
      spacing: 15,
      children: [
        _filterDropdown("Sales", sales, (v) {}),

        _filterDropdown("VIN", vin, (v) {}),
        _filterDropdown("Model",model, (v) {}),
        // SizedBox(
        //   height: 43,
        //   width: 200, // Memberi lebar tetap pada search bar
        //   child: TextField(
        //     style: TextStyle(fontSize: 12),
        //     decoration: InputDecoration(
        //       hintText: "Search Police No",
        //       suffixIcon: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.black,
        //           borderRadius: BorderRadius.all(Radius.circular(50)),
        //         ),
        //         child: const Icon(Icons.search, color: Colors.white),
        //       ),
        //       fillColor: Colors.white,
        //       filled: true,
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       contentPadding: const EdgeInsets.symmetric(vertical: 0),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildDataTable(BuildContext context, List<SpesialOrderPart> data) {
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
          minWidth: 1000,
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
            DataColumn2(label: Text('Police No')),
            DataColumn2(label: Text('SA')),
            DataColumn2(label: Text('NO HP')),
            DataColumn2(label: Text('Nama Part')),
            DataColumn(label: Text('ETA')),
            DataColumn(label: Text('ATA')),
            DataColumn(label: Text('Action')),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(
    String label,
    List<String> list,
    Function(String? value) onKlik,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Border melengkung modern
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.red,
          ),
          style: const TextStyle(color: Colors.black, fontSize: 12),
          // Tambahkan value dan items sesuai kebutuhan logic Anda nantinya
          items: list
              .map(
                (data) => DropdownMenuItem(
                  value: data,
                  child: Text(data, style: TextStyle(fontSize: 10)),
                ),
              )
              .toList(),
          onChanged: (value) {
            onKlik(value);
          },
        ),
      ),
    );
  }
}

class ServiceReminderSource extends DataTableSource {
  final List<SpesialOrderPart> data;
  final BuildContext context;

  ServiceReminderSource(this.data, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final item = data[index];

    return DataRow2(
      cells: [
        DataCell(Text("${index + 1}")),
        DataCell(Text(item.policeNo)),
        DataCell(Text(item.model)),
        DataCell(Text(item.namaPelanggan)),
        DataCell(Text(item.noHp)),
        DataCell(Text(item.eta)),
        DataCell(Text(item.ata)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 20),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.phoneVolume, size: 16),
                color: Colors.red,
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
