class ServiceReminder {
  final String? no;
  final String? policeNo;
  final String? model;
  final String? repairType;
  final String?
  lastServiceTgl; // Disimpan sebagai String, atau bisa di-parse ke DateTime jika formatnya konsisten
  final String? lastJob;
  final String? program;
  final String? month;
  final String? namaPelanggan;
  final String? contactPerson;
  final String? nomerTelephone;
  final String? ncs;
  final String? potensi;
  final String? cai;
  final String? area;
  final String? petugas;
  final String? tglfu;

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
    this.area,
    this.petugas,
    this.tglfu,
  });

  // Membuat salinan objek dengan beberapa perubahan nilai (Optional, berguna untuk state management)
  ServiceReminder copyWith({
    String? no,
    String? policeNo,
    String? model,
    String? repairType,
    String? lastServiceTgl,
    String? lastJob,
    String? program,
    String? month,
    String? namaPelanggan,
    String? contactPerson,
    String? nomerTelephone,
    String? ncs,
    String? potensi,
    String? cai,
    String? area,
    String? petugas,
    String? tglfu,
  }) {
    return ServiceReminder(
      petugas: petugas ?? this.petugas,
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
      area: area ?? this.area,
      tglfu: tglfu ?? this.tglfu,
    );
  }

  // Mengubah Map (JSON) menjadi Objek Dart
  factory ServiceReminder.fromJson(Map<String, dynamic> json) {
    // Ambil data mentah LAST SERVICE (TGL)
    //print(json);
    return ServiceReminder(
      no: "${json['NO'] ?? 0}",
      policeNo: json['POLICE NO'].toString(),
      model: json['MODEL'].toString(),
      repairType: json['REPAIR TYPE'].toString(),
      lastServiceTgl: "${json['LAST SERVICE (TGL)']}",
      lastJob: json['LAST JOB'].toString(),
      program: json['PROGRAM'].toString(),
      month: json['MONTH'].toString(),
      namaPelanggan: json['NAMA PELANGGAN'].toString(),
      contactPerson: json['CONTACT PERSON'].toString(),
      nomerTelephone: "${json['NOMER TELEPHONE'] ?? 0}",
      ncs: json['NCS'].toString(),
      potensi: json['POTENSI SERVICE'].toString(),
      area: json['AREA'].toString(),
      cai: json['CAI'].toString(),
      petugas: json['PETUGAS'].toString(),
      tglfu: json['TANGGAL FU'].toString(),
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
      'AREA': area,
      'PETUGAS': petugas,
      'TANGGAL FU': tglfu,
    };
  }
}

class CR7 {
  final String? no;
  final String? serviceOrder;
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
  final String? telephoneCp;
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
      no: "${json['No'] ?? 0}",
      serviceOrder: "${json['Service Order'] ?? 0}",
      sa: json['SA'].toString(),
      teknisi: json['Teknisi'].toString(),
      fo: json['FO'].toString(),
      policeNo: json['Police No'].toString(),
      month: json['Month'].toString(),
      category: json['Category'].toString(),
      perbaikanCr7: json['Perbaikan CR7'].toString(),
      estimasiJob: json['Estimasi Job'].toString(),
      sparePart: json['SPARE PART'].toString(),
      totalPart: json['TOTAL PART'].toString(),
      estimasi: json['Estimasi'].toString(),
      kondisiBan: json['Kondisi Ban'].toString(),
      kondisiAki: json['Kondisi Aki'].toString(),
      statusDp: json['Status DP'].toString(),
      norangka: json['Norangka'].toString(),
      namaPelanggan: json['Nama Pelanggan'].toString(),
      telephoneCp: "${json['Telephone CP'] ?? 0}",
      cai: json['CAI'].toString(),
      omset: json['OMSET'].toString(),
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
