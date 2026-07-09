import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirepot/model/service_reminder.dart';
import 'package:http/http.dart' as http;

class KpiRepository {
  // final supabase = Supabase.instance.client;
  List<ServiceReminder> response = [];
  List<CR7> list = [];
  String url =
      'https://script.google.com/macros/s/AKfycbwGHHwDcffdmA3TEc79K1dmWKyXGC-dHhvJOV2FBUBc7vb_cvh5xPwGAAfsPzYMXB-9ig/exec';
  Future<List<ImageProvider>> getImage() async {
    final ImageProvider image1 = AssetImage("images/background.jpg");
    final ImageProvider image2 = AssetImage("images/sireport.png"),
        image3 = AssetImage("images/agung.png");
    return [image1, image2, image3];
  }

  Future<List<String>> listPetugas() async {
    List<String> list = [];
    SharedPreferences p = await SharedPreferences.getInstance();
    if (p.containsKey('list_petugas')) {
      final data1 = p.getStringList('list_petugas');
      list = data1!;
    } else {
      p.setStringList('list_petugas', ['TIKA', 'DWI', 'FUAH']);

      list = ["TIKA", "DWI", "FUAH"];
    }
    return list;
  }

  Future<List<ServiceReminder>> fetchKpiData(int page, int pageSize) async {
    //final response = await supabase.from('mra').select();

    //https://script.google.com/macros/s/AKfycbwGHHwDcffdmA3TEc79K1dmWKyXGC-dHhvJOV2FBUBc7vb_cvh5xPwGAAfsPzYMXB-9ig/exec
    final res = Uri.parse("$url?&sheets=0&columns=17");
    // print(res.toString());
    try {
      final data = await http.get(res);
      //print(data.body);

      //print(data.body);
      if (data.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON string
        final List<dynamic> jsonData = jsonDecode(data.body);
        // print(jsonData.toList().toString());
        response = jsonData.map((e) => ServiceReminder.fromJson(e)).toList();
        //print(response.toList().toString());
      } else {
        // Handle specific server failure scenarios
        throw Exception('Failed to load data. Status code: ${data.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
    //return (response).map((e) => ServiceReminder.fromJson(e)).toList();
  }

  Future<String> addKpiData(int row, List<String> value) async {
    //final response = await supabase.from('mra').select();
    final tglfu = DateFormat('yyyy/mm/dd').format(DateTime.now());
    String respon = "";
    //https://script.google.com/macros/s/AKfycbwGHHwDcffdmA3TEc79K1dmWKyXGC-dHhvJOV2FBUBc7vb_cvh5xPwGAAfsPzYMXB-9ig/exec
    final res = Uri.parse(
      "$url?sheets=0&columns=16&columns=15&columns=17&rows=$row&value=${value[0]}&value=${value[1]}&value=$tglfu",
    );
    // print(res.toString());
    try {
      final data = await http.get(res);
      //print(data.body);

      //print(data.body);
      if (data.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON string
        final jsonData = jsonDecode(data.body);
       // print(jsonData['status']);
        respon = jsonData['status'];
        //print(response.toList().toString());
      } else {
        // Handle specific server failure scenarios
        throw Exception('Failed to load data. Status code: ${data.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return respon;
    //return (response).map((e) => ServiceReminder.fromJson(e)).toList();
  }

  Future<List<String>> fetchPotensi() async {
    return response.map((v) => v.potensi!).toSet().toList();
  }

  Future<List<String>> fetchArea() async {
    return response.map((v) => v.area!).toSet().toList();
  }

  Future<List<String>> fetchProgram() async {
    // List<Map<String, dynamic>> response = await supabase
    //     .from('program_service')
    //     .select();

    return response.map((e) => e.program.toString()).toList().toSet().toList();
  }

  Future<List<String>> fetchRepair() async {
    // List<Map<String, dynamic>> response = await supabase
    //     .from('repair_type')
    //     .select();

    return response
        .map((e) => e.repairType.toString())
        .toList()
        .toSet()
        .toList();
  }

  Future<List<ServiceReminder>> fetchServiceRemainder(
    int page,
    int pageSize,
  ) async {
    //final response = await supabase.from('mra').select();

    return (response);
  }

  Future<List<CR7>> fetchcr7(int page, int pageSize) async {
    //final response = await supabase.from('mra').select();

    //https://script.google.com/macros/s/AKfycbwGHHwDcffdmA3TEc79K1dmWKyXGC-dHhvJOV2FBUBc7vb_cvh5xPwGAAfsPzYMXB-9ig/exec
    final res = Uri.parse("$url?&sheets=1&columns=21");
    // print(res.toString());
    try {
      final data = await http.get(res);
      //print(data.body);

      //print(data.body);
      if (data.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON string
        final List<dynamic> jsonData = jsonDecode(data.body);
        // print(jsonData.toList().toString());
        list = jsonData.map((e) => CR7.fromJson(e)).toList();
        //print(response.toList().toString());
      } else {
        // Handle specific server failure scenarios
        throw Exception('Failed to load data. Status code: ${data.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
    //return (response).map((e) => ServiceReminder.fromJson(e)).toList();
  }

  Future<List<String>> fetchSa() async {
    return list.map((e) => e.sa.toString()).toList().toSet().toList();
  }

  Future<List<String>> fetchVin() async {
    //List<Map<String, dynamic>> response = await supabase.from('vin').select();

    return list.map((e) => e.norangka.toString()).toList().toSet().toList();
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
