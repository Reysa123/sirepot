import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirepot/bloc/cr7/cr7bloc.dart';
import 'package:sirepot/bloc/cr7/cr7event.dart';
import 'package:sirepot/bloc/kpi_bloc.dart';
import 'package:sirepot/bloc/kpi_event.dart';
import 'package:sirepot/bloc/menu/navigation_bloc.dart';
import 'package:sirepot/bloc/menu/navigation_event.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_bloc.dart';
import 'package:sirepot/bloc/spesialorderpart/spesialorderpart_event.dart';
import 'package:sirepot/repository/repository.dart';
import 'package:sirepot/ui/dashboardpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://szfcyvyqvmzvyiflrpps.supabase.co/',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN6ZmN5dnlxdm16dnlpZmxycHBzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA0NzkwNjQsImV4cCI6MjA5NjA1NTA2NH0.PKEoe8iULQ7JtScLmAniO8ODcbIMV57n7Ak6-8a_Mc4',
  );
  await Supabase.instance.client.auth.signInWithPassword(
    email: 'deskontara2@gmail.com',
    password: 'Sarmagedon1',
  );
  await initializeDateFormatting('id', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiRepositoryProvider(
      // 1. Sediakan Repository
      providers: [RepositoryProvider(create: (context) => KpiRepository())],
      child: MultiBlocProvider(
        // 2. Sediakan Bloc dan trigger fetch data pertama kali
        providers: [
          BlocProvider(
            create: (context) => KpiBloc(
              context.read<KpiRepository>(),
            )..add(FetchKpiData()), // Event awal untuk isi tabel [cite: 10, 11]
          ),
          BlocProvider(
            create: (context) => Cr7Bloc(
              context.read<KpiRepository>(),
            )..add(FetchCr7Data()), // Event awal untuk isi tabel [cite: 10, 11]
          ),
          BlocProvider(
            create: (context) =>
                SpesialOrderPartBloc(context.read<KpiRepository>())..add(
                  FetchSpesialOrderPartData(),
                ), // Event awal untuk isi tabel [cite: 10, 11]
          ),
          BlocProvider(
            create: (context) => NavigationBloc()
              ..add(
                ChangeMenuEvent(0),
              ), // Event awal untuk isi tabel [cite: 10, 11]
          ),
        ],
        child: MaterialApp(
          title: 'SI-REPT Agung Toyota',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const DashboardPage(),
        ),
      ),
    );
  }
}
