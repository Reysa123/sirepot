import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_bloc.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_event.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class WidgetE extends StatelessWidget {
  const WidgetE({super.key});

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
                _buildFilterSection(context, state),
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

  Widget _buildFilterSection(BuildContext ctx, SpesialOrderPartLoaded state) {
    return Row(
      spacing: 15,
      children: [
        _filterDropdown("SA", state.selectedSa, state.sa, (v) {
          ctx.read<SpesialOrderPartBloc>().add(
            FilterSpesialOrderPartData(sa: v),
          );
        }),

        // _filterDropdown("Month", ['a', 'b', 'c'], (v) {}),
        SizedBox(
          height: 43,
          width: 200, // Memberi lebar tetap pada search bar
          child: TextField(
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: "Search Police No",
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
              ctx.read<SpesialOrderPartBloc>().add(
                SearchSpesialOrderPartData(value),
              );
            },
          ),
        ),
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
    String? selectedValue,
    List<String> list,
    Function(String? value) onKlik,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 140,
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
        DataCell(Text(item.sa)),
        DataCell(Text(item.noHp)),
        DataCell(Text(item.namapart)),
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
