// import 'dart:convert';

// import 'package:api/api.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Myapi extends StatefulWidget {
//   const Myapi({super.key});

//   @override
//   State<Myapi> createState() => _MyapiState();
// }

// class _MyapiState extends State<Myapi> {
//   Future<String> Fetchnews() async {
//     Uri url = Uri.parse(
//         'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=70353fcfc13943b98ce20eb710663121'); //paste the api key
//     print(url.toString());
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       print(response.body.toString());
//     }
//     return response.body;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder<String>(
//       future: Fetchnews(),
//       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//         // return snapshot.hasData ? Text("Data Existed"): Text("Error");
//         Widget w;
//         if (snapshot.hasData) {
//           var data = snapshot.data!;
//           var body = json.decode(data);\
//           int count = body["articles"].length;
//           print(count);
//           w = Center(
//               child: ListView.builder(
//                   itemCount: count,
//                   itemBuilder: (BuildContext context, int index) {
//                     String author =
//                         body["articles"][index]["author"].toString();
//                     String title = body["articles"][index]["title"].toString();
//                     String description =
//                         body["articles"][index]["title"].toString();
//                     String url = body["articles"][index]["url"].toString();
//                     String urlToImage =
//                         body["articles"][index]["urlToImage"].toString();
//                     String publishedAt =
//                         body["articles"][index]["publishedAt"].toString();
//                     String content =
//                         body["articles"][index]["content"].toString();
//                     return Card(
//                       elevation: 3,
//                       color: Colors.grey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             "${author}",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 fontStyle: FontStyle.italic),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             publishedAt.substring(0, 10) + "  ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             title,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Image.network(
//                             urlToImage,
//                             errorBuilder: (BuildContext context,
//                                 Object exception, StackTrace? stackTrace) {
//                               return const SizedBox();
//                             },
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailesNews(
//                                             title: title,
//                                             author: author,
//                                             date: publishedAt,
//                                             description: description,
//                                             urltoImage: urlToImage,
//                                             content: content,
//                                             url: url,
//                                             data: data,
//                                           )));
//                             },
//                             child: Align(
//                               alignment: Alignment.bottomRight,
//                               child: Text(
//                                 "Read More..." + " ",
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   }));
//         } else if (snapshot.hasError) {
//           w = Text("Error + ${snapshot.hasError}");
//         } else {
//           w = Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return w;
//       },
//     ));
//   }
// }

// class DetailesNews extends StatelessWidget {
//   DetailesNews({
//     super.key,
//     required this.title,
//     required this.author,
//     required this.date,
//     required this.description,
//     required this.urltoImage,
//     required this.content,
//     required this.data,
//     required this.url,
//   });
//   String title;
//   String author;
//   String date;
//   String description;
//   String urltoImage;
//   String content;
//   String url;
//   String data;

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
