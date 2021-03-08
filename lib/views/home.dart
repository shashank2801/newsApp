import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
//import 'package:news/models/article_model.dart';
import 'package:news/models/categoryModel.dart';
import 'package:news/helper/article_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
 // List<ArticleModel> articles = <ArticleModel>[];
  Future<News> _news;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getArticleData();
  }

  void getArticleData() async {
    _news = Network().getArticleData();
    print(_news);
  }

  // getNews() async {
  //   News newsClass = News();
  //   await newsClass.getNews();
  //   articles = newsClass.news;
  //   print(articles[0]);
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Latest"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      // body: _loading
      //     ? Center(
      //         child: Container(
      //           child: CircularProgressIndicator(),
      //         ),
      //       )
       body    : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  children: [
                    // categories
                    Container(
                      height: 70,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            categoryName: categories[index].categoryName,
                            imgUrl: categories[index].imgUrl,
                          );
                        },
                      ),
                    ),
                    // blogs
                    Container(
                      child: FutureBuilder
                      ( 
                        future: _news,
                        builder: (BuildContext context, AsyncSnapshot<News> snapshot){
                          if(snapshot.hasData){
                            return Text("Hello");
                          }
                        }
                      ),
                    ),
                    // Container(
                      
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: articles.length,
                    //     itemBuilder: (context, index) {
                    //       return BlogTile(imgUrl: articles[index].imgUrl, title: articles[index].title, desc: articles[index].desc);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
            ),
          ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imgUrl, categoryName;

  const CategoryTile({Key key, this.imgUrl, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.only(right: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imgUrl,
                width: 120,
                //   height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                categoryName.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imgUrl, title, desc;

  const BlogTile(
      {Key key,
      @required this.imgUrl,
      @required this.title,
      @required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Image.network(imgUrl),
        Text(title,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        Text(desc),
      ],
    ),);
  }
}
