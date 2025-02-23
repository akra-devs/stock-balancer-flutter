import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'rebalancing_tab.dart';
import 'portfolio_tab.dart';

void main() {
  runApp(RebalancingApp());
}

class RebalancingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '리벨런싱 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  /// 각 탭을 BlocProvider로 감싸서, 필요한 Bloc을 주입해 줍니다.
  final List<Widget> _pages = [
    // 계산 탭
    BlocProvider(
      create: (_) => RebalancingBloc(),
      child: RebalancingHomePage(),
    ),
    // 포트폴리오 탭
    BlocProvider(
      create: (_) => PortfolioBloc(),
      child: PortfolioPage(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: '계산',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: '포트폴리오',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}