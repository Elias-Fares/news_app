import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/network/api%20handling/api_provider.dart';
import 'package:news_app/model/news_model.dart';

class NewsPageController extends GetxController {
  late TextEditingController searchWord;
  late String sectionName;

  String pageUrl = "https://api.nytimes.com/svc/topstories/v2/home.json";
  ApiProvider _apiProvider = ApiProvider();
  RxString bodyStatus = "done".obs;
  NewsModel? newsModel;

  Future<dynamic> getAllData() async {
    print('start');
    bodyStatus.value = 'loading';
    update();
    print("====================$bodyStatus============================");
    final response = await _apiProvider.gets<Map<String, dynamic>, NewsModel>(
      pageUrl,
      query: {"api-key": "2U8paW7FGfMRydqO8xGxUAWuQpPusU3K"},
      headers: {},
      makingTheFromJsonPossible: (theComingJson) {
        newsModel = NewsModel.fromJson(theComingJson);
        return newsModel!;
      },
    );
    handleRespose(response);
    print("====================$bodyStatus============================");
    update();
  }

  Future<dynamic> getSectionNews(String section) async {
    searchWord = TextEditingController(text: "");
    print('start');
    bodyStatus.value = 'loading';
    update();
    print("====================$bodyStatus============================");
    final response = await _apiProvider.gets<Map<String, dynamic>, NewsModel>(
      pageUrl,
      query: {"api-key": "2U8paW7FGfMRydqO8xGxUAWuQpPusU3K"},
      headers: {},
      makingTheFromJsonPossible: (theComingJson) {
        newsModel = NewsModel.fromJson(theComingJson);
        newsModel!.results.removeWhere((element) =>
            element.section.toLowerCase() != section.toLowerCase());
        return newsModel!;
      },
    );
    handleRespose(response);
    print("====================$bodyStatus============================");
    update();
  }

  handleRespose(response) {
    if (response == 'error') {
      bodyStatus.value = 'error';
    } else {
      bodyStatus.value = 'done';
      return response;
    }
    return response;
  }

  //getters
  get resultsLength => newsModel == null
      ? 0
      : searchWord.value.text == ""
          ? newsModel!.results.length
          : newsAfterSearch.length;
  String getImageUrl(int index, List<Result> results) {
    String url = "";
    if (newsModel == null) {
      url = "";
    } else {
      if (results[index].multimedia == null) {
        url = "";
      } else {
        if (results[index].multimedia!.isEmpty) {
        } else {
          url = results[index].multimedia!.first.url;
        }
      }
    }
    return url;
  }

  //search section
  List<Result> newsList = [];
  List<Result> newsAfterSearch = [];
  void makeNewsList() {
    newsList = [];
    for (var element in newsModel!.results) {
      newsList.add(element);
    }
    update();
    print(
        "==============================the whole list==================================");
    print(newsList);
  }

  void seaerchInNews(String query) {
    newsAfterSearch = [];
    newsAfterSearch = newsList
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print(
        "===================================the filtered List=============================");
    print(newsAfterSearch);
    update();
  }

  void getSection(String section) {
    sectionName = section;
    section == "All" ? getAllData() : getSectionNews(section);
  }

  @override
  void onInit() {
    sectionName = "All";
    searchWord = TextEditingController(text: "");
    getAllData();
    super.onInit();
  }
}
