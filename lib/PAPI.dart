import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsApi extends StatefulWidget {
  const NewsApi({Key? key}) : super(key: key);

  @override
  _NewsApiState createState() => _NewsApiState();
}

class _NewsApiState extends State<NewsApi> {
  late Future<Map<String, dynamic>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Future<Map<String, dynamic>> fetchNews() async {
    final url = Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2024-04-25&sortBy=publishedAt&apiKey=70353fcfc13943b98ce20eb710663121");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load news");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News API"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No data available"));
          } else {
            var data = snapshot.data!;
            var articles = data["articles"];
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                return ArticleCard(article: article);
              },
            );
          }
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String author = article["author"] ?? "Unknown";
    String title = article["title"] ?? "No Title";
    String description = article["description"] ?? "No Description";
    String url = article["url"] ?? "";
    String urlToImage = article["urlToImage"] ?? "";
    String publishedAt = article["publishedAt"] ?? "";
    String content = article["content"] ?? "No Content";

    return Card(
      elevation: 3,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(author, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            SizedBox(height: 5),
            Text(publishedAt.substring(0, 10), style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            if (urlToImage.isNotEmpty)
              Image.network(urlToImage, errorBuilder: (context, error, stackTrace) => SizedBox.shrink()),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailDescription(
                      title: title,
                      author: author,
                      date: publishedAt,
                      description: description,
                      urltoImage: urlToImage,
                      content: content,
                      url: url,
                    ),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text("Read More...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDescription extends StatelessWidget {
  final String author;
  final String title;
  final String description;
  final String date;
  final String urltoImage;
  final String content;
  final String url;

  const DetailDescription({
    Key? key,
    required this.author,
    required this.title,
    required this.description,
    required this.date,
    required this.urltoImage,
    required this.content,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trending News"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Title: $title", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Author: $author", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            SizedBox(height: 10),
            Text("Date: ${date.substring(0, 10)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(height: 10),
            Text("Description: $description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            if (urltoImage.isNotEmpty)
        Image.network(urltoImage, errorBuilder: (context, error, stackTrace) => Text('Image was removed')),
    SizedBox(height: 10),
    Text("Content: $content", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    SizedBox(height: 10),
    InkWell(
    onTap: () async {
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
    },
    child: Text("Url: $url", style:TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue)),
    ),
                ],
            ),
        ),
    );
  }
}

