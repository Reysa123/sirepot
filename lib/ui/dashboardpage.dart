class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SI-REPT Agung Toyota Tabanan")),
      body: Row(
        children: [
          // Sidebar Sederhana (Menu sesuai PDF)
          NavigationRail(
            extended: true,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.notifications), label: Text('Reminder Service')),
              NavigationRailDestination(icon: Icon(Icons.analytics), label: Text('Summary Reminder')),
              NavigationRailDestination(icon: Icon(Icons.star), label: Text('CR7')),
              NavigationRailDestination(icon: Icon(Icons.build), label: Text('Maintenance')),
            ],
            selectedIndex: 0,
          ),
          // Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dashboard KPI", style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 20),
                  // Search Bar sesuai Source 10
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Table Area (Bisa dibungkus BlocBuilder)
                  Expanded(child: KpiTableWidget(data: mockData)), 
                  // Pagination Footer sesuai Source 11 & 12
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Showing 1 to 13 of 100 entries"),
                      Row(
                        children: [
                          TextButton(onPressed: () {}, child: Text("Previous")),
                          // Loop nomor halaman
                          TextButton(onPressed: () {}, child: Text("1")),
                          TextButton(onPressed: () {}, child: Text("Next")),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}