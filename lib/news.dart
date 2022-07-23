import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

List<String> newsTitleList = [];
final Xml2Json xml2Json = Xml2Json();
// xml -> json client transformer

List<String> linkList = [];

getNewsXmlData() async {
  try {
    String url =
        'https://trends.google.co.kr/trends/trendingsearches/daily/rss?geo=KR'; // xml data
    http.Response response = await http.get(Uri.parse(url));
    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker();
    for (int i = 1; i <= 5; i++) {
      newsTitleList
          .add(jsonDecode(jsonString.replaceAll('&#39;', "'"))["rss"]["channel"]["item"][i]["ht:news_item"][0]["ht:news_item_title"]);
    }
    newsTitleList.add(jsonDecode(jsonString)["rss"]["channel"]["item"][6]["ht:news_item"]["ht:news_item_title"]);
    newsTitleList.add(jsonDecode(jsonString)["rss"]["channel"]["item"][7]["ht:news_item"][0]["ht:news_item_title"]);

    for(int i = 1; i <= 5; i++) {
      linkList.add(jsonDecode(jsonString)["rss"]["channel"]["item"][i]["ht:news_item"][0]["ht:news_item_url"]);
    }
    linkList.add(jsonDecode(jsonString)["rss"]["channel"]["item"][6]["ht:news_item"]["ht:news_item_url"]);
    linkList.add(jsonDecode(jsonString)["rss"]["channel"]["item"][7]["ht:news_item"][0]["ht:news_item_url"]);

    for (int i = 0; i < newsTitleList.length; i++) {
      newsTitleList[i].replaceAll('&#39;', "'");
      newsTitleList[i].replaceAll('&quot;', "");
    }

    // var selectedJson = jsonDecode(jsonString)["rss"]["channel"]["item"][0]["title"];
    print(newsTitleList);
    return jsonDecode(jsonString);
  } catch (e) {
    print('error: $e');
  }
}

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YACHT',
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  Future<void> _launchInBrowser(String newsUrl) async {
    if (await canLaunch(newsUrl)) {
      await launch(
        newsUrl,
        forceWebView: true,
        forceSafariVC: true,
        headers: <String, String>{'my_header_key': 'my_header_value'}
      );
    } else {
      throw '웹 호출 실패 $newsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '뉴스',
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
              "오늘의 인기 급상승 뉴스",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: newsTitleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      _launchInBrowser(linkList[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                            top: BorderSide(color: Colors.grey, width: 0.5),
                          )),
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '   ${index + 1}. ${newsTitleList[index]}',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

