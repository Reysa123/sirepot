import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/kpi_bloc.dart';
import 'package:sirepot/bloc/kpi_state.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:data_table_2/data_table_2.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan background color abu-abu terang agar Card terlihat menonjol
      //backgroundColor: Colors.grey[100],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          //color: Colors.red,
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.fill, // Menyesuaikan gambar agar menutupi seluruh layar
          ),
        ),
        child: Column(
          children: [
            // Header tetap di paling atas
            _buildHeader(),

            // Row untuk Sidebar dan Main Content dibungkus Expanded
            // agar mengambil sisa tinggi layar yang tersedia
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SIDEBAR
                  _buildSidebar(context),

                  // MAIN CONTENT dibungkus Expanded agar lebarnya memenuhi sisa layar
                  Expanded(
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
                            child: BlocBuilder<KpiBloc, KpiState>(
                              builder: (context, state) {
                                if (state is KpiLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is KpiLoaded) {
                                  // Menggunakan LayoutBuilder agar tabel fleksibel terhadap lebar container
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SizedBox(
                                        width: constraints.maxWidth,
                                        child: _buildDataTable(state.data),
                                      );
                                    },
                                  );
                                } else if (state is KpiError) {
                                  return Center(child: Text(state.message));
                                }
                                return const Center(
                                  child: Text(
                                    "Pilih menu untuk menampilkan data",
                                  ),
                                );
                              },
                            ),
                          ),

                          // FOOTER PAGINATION tetap di bawah setelah tabel
                          // _buildPaginationFooter(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 260,
      // Menggunakan warna gelap profesional seperti permintaan awal
      color: Colors.transparent,
      child: Column(
        children: [
          // const DrawerHeader(
          //   child: Center(
          //     child: Text(
          //       "SI-REPT",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 28,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                _sidebarItem(
                  'images/logo1.png',
                  "Reminder Service",
                  isSelected: true,
                ),
                _sidebarItem('images/logo1.png', "Summary Reminder"),
                _sidebarItem('images/logo2.png', "CR7"),
                _sidebarItem('images/logo3.png', "Special Order Part"),
                _sidebarItem('images/logo4.png', "Maintenance"),
                _sidebarItem('images/logo1.png', "Database Sales"),
                Image.asset('images/sitajem.png', width: 150, height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 500,
            height: 100,
            decoration: BoxDecoration(
              //color: Colors.red,
              image: DecorationImage(
                image: AssetImage("images/sireport.png"),
                fit: BoxFit
                    .fill, // Menyesuaikan gambar agar menutupi seluruh layar
              ),
            ),
          ),
          Container(
            width: 200,
            height: 70,
            decoration: BoxDecoration(
              //color: Colors.red,
              image: DecorationImage(
                image: AssetImage("images/agung.png"),
                fit: BoxFit
                    .fill, // Menyesuaikan gambar agar menutupi seluruh layar
              ),
            ),
          ),
        ],
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
          ),
          minWidth: 800,
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

  Widget _sidebarItem(String icon, String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListTile(
        leading: Image.asset(
          icon,
          width: 50,
          height: 50,
          color: isSelected ? Colors.white : Colors.grey[400],
        ),
        title: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.grey[400]),
        ),
        tileColor: isSelected
            ? Colors.red.withOpacity(0.1)
            : Colors.transparent,
        onTap: () {},
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

  Widget _pageButton(
    String text, {
    bool isActive = false,
    bool isEnabled = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isActive ? Colors.red : Colors.white,
          foregroundColor: isActive
              ? Colors.white
              : (isEnabled ? Colors.blue : Colors.grey),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        onPressed: isEnabled ? () {} : null,
        child: Text(text),
      ),
    );
  }
}
