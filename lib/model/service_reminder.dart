class ServiceReminder {
  final String policeNo;
  final String model;
  final String namaPelanggan;
  final String noHp;
  final DateTime lastService;
  final String lastJob;
  final String program;

  ServiceReminder({
    required this.policeNo,
    required this.model,
    required this.namaPelanggan,
    required this.noHp,
    required this.lastService,
    required this.lastJob,
    required this.program,
  });

  // Factory untuk mapping dari Supabase
  factory ServiceReminder.fromMap(Map<String, dynamic> map) {
    return ServiceReminder(
      policeNo: map['police_no'] ?? '',
      model: map['model'] ?? '',
      namaPelanggan: map['nama_pelanggan'] ?? '',
      noHp: map['no_hp'] ?? '',
      lastService: (map['last_service']),
      lastJob: map['last_job'] ?? '',
      program: map['program'] ?? '',
    );
  }
}

class CR7 {
  final String policeNo;
  final String model;
  final String namaPelanggan;
  final String perbaikan;
  final String estimasi;
  final String sparepart;

  CR7({
    required this.policeNo,
    required this.model,
    required this.namaPelanggan,
    required this.perbaikan,
    required this.estimasi,
    required this.sparepart,
  });

  // Factory untuk mapping dari Supabase
  factory CR7.fromMap(Map<String, dynamic> map) {
    return CR7(
      policeNo: map['police_no'] ?? '',
      model: map['model'] ?? '',
      namaPelanggan: map['nama_pelanggan'] ?? '',
      estimasi: map['estimasi'] ?? '',
      perbaikan: (map['perbaikan']),
      sparepart: map['sparepart'] ?? '',
    );
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
