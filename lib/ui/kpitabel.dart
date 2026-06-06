import 'package:flutter/material.dart';
import 'package:sirepot/model/service_reminder.dart';

class KpiTableWidget extends StatelessWidget {
  final List<ServiceReminder> data;

  const KpiTableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(Colors.red.shade900), // Warna Agung Toyota
            columns: const [
              DataColumn(label: Text('Police No', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Model', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Nama Pelanggan', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Last Service', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Action', style: TextStyle(color: Colors.white))),
            ],
            rows: data.map((item) => DataRow(cells: [
              DataCell(Text(item.policeNo!)),
              DataCell(Text(item.model!)),
              DataCell(Text(item.namaPelanggan!)),
              DataCell(Text(item.lastServiceTgl.toString().split(' ')[0])),
              DataCell(IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {})),
            ])).toList(),
          ),
        ),
      ),
    );
  }
}