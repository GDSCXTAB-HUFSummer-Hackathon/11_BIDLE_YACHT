import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

void main() {
  runApp(const MyApp());
  getXmlData();
}

final List<String> trendsList = [];
final Xml2Json xml2Json = Xml2Json();
// xml -> json client transformer
getXmlData() async {
  try {
    String url =
        'https://trends.google.co.kr/trends/trendingsearches/daily/rss?geo=KR'; // xml data
    http.Response response = await http.get(Uri.parse(url));
    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker();
    for (int i = 0; i <= 6; i++) {
      trendsList
          .add(jsonDecode(jsonString)["rss"]["channel"]["item"][i]["title"]);
    }
    // var selectedJson = jsonDecode(jsonString)["rss"]["channel"]["item"][0]["title"];
    print(trendsList);
    return jsonDecode(jsonString);
  } catch (e) {
    print('error: $e');
  }
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
  List<Widget> screenList = [
    Text('종합'),
    Text('뉴스'),
    Text('연예'),
    Text('스포츠'),
    Text('코로나')
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "오늘의 인기 급상승 검색어",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
                itemCount: trendsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5
                        ),
                        top: BorderSide(
                            color: Colors.grey,
                            width: 0.5
                        ),
                      )
                    ),
                    height: 70,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${index+1}. ${trendsList[index]}',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: screenIndex,
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
                'assets/entertainment.png',
                width: 20,
                height: 20,
              ),
              label: '연예'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/sports.png',
                width: 20,
                height: 20,
              ),
              label: '스포츠'),
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
            screenIndex = value;
          });
        },
      ),
    );
  }
}
