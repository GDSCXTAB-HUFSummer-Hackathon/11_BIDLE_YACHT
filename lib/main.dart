import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:yacht/mainpage.dart';
import 'package:yacht/news.dart';
import 'package:yacht/sports.dart';
import 'package:yacht/covid.dart';

void main() {
  getXmlData();
  getNewsXmlData();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YACHT',
      home: MainHome(),
    );
  }
}

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NavigatorPage(),
      ),

    );
  }
}

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedIndex = 0;
  List _pages = [MainPage(), News(), sports(), Text("연예"), Covid()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home.png',
                width: 20,
                height: 20,
              ),
              label: '종합'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/news.png',
                width: 20,
                height: 20,
              ),
              label: '뉴스'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/sports.png',
                width: 20,
                height: 20,
              ),
              label: '스포츠'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/entertainment.png',
                width: 20,
                height: 20,
              ),
              label: '연예'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/covid.png',
                width: 30,
                height: 30,
              ),
              label: 'COVID-19')
        ],
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}

