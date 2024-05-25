import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NewsApi",
          ),
        ),
        body: FutureBuilder<String>(
          future: api(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            // return snapshot.hasData ? Text("Data Existed"): Text("Error");
            Widget w;
            if (snapshot.hasData) {
              var data = snapshot.data!;
              var body = json.decode(data);
              int count = body["articles"].length;
              print(count);

              w = Center(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    String author =
                        body["articles"][index]["author"].toString();
                    String title = body["articles"][index]["title"].toString();
                    String description =
                        body["articles"][index]["title"].toString();
                    String url = body["articles"][index]["url"].toString();
                    String urlToImage =
                        body["articles"][index]["urlToImage"].toString();
                    String publishedAt =
                        body["articles"][index]["publishedAt"].toString();
                    String content =
                        body["articles"][index]["content"].toString();
                    return Card(
                      elevation: 2,
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${author}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            publishedAt.substring(0, 10) + " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Image.network(
                            urlToImage,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const SizedBox();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                          title: title,
                                          author: author,
                                          date: publishedAt,
                                          description: description,
                                          urltoImage: urlToImage,
                                          content: content,
                                          url: url)));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Read More......" + "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              w = Text("Error+ ${snapshot.hasError}");
            } else {
              w = Center(
                child: CircularProgressIndicator(),
              );
            }
            return w;
          },
        ));
  }

  Future<String> api() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2023-11-01&sortBy=publishedAt&apiKey=70353fcfc13943b98ce20eb710663121"); //paste the api key
    print(url.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body.toString());
    }
    return response.body;
  }
}

class Details extends StatelessWidget {
  Details(
      {Key? key,
      required this.title,
      required this.author,
      required this.date,
      required this.description,
      required this.urltoImage,
      required this.content,
      required this.url})
      : super(key: key);
  String author;
  String title;
  String description;
  String date;
  String urltoImage;
  String content;
  String url;

  @override
  Widget build(BuildContext context) {
    print("=======================" + urltoImage);
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending News"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Title: ${title}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Author: ${author}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Date : ${date.substring(0, 10)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Description: ${description}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            // ignore: unnecessary_null_comparison

            Image.network(
              urltoImage,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text('Image was Removed');
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Content: ${content}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                await launchUrl(
                  Uri.parse(url),
                );
              },
              child: Text(
                "Url: ${url}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
