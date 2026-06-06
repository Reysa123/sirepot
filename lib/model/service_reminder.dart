import 'dart:convert';

class ServiceReminder {
  final int no;
  final String? policeNo;
  final String? model;
  final String? repairType;
  final String? lastServiceTgl; // Disimpan sebagai String, atau bisa di-parse ke DateTime jika formatnya konsisten
  final String? lastJob;
  final String? program;
  final String? month;
  final String? namaPelanggan;
  final String? contactPerson;
  final int? nomerTelephone;
  final String? ncs;
  final String? potensi;
  final String? cai;

  ServiceReminder({
    required this.no,
    this.policeNo,
    this.model,
    this.repairType,
    this.lastServiceTgl,
    this.lastJob,
    this.program,
    this.month,
    this.namaPelanggan,
    this.contactPerson,
    this.nomerTelephone,
    this.ncs,
    this.potensi,
    this.cai,
  });

  // Membuat salinan objek dengan beberapa perubahan nilai (Optional, berguna untuk state management)
  ServiceReminder copyWith({
    int? no,
    String? policeNo,
    String? model,
    String? repairType,
    String? lastServiceTgl,
    String? lastJob,
    String? program,
    String? month,
    String? namaPelanggan,
    String? contactPerson,
    int? nomerTelephone,
    String? ncs,
    String? potensi,
    String? cai,
  }) {
    return ServiceReminder(
      no: no ?? this.no,
      policeNo: policeNo ?? this.policeNo,
      model: model ?? this.model,
      repairType: repairType ?? this.repairType,
      lastServiceTgl: lastServiceTgl ?? this.lastServiceTgl,
      lastJob: lastJob ?? this.lastJob,
      program: program ?? this.program,
      month: month ?? this.month,
      namaPelanggan: namaPelanggan ?? this.namaPelanggan,
      contactPerson: contactPerson ?? this.contactPerson,
      nomerTelephone: nomerTelephone ?? this.nomerTelephone,
      ncs: ncs ?? this.ncs,
      potensi: potensi ?? this.potensi,
      cai: cai ?? this.cai,
    );
  }

  // Mengubah Map (JSON) menjadi Objek Dart
  factory ServiceReminder.fromJson(Map<String, dynamic> json) {
    return ServiceReminder(
      no: json['NO'] is String ? int.parse(json['NO']) : json['NO'] as int,
      policeNo: json['POLICE NO'] as String?,
      model: json['MODEL'] as String?,
      repairType: json['REPAIR TYPE'] as String?,
      lastServiceTgl: json['LAST SERVICE (TGL)'] as String?,
      lastJob: json['LAST JOB'] as String?,
      program: json['PROGRAM'] as String?,
      month: json['MONTH'] as String?,
      namaPelanggan: json['NAMA PELANGGAN'] as String?,
      contactPerson: json['CONTACT PERSON'] as String?,
      nomerTelephone: json['NOMER TELEPHONE'] is String 
          ? int.tryParse(json['NOMER TELEPHONE']) 
          : json['NOMER TELEPHONE'] as int?,
      ncs: json['NCS'] as String?,
      potensi: json['POTENSI'] as String?,
      cai: json['CAI'] as String?,
    );
  }

  // Mengubah Objek Dart menjadi Map (JSON) untuk dikirim ke API/Database
  Map<String, dynamic> toJson() {
    return {
      'NO': no,
      'POLICE NO': policeNo,
      'MODEL': model,
      'REPAIR TYPE': repairType,
      'LAST SERVICE (TGL)': lastServiceTgl,
      'LAST JOB': lastJob,
      'PROGRAM': program,
      'MONTH': month,
      'NAMA PELANGGAN': namaPelanggan,
      'CONTACT PERSON': contactPerson,
      'NOMER TELEPHONE': nomerTelephone,
      'NCS': ncs,
      'POTENSI': potensi,
      'CAI': cai,
    };
  }
}

