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
      lastService: DateTime.parse(map['last_service']),
      lastJob: map['last_job'] ?? '',
      program: map['program'] ?? '',
    );
  }
}