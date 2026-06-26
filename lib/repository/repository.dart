import 'dart:convert';

import 'package:sirepot/model/service_reminder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class KpiRepository {
  final supabase = Supabase.instance.client;

  Future<List<ServiceReminder>> fetchKpiData(int page, int pageSize) async {
    //final response = await supabase.from('mra').select();
    List<ServiceReminder> response = [];
    final res = Uri.parse(
      "https://script.google.com/macros/s/AKfycbwGHHwDcffdmA3TEc79K1dmWKyXGC-dHhvJOV2FBUBc7vb_cvh5xPwGAAfsPzYMXB-9ig/exec?&sheets=0&columns=15",
    );
    print(res.toString());
    try {
      final data = await http.get(res);
      //print(data.body);

      //print(data.body);
      if (data.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON string
        final List<dynamic> jsonData = jsonDecode(data.body);
        print(jsonData.toList().toString());
        response = jsonData.map((e) => ServiceReminder.fromJson(e)).toList();
        print(response.toList().toString());
      } else {
        // Handle specific server failure scenarios
        throw Exception('Failed to load data. Status code: ${data.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
    return response;
    //return (response).map((e) => ServiceReminder.fromJson(e)).toList();
  }

  Future<List<String>> fetchProgram() async {
    List<Map<String, dynamic>> response = await supabase
        .from('program_service')
        .select();

    return response.map((e) => e['PROGRAM'].toString()).toList();
  }

  Future<List<String>> fetchRepair() async {
    List<Map<String, dynamic>> response = await supabase
        .from('repair_type')
        .select();

    return response.map((e) => e['REPAIR TYPE'].toString()).toList();
  }

  Future<List<ServiceReminder>> fetchServiceRemainder(
    int page,
    int pageSize,
  ) async {
    final response = await supabase.from('mra').select();

    return (response).map((e) => ServiceReminder.fromJson(e)).toList();
  }

  Future<List<CR7>> fetchcr7(int page, int pageSize) async {
    final response = await supabase.from('cr7').select();

    return (response).map((e) => CR7.fromJson(e)).toList();
  }

  Future<List<String>> fetchSa() async {
    List<Map<String, dynamic>> response = await supabase.from('sa').select();

    return response.map((e) => e['SA'].toString()).toList();
  }

  Future<List<String>> fetchVin() async {
    List<Map<String, dynamic>> response = await supabase.from('vin').select();

    return response.map((e) => e['Norangka'].toString()).toList();
  }

  Future<List<String>> fetchMonth() async {
    final month = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return month;
  }

  Future<List<SpesialOrderPart>> fetchSpesialOrder(
    int page,
    int pageSize,
  ) async {
    final response = [
      {
        'police_no': 'DK123GG',
        'sa': 'Budi',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '08123456789',
        'namapart': 'Filter',
        'eta': 'Eta',
        'ata': 'ATA',
      },
      {
        'police_no': 'DK123GG',
        'sa': 'Budi',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '08123456789',
        'namapart': 'Filter',
        'eta': 'Eta',
        'ata': 'ATA',
      },
      {
        'police_no': 'DK123GG',
        'sa': 'Budi',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '08123456789',
        'namapart': 'Filter',
        'eta': 'Eta',
        'ata': 'ATA',
      },
    ];
    // final response = await supabase
    //     .from('service_reminders')
    //     .select()
    //     .range(from, to)
    //     .order('last_service', ascending: false);

    return (response).map((e) => SpesialOrderPart.fromMap(e)).toList();
  }
}