class CR7 {
  final int no;
  final int? serviceOrder;
  final String? sa;
  final String? teknisi;
  final String? fo;
  final String? policeNo;
  final String? month;
  final String? category;
  final String? perbaikanCr7;
  final String? estimasiJob;
  final String? sparePart;
  final String? totalPart;
  final String? estimasi;
  final String? kondisiBan;
  final String? kondisiAki;
  final String? statusDp;
  final String? norangka;
  final String? namaPelanggan;
  final int? telephoneCp;
  final String? cai;
  final String? omset;

  CR7({
    required this.no,
    this.serviceOrder,
    this.sa,
    this.teknisi,
    this.fo,
    this.policeNo,
    this.month,
    this.category,
    this.perbaikanCr7,
    this.estimasiJob,
    this.sparePart,
    this.totalPart,
    this.estimasi,
    this.kondisiBan,
    this.kondisiAki,
    this.statusDp,
    this.norangka,
    this.namaPelanggan,
    this.telephoneCp,
    this.cai,
    this.omset,
  });

  // Mengubah dari Map (JSON) ke Object Dart
  factory CR7.fromJson(Map<String, dynamic> json) {
    return CR7(
      no: json['No'] as int,
      serviceOrder: json['Service Order'] as int?,
      sa: json['SA'] as String?,
      teknisi: json['Teknisi'] as String?,
      fo: json['FO'] as String?,
      policeNo: json['Police No'] as String?,
      month: json['Month'] as String?,
      category: json['Category'] as String?,
      perbaikanCr7: json['Perbaikan CR7'] as String?,
      estimasiJob: json['Estimasi Job'] as String?,
      sparePart: json['SPARE PART'] as String?,
      totalPart: json['TOTAL PART'] as String?,
      estimasi: json['Estimasi'] as String?,
      kondisiBan: json['Kondisi Ban'] as String?,
      kondisiAki: json['Kondisi Aki'] as String?,
      statusDp: json['Status DP'] as String?,
      norangka: json['Norangka'] as String?,
      namaPelanggan: json['Nama Pelanggan'] as String?,
      telephoneCp: json['Telephone CP'] as int?,
      cai: json['CAI'] as String?,
      omset: json['OMSET'] as String?,
    );
  }

  // Mengubah dari Object Dart ke Map (JSON) untuk dikirim ke API/Database
  Map<String, dynamic> toJson() {
    return {
      'No': no,
      'Service Order': serviceOrder,
      'SA': sa,
      'Teknisi': teknisi,
      'FO': fo,
      'Police No': policeNo,
      'Month': month,
      'Category': category,
      'Perbaikan CR7': perbaikanCr7,
      'Estimasi Job': estimasiJob,
      'SPARE PART': sparePart,
      'TOTAL PART': totalPart,
      'Estimasi': estimasi,
      'Kondisi Ban': kondisiBan,
      'Kondisi Aki': kondisiAki,
      'Status DP': statusDp,
      'Norangka': norangka,
      'Nama Pelanggan': namaPelanggan,
      'Telephone CP': telephoneCp,
      'CAI': cai,
      'OMSET': omset,
    };
  }
}


class SpesialOrderPart {
  final String policeNo;
  final String sa;
  final String model;
  final String namaPelanggan;
  final String noHp;
  final String namapart;
  final String eta;
  final String ata;

  SpesialOrderPart({
    required this.policeNo,
    required this.sa,
    required this.model,
    required this.namaPelanggan,
    required this.noHp,
    required this.namapart,
    required this.eta,
    required this.ata,
  });

  // Factory untuk mapping dari Supabase
  factory SpesialOrderPart.fromMap(Map<String, dynamic> map) {
    return SpesialOrderPart(
      policeNo: map['police_no'] ?? '',
      sa: map['sa'] ?? '',
      model: map['model'] ?? '',
      namaPelanggan: map['nama_pelanggan'] ?? '',
      noHp: map['no_hp'] ?? '',
      namapart: (map['namapart']),
      eta: map['eta'] ?? '',
      ata: map['ata'] ?? '',
    );
  }
}
