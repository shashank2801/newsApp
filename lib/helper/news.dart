import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = <ArticleModel> [];

  Future<void> getNews() async{
    var url = Uri.https("newsapi.org", "v2/top-headlines?country=in&category=business&apiKey=2f954fa32ae145ddb4ac1d44089f0074", {'q':'{http}'});

    //var response = await http.get(Uri.https('http://newsapi.org/v2','top-headlines?country=in&category=business&apiKey=2f954fa32ae145ddb4ac1d44089f0074'));
   var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            url: element['url'],
            imgUrl: element['urlToImage'],
            desc: element['description'],
            content: element['content'],
            author: element['author']
          );

          news.add(articleModel);
        }
      });
    }

  }
}