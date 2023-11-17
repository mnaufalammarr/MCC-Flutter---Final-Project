import 'package:flutter/material.dart';
import 'package:metrodata_academy/pages/createarticle.dart';

import '../models/articlemodel.dart';
import '../provider/articleprovider.dart';
import '../style.dart';
import '../widgets/articlecard.dart';
import 'articledetail.dart';
// import '../widgets/menu.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ArticleProvider articleProvider;
  late List<Article> articles = [];
  late bool isLoading = true;

  @override
  void initState() {
    articleProvider = new ArticleProvider();
    onGetListArticle(context, 1, "", "").then((jsonList) {
      print(jsonList);
      if (jsonList != null && jsonList is List<dynamic>) {
        setState(() {
          articles = jsonList.map((item) => Article.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        print("Error: Invalid JSON data format");
      }
    }).catchError((error) {
      print("Error: $error");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (articles.isEmpty) {
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
          // endDrawer: Menu(),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Styles.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateArticlePage()));
              print('Tombol tambah ditekan!');
            },
            tooltip: 'Buat artikel Baru', // Teks tooltip saat FAB ditekan lama
            child: Icon(
              Icons.add,
              size: 40,
            ), // Ikon tambah
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Artikel Belum Tersedia",
                  style: TextStyle(fontSize: 48),
                  textAlign: TextAlign.center,
                ),
              )),
        );
      } else {
        List<Article> lastThreeArticles = articles.length >= 3
            ? articles.sublist(articles.length - 3)
            : articles;

        Article firstArticle = lastThreeArticles[2];
        Article secondArticle = lastThreeArticles[1];
        Article thirdArticle = lastThreeArticles[0];

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
          // endDrawer: Menu(),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: Styles.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateArticlePage()));
            },
            tooltip: 'Buat artikel Baru', // Teks tooltip saat FAB ditekan lama
            child: Icon(
              Icons.add,
              size: 40,
            ), // Ikon tambah
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "Artikel, Informasi, dan Promosi Metrodata Academy",
                    style: Styles.headerarticle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Dapatkan artikel dan pengetahuan terbaru di dunia Teknologi Informasi serta nikmati promo training, workshop, dan berbagai keuntungan lainnya dari Metrodata Academy",
                    style: Styles.subheaderTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleDetailPage(
                                  articleId: "${firstArticle.id}",
                                )));
                  },
                  child: ArticleCard(
                    imageUrl: "${firstArticle.imageUrl}",
                    title: "${firstArticle.title}",
                    postdate: "${firstArticle.createdAt}",
                    jenispost: "Artikel",
                    category: "${firstArticle.categories![0]["name"]}",
                    header: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Program Magang dan Studi Independen Bersertifikat angkatan 4 akhirnya selesai diselenggarakan.",
                    style: Styles.subheaderTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ArticleCard(
                        imageUrl: "${secondArticle.imageUrl}",
                        title: "${secondArticle.title}",
                        postdate: "${secondArticle.createdAt}",
                        jenispost: "Artikel",
                        category: "${secondArticle.categories![0]["name"]}",
                        header: true,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ArticleCard(
                        imageUrl: "${thirdArticle.imageUrl}",
                        title: "${thirdArticle.title}",
                        postdate: "${thirdArticle.createdAt}",
                        jenispost: "Artikel",
                        category: "${thirdArticle.categories![0]["name"]}",
                        header: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    }
  }

  onGetListArticle(
      BuildContext context, int page, String title, String category) async {
    dynamic result =
        await articleProvider.getlistarticle(page, title, category);

    if (result != null && result['message'] == "Success") {
      print(result["data"]);
      return (result["data"]);
    } else {
      print("error123");
    }
  }
}
