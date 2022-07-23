import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:http/http.dart' as http;

class Covid extends StatefulWidget {
  const Covid({Key? key}) : super(key: key);

  @override
  State<Covid> createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YACHT',
      home: CovidHome(),
    );
  }
}

class CovidHome extends StatefulWidget {
  const CovidHome({Key? key}) : super(key: key);

  @override
  State<CovidHome> createState() => _CovidHomeState();
}

class _CovidHomeState extends State<CovidHome> {
  var currentPeople_2 = <String>[];
  var inTreat_2 = <String>[];
  var newPeople_2 = <String>[];
  var dead_2 = <String>[];

  void _getDataFromWeb() async {
    final response = await http.get(Uri.parse(
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=%EC%BD%94%EB%A1%9C%EB%82%98'));
    dom.Document document = parse.parse(response.body);

    setState(() {
      final currentPeople_1 = document.getElementsByClassName('info_01');
      currentPeople_2 = currentPeople_1
          .map((element) =>
              element.getElementsByClassName('info_num')[0].innerHtml)
          .toList();

      final inTreat_1 = document.getElementsByClassName('info_02');
      inTreat_2 = inTreat_1
          .map((element) =>
              element.getElementsByClassName('info_num')[0].innerHtml)
          .toList();

      final newPeople_1 = document.getElementsByClassName('info_03');
      newPeople_2 = newPeople_1
          .map((element) =>
              element.getElementsByClassName('info_num')[0].innerHtml)
          .toList();

      final dead_1 = document.getElementsByClassName('info_04');
      dead_2 = dead_1
          .map((element) =>
              element.getElementsByClassName('info_num')[0].innerHtml)
          .toList();
    });

    print(currentPeople_2[0]);
  }

  void initState() {
    super.initState();
    _getDataFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'COVID-19',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _getDataFromWeb();
            },
            child: Text("  오늘의 확진자 수",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "${currentPeople_2[0]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 44.4),
          Container(
            width: double.infinity,
            height: 370,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '  일일 확진',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      Text(
                        '재원 위중증',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${currentPeople_2[0]}',
                      style: TextStyle(color: Colors.red, fontSize: 23),
                    ),
                    Text(
                      '                             ${inTreat_2[0]}',
                      style: TextStyle(color: Colors.red, fontSize: 23),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '신규 입원',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      Text(
                        '일일 사망',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ]
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${newPeople_2[0]}',
                      style: TextStyle(color: Colors.red, fontSize: 23),
                    ),
                    Text(
                      '                               ${dead_2[0]}',
                      style: TextStyle(color: Colors.red, fontSize: 23),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
