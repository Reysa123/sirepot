import 'package:sirepot/model/service_reminder.dart';

class KpiRepository {
  //final supabase = Supabase.instance.client;

  Future<List<ServiceReminder>> fetchKpiData(int page, int pageSize) async {
    final response = [
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
    ];
    // final response = await supabase
    //     .from('service_reminders')
    //     .select()
    //     .range(from, to)
    //     .order('last_service', ascending: false);

    return (response).map((e) => ServiceReminder.fromMap(e)).toList();
  }

  Future<List<ServiceReminder>> fetchServiceRemainder(
    int page,
    int pageSize,
  ) async {
    final response = [
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'no_hp': '086555566677',
        'last_service': DateTime.now(),
        'last_job': '3-6-2026',
        'program': 'CK',
      },
    ];
    // final response = await supabase
    //     .from('service_reminders')
    //     .select()
    //     .range(from, to)
    //     .order('last_service', ascending: false);

    return (response).map((e) => ServiceReminder.fromMap(e)).toList();
  }

  Future<List<CR7>> fetchcr7(int page, int pageSize) async {
    final response = [
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'perbaikancr7': 'Ganti Filter',
        'estimasi': '2.000.000',
        'sparepart': 'Filter',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'perbaikancr7': 'Ganti Filter',
        'estimasi': '2.000.000',
        'sparepart': 'Filter',
      },
      {
        'police_no': 'DK123GG',
        'model': 'TOYOTA',
        'nama_pelanggan': 'I WAYAN SUDARMA',
        'perbaikancr7': 'Ganti Filter',
        'estimasi': '2.000.000',
        'sparepart': 'Filter',
      },
    ];
    // final response = await supabase
    //     .from('service_reminders')
    //     .select()
    //     .range(from, to)
    //     .order('last_service', ascending: false);

    return (response).map((e) => CR7.fromMap(e)).toList();
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
