import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/menu/navigation_bloc.dart';
import 'package:sirepot/bloc/menu/navigation_event.dart';
import 'package:sirepot/bloc/menu/navigation_state.dart';
import 'package:sirepot/ui/settings.dart';
import 'package:sirepot/ui/widgetb.dart';
import 'package:sirepot/ui/widgetc.dart';
import 'package:sirepot/ui/widgetd.dart';
import 'package:sirepot/ui/widgete.dart';
import 'package:sirepot/ui/widgetf.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: width > 1200 ? width : 1200,
                height: height > 580 ? height : 580,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    image: state.images[0],
                    fit: BoxFit
                        .fill, // Menyesuaikan gambar agar menutupi seluruh layar
                  ),
                ),
                child: Column(
                  children: [
                    // Header tetap di paling atas
                    _buildHeader(state.images[1], state.images[2]),

                    // Row untuk Sidebar dan Main Content dibungkus Expanded
                    // agar mengambil sisa tinggi layar yang tersedia
                    if (state is NaviNull) ...[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SIDEBAR
                            _buildSidebar(context, state.selectedIndex),

                            // MAIN CONTENT dibungkus Expanded agar lebarnya memenuhi sisa layar
                            Expanded(
                              child: _getMenuWidget(state.selectedIndex),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, int index) {
    return Container(
      width: 260,
      // Menggunakan warna gelap profesional seperti permintaan awal
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                _sidebarItem(
                  context,
                  'images/logo1.png',

                  "Dashboard KPI",
                  0,
                  index,
                ),
                _sidebarItem(
                  context,
                  'images/logo2.png',

                  "Reminder Service",
                  1,
                  index,
                ),
                _sidebarItem(
                  context,
                  'images/logo3.png',

                  "Summary Reminder",
                  2,
                  index,
                ),
                _sidebarItem(context, 'images/logo4.png', "CR7", 3, index),
                _sidebarItem(
                  context,
                  'images/logo5.png',

                  "Special Order Part",
                  4,
                  index,
                ),
                _sidebarItem(
                  context,
                  'images/logo6.png',

                  "Maintenance Database Sales",
                  5,
                  index,
                ),
                _sidebarItem(
                  context,
                  'images/setting.png',

                  "Setting/Pengaturan",
                  6,
                  index,
                ),
                Image.asset('images/sitajem.png', width: 150, height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMenuWidget(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Text(
            "Dashboard KPI Content",
            style: TextStyle(color: Colors.white),
          ),
        );
      case 1:
        return WidgetB();
      case 2:
        return KpiTableWidget();
      case 3:
        return WidgetD();
      case 4:
        return WidgetE();
      case 5:
        return WidgetF();
      case 6:
        return Setting();
      default:
        return const Center(child: Text("Page Not Found"));
    }
  }

  Widget _buildHeader(ImageProvider image2, ImageProvider image3) {
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
                image: image2,
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
                image: image3,
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
    String label,
    int index,
    int currentIndex,
  ) {
    final bool isSelected = index == currentIndex;

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
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        tileColor: isSelected ? Colors.red.withAlpha(3) : Colors.transparent,
        onTap: () {
          // Kirim event ke NavigationBloc
          context.read<NavigationBloc>().add(ChangeMenuEvent(index));
        },
      ),
    );
  }
}
