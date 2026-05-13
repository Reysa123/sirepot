import 'package:sirepot/model/service_reminder.dart';

class KpiRepository {
  //final supabase = Supabase.instance.client;

  Future<List<ServiceReminder>> fetchKpiData(int page, int pageSize) async {
    final from = page * pageSize;
    final to = from + pageSize - 1;
    final response = [];
    // final response = await supabase
    //     .from('service_reminders')
    //     .select()
    //     .range(from, to)
    //     .order('last_service', ascending: false);

    return (response).map((e) => ServiceReminder.fromMap(e)).toList();
  }
}
