import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

//
final List<String> trendsList = []; // 검색어 저장
final List<String> trafficList = []; // 검색 횟수 저장
final Xml2Json xml2Json = Xml2Json();
// xml -> json client transformer
getXmlData() async { // async -> 비동기적 방식
  try {
    String url =
        'https://trends.google.co.kr/trends/trendingsearches/daily/rss?geo=KR'; // xml data
    http.Response response = await http.get(Uri.parse(url));
    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker(); // 개발 편의성을 위해 xml을 json으로 변환
    for (int i = 2; i <= 8; i++) { // 반복문을 통해 검색어와 검색 횟수를 각각 저장
      trendsList
          .add(jsonDecode(jsonString)["rss"]["channel"]["item"][i]["title"]); // json을 decoding하여 리스트에 저장
      trafficList
          .add(jsonDecode(jsonString)["rss"]["channel"]["item"][i]["ht:approx_traffic"]);
    }
    print(trendsList);
    print(trafficList);
    return jsonDecode(jsonString);
  } catch (e) {
    print('error: $e');
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                      top: BorderSide(color: Colors.grey, width: 0.5),
                    )),
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '   ${index + 1}. ',
                          style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: "Timmana"),
                        ),
                        Text(
                            '${trendsList[index]}',
                          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Timmana"),
                        ),
                        Text(
                          '    검색 횟수 ${trafficList[index]}',
                          style: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: "Timmana"),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
