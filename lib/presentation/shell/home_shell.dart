import 'package:flutter/material.dart';
import '../Core/hcw_drawer.dart';
import '../bmi/bmi_screen.dart';
import '../core/hcw_colors.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart'; // <-- make sure this file exists from the Home UI I shared

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final pages = const [
    HomeScreen(), // real Home UI
    _Placeholder('Wishlist'),
    SearchScreen(),
    _Placeholder('Deals'),
    BMIScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = HCWColors();
    return Scaffold(
      drawer: const HCWDrawer(),
      appBar: AppBar(
        leading: Builder(
          // 👈 make the menu open the drawer
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 180,
              width: 180,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child:
                CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18)),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[index],
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: colors.teal.withOpacity(.12),
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_offer_outlined),
            selectedIcon: Icon(Icons.local_offer),
            label: 'Deals',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_weight_outlined),
            selectedIcon: Icon(Icons.monitor_weight),
            label: 'BMI',
          ),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}
