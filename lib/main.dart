import 'package:flutter/material.dart';

void main() {
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
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int screenIndex = 0; // 초기 네비게이터 위치는 0 (종합)
  List<Widget> screenList = [Text('종합'), Text('뉴스'), Text('연예'), Text('스포츠'), Text('코로나')];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '종합',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 2.0,
      ),
      body: screenList[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: screenIndex,
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/home.png', width: 20, height: 20,), label: '종합'),
          BottomNavigationBarItem(icon: Image.asset('assets/news.png', width: 20, height: 20,), label: '뉴스'),
          BottomNavigationBarItem(icon: Image.asset('assets/entertainment.png', width: 20, height: 20,), label: '연예'),
          BottomNavigationBarItem(icon: Image.asset('assets/sports.png', width: 20, height: 20,), label: '스포츠'),
          BottomNavigationBarItem(icon: Image.asset('assets/covid.png', width: 30, height: 30,), label: 'COVID-19')
        ],
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
      ),
    );
  }
}
