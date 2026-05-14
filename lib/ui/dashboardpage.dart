import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/kpi_bloc.dart';
import 'package:sirepot/bloc/kpi_event.dart';
import 'package:sirepot/bloc/kpi_state.dart';
import 'package:sirepot/ui/widgetb.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan background color abu-abu terang agar Card terlihat menonjol
      //backgroundColor: Colors.grey[100],
      body: BlocBuilder<KpiBloc, KpiState>(
        builder: (context, state) {
          print(state);
          if (state is KpiLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KpiLoaded) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                //color: Colors.red,
                image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit
                      .fill, // Menyesuaikan gambar agar menutupi seluruh layar
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
                        _buildSidebar(context, state),

                        // MAIN CONTENT dibungkus Expanded agar lebarnya memenuhi sisa layar
                        state.menu,
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, KpiState state) {
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
                  context,
                  'images/logo1.png',
                  state,
                  "Dashboard KPI",
                  isSelected: true,
                  index: 0,
                ),
                _sidebarItem(
                  context,
                  'images/logo2.png',
                  state,
                  "Reminder Service",
                  isSelected: true,
                  index: 1,
                ),
                _sidebarItem(
                  context,
                  'images/logo3.png',
                  state,
                  "Summary Reminder",
                  isSelected: true,
                  index: 2,
                ),
                _sidebarItem(context, 'images/logo4.png', state, "CR7"),
                _sidebarItem(
                  context,
                  'images/logo5.png',
                  state,
                  "Special Order Part",
                ),
                _sidebarItem(
                  context,
                  'images/logo6.png',
                  state,
                  "Maintenance Database Sales",
                ),
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

  Widget _sidebarItem(
    BuildContext context,
    String icon,
    KpiState data,
    String label, {
    bool isSelected = false,
    int index = 0,
  }) {
    if (data is KpiLoaded) {
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
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[400],
            ),
          ),
          tileColor: isSelected
              ? Colors.red.withOpacity(0.1)
              : Colors.transparent,
          onTap: () {
            switch (index) {
              case 0:
                context.read<KpiBloc>().add(FetchKpiData(widget: Container()));
                break;
              case 1:
                context.read<KpiBloc>().add(
                  FetchKpiData(widget: WidgetB(state: data.data)),
                );
                break;
              case 2:
                context.read<KpiBloc>().add(
                  FetchKpiData(
                    widget: Center(child: CircularProgressIndicator()),
                  ),
                );
                break;
              default:
            }
          },
        ),
      );
    } else if (data is KpiLoading) {
      context.read<KpiBloc>().add(
        FetchKpiData(widget: Center(child: CircularProgressIndicator())),
      );
    }
    return SizedBox();
  }
}
