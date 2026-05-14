import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:sirepot/model/service_reminder.dart';

class WidgetB extends StatelessWidget {
  final List<ServiceReminder> state;
  const WidgetB({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FILTER & SEARCH AREA
            _buildFilterSection(),
            const SizedBox(height: 20),

            // TABLE AREA dibungkus Expanded agar tabel bisa scrollable
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    child: _buildDataTable(state),
                  );
                },
              ),
            ),

            // FOOTER PAGINATION tetap di bawah setelah tabel
            // _buildPaginationFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      spacing: 15,
      children: [
        _filterDropdown("Repair Type"),
        _filterDropdown("SBE"),
        _filterDropdown("Program Service"),
        _filterDropdown("Month"),
        SizedBox(
          height: 43,
          width: 200, // Memberi lebar tetap pada search bar
          child: TextField(
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
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable(List<ServiceReminder> data) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable2(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFEB0A1E)),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          minWidth: 800,
          headingRowHeight: 28,
          dataTextStyle: TextStyle(
            fontSize: 12,
          ), // penting untuk horizontal scroll
          columnSpacing: 16,
          dataRowHeight: 30,
          horizontalMargin: 12,
          fixedLeftColumns: 1, // kolom NO tetap
          border: TableBorder.all(color: Colors.grey.shade300, width: 0.5),
          columns: const [
            DataColumn2(label: Text('NO'), fixedWidth: 50),
            DataColumn2(label: Text('Police No'), size: ColumnSize.L),
            DataColumn2(label: Text('Model'), size: ColumnSize.L),
            DataColumn2(label: Text('Nama Pelanggan'), size: ColumnSize.L),
            DataColumn2(label: Text('NO HP'), size: ColumnSize.L),
            DataColumn(label: Text('Last Service')),
            DataColumn(label: Text('Last Job')),
            DataColumn(label: Text('Program')),
            DataColumn(label: Text('Action')),
          ],
          rows: List.generate(data.length, (index) {
            final item = data[index];
            return DataRow2(
              onTap: () => print("Row $index tapped"),
              cells: [
                DataCell(Text("${index + 1}")),
                DataCell(Text(item.policeNo)),
                DataCell(Text(item.model)),
                DataCell(Text(item.namaPelanggan)),
                DataCell(Text(item.noHp)),
                DataCell(Text(item.lastService.toString())),
                DataCell(Text(item.lastJob)),
                DataCell(Text(item.program)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.message_sharp, size: 20),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.phone_forwarded, size: 20),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _filterDropdown(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(children: [Text(label), const Icon(Icons.arrow_drop_down)]),
    );
  }
}
