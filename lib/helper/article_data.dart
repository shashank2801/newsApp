import 'dart:convert';

import 'package:http/http.dart';
import 'package:news/models/articles.dart';

class Network{
  Future<News> getArticleData() async{
    var url = Uri.https("newsapi.org", "v2/top-headlines?country=in&category=business&apiKey=2f954fa32ae145ddb4ac1d44089f0074", {'q':'{http}'});

    final response = await get(url);

    if(response.statusCode == 200){
      return News.fromJson(json.decode(response.body));
    }

    else{
      print("Error $response.statusCode");
    }
  }
}