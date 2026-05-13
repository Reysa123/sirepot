import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/kpi_bloc.dart';
import 'package:sirepot/bloc/kpi_state.dart';
import 'package:sirepot/model/service_reminder.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan background color abu-abu terang agar Card terlihat menonjol
      backgroundColor: Colors.grey[100],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.red,

          // image: DecorationImage(
          //   image: AssetImage("assets/images/background_toyota.jpg"),
          //   fit:
          //       BoxFit.cover, // Menyesuaikan gambar agar menutupi seluruh layar
          // ),
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
                          _buildPaginationFooter(),
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
      color: const Color(0xFF1A1A1A),
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
              children: [
                _sidebarItem(
                  Icons.notifications,
                  "Reminder Service",
                  isSelected: true,
                ),
                _sidebarItem(Icons.analytics, "Summary Reminder"),
                _sidebarItem(Icons.star, "CR7"),
                _sidebarItem(Icons.inventory, "Special Order Part"),
                _sidebarItem(Icons.build, "Maintenance"),
                _sidebarItem(Icons.people, "Database Sales"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "AGUNG TOYOTA TABANAN",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          Row(
            children: [
              const Icon(Icons.account_circle, size: 30),
              const SizedBox(width: 10),
              Text("Admin Service", style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      children: [
        SizedBox(
          width: 300, // Memberi lebar tetap pada search bar
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Police No...",
              prefixIcon: const Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        const SizedBox(width: 15),
        _filterDropdown("Repair Type"),
        const SizedBox(width: 10),
        _filterDropdown("Month"),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFEB0A1E)),
              headingTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              columns: const [
                DataColumn(label: Text('NO')),
                DataColumn(label: Text('Police No')),
                DataColumn(label: Text('Model')),
                DataColumn(label: Text('Nama Pelanggan')),
                DataColumn(label: Text('Last Service')),
                DataColumn(label: Text('Action')),
              ],
              rows: List.generate(data.length, (index) {
                final item = data[index];
                return DataRow(
                  cells: [
                    DataCell(Text("${index + 1}")),
                    DataCell(Text(item.policeNo)),
                    DataCell(Text(item.model)),
                    DataCell(Text(item.namaPelanggan)),
                    DataCell(Text(item.lastService.toString().split(' ')[0])),
                    DataCell(const Icon(Icons.more_horiz, color: Colors.blue)),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Showing 1 to 13 of 100 entries",
            style: TextStyle(color: Colors.grey),
          ),
          Row(
            children: [
              _pageButton("Previous", isEnabled: false),
              _pageButton("1", isActive: true),
              _pageButton("2"),
              _pageButton("Next"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String label, {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.red : Colors.grey),
      title: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.grey[400]),
      ),
      tileColor: isSelected ? Colors.red.withOpacity(0.1) : Colors.transparent,
      onTap: () {},
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
