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

void main() {
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
