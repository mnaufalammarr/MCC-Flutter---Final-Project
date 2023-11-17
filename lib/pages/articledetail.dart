import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metrodata_academy/provider/articleprovider.dart';

import '../models/articlemodel.dart';
import '../style.dart';
import '../widgets/menu.dart';

class ArticleDetailPage extends StatefulWidget {
  final String articleId;

  const ArticleDetailPage({
    Key? key,
    required this.articleId,
  }) : super(key: key);
  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ArticleProvider articleProvider;
  Article? article;

  @override
  void initState() {
    super.initState();
    articleProvider = ArticleProvider();
    fetchArticle();
    super.initState();
  }

  Future<void> fetchArticle() async {
    try {
      dynamic response = await onGetdetailArticle(context, widget.articleId);
      if (response != null && response['message'] == 'Success') {
        Map<String, dynamic> articleData = response['data'];
        setState(() {
          article = Article.fromJson(articleData);
        });
      } else {
        print("Error fetching article: Invalid response format");
        // Handle error appropriately, e.g., show an error message to the user
      }
    } catch (error) {
      print("Error fetching article: $error");
      // Handle error appropriately, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    if (article == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          backgroundColor: Styles.whiteblue,
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Image.asset(
              "assets/images/metrodata.png",
              width: 150,
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.closeEndDrawer();
                    //close drawer, if drawer is open
                  } else {
                    scaffoldKey.currentState!.openEndDrawer();
                    //open drawer, if drawer is closed
                  }
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                color: Styles.black,
              )
            ],
          ),
          endDrawer: Menu(),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    // Button width
                    height: 20, // Button height
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text("Artikel",
                          style: TextStyle(
                            color: Color.fromRGBO(30, 66, 159, 1),
                            fontSize: 10,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          )),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          disabledBackgroundColor:
                              Color.fromRGBO(225, 239, 254, 1)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    // Button width
                    height: 20, // Button height
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text(article!.categories![0]["name"].toString(),
                          style: TextStyle(
                            color: Color.fromRGBO(205, 122, 18, 1),
                            fontSize: 10,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                          )),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          disabledBackgroundColor:
                              Color.fromRGBO(254, 250, 236, 1)),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    article!.title.toString(),
                    style: Styles.titlearticledetail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Styles.detailTextStyle,
                              children: <TextSpan>[
                            TextSpan(text: "by "),
                            TextSpan(
                              text: article!.author!.name,
                              style: TextStyle(color: Styles.black),
                            ),
                            TextSpan(text: " in "),
                            TextSpan(text: "Mii")
                          ])),
                      Text(
                        article!.createdAt.toString(),
                        style: Styles.detailTextStyle,
                      ),
                      Text(
                        "${article!.counter} Views",
                        style: Styles.detailLinkTextStyle,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article!.imageUrl.toString(), // URL gambar artikel
                        height: 190, // Tinggi gambar
                        width: 333, // Lebar gambar mengisi seluruh kartu
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Handle error loading image
                          return Container(
                            color:
                                Colors.grey, // Warna latar belakang alternatif
                            height: 190,
                            width: 333,
                            child: Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                        // Mengatur bagaimana gambar mengisi ruang yang tersedia
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet",
                      style: Styles.detailTextStyle,
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      article!.body.toString(),
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(107, 114, 128, 1)),
                      textAlign: TextAlign.justify,
                    )),
              ])));
    }
  }

  Future<dynamic> onGetdetailArticle(BuildContext context, String id) async {
    dynamic result = await articleProvider.getarticledetail(id);

    if (result != null && result['message'] == "Success") {
      return result;
    } else {
      print("error123");
    }
  }
}
