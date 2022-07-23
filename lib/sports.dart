import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';
import 'dart:convert';

class sports extends StatefulWidget {
  const sports({Key? key}) : super(key: key);

  @override
  State<sports> createState() => _sportsState();
}

class _sportsState extends State<sports> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YACHT',
      home: SportsPage(),
    );
  }
}


class SportsPage extends StatefulWidget {
  const SportsPage({Key? key}) : super(key: key);

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {

  final webScraper = WebScraper('https://sports.news.naver.com');
  List<Map<String, dynamic>>? sportsTitle;

  void fetchTitle() async {
    if (await webScraper.loadWebPage('/ranking/index.nhn?date=20220723')) {
      setState(() {
        sportsTitle = webScraper.getElement(
            '#_cs_production_type > div > div:nth-child(4) > div > div:nth-child(3) > div._normality > div.confirmed_status.new > div.turnout_graph._graph > div.tooltip_area._tooltip_wrapper > dl > div.title_wrap > dd', ['dd']
        );
      });

    }
    print(sportsTitle);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '스포츠',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 2.0,
      ),
      body: GestureDetector(
          onTap: (){
            fetchTitle();
          },
          child: Text('스포츠')),
    );
  }
}

