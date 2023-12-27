import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/news_page_controller.dart';
import 'package:news_app/core/network/api%20handling/ChangeStateWidget.dart';
import 'package:news_app/view/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsPageController controller = Get.put(NewsPageController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(255, 31, 90, 139),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 180,
                  child: TextFormField(
                    onTap: () {
                      if (controller.newsModel != null) {
                        controller.makeNewsList();
                        print(
                            "the news list is empty and the newsmodel not null");
                      }
                    },
                    onChanged: (value) {
                      print(value);
                      controller.seaerchInNews(value);
                    },
                    controller: controller.searchWord,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Search"),
                  ),
                ),
              ),
              // IconButton(
              //     splashRadius: 20,
              //     onPressed: () {
              //       // controller.searchWord = TextEditingController();
              //       controller.getAllData();
              //     },
              //     icon: Icon(
              //       Icons.close,
              //       color: const Color.fromARGB(255, 79, 79, 79),
              //     ))
            ],
          ),
        ),
        actions: [
          GetBuilder<NewsPageController>(builder: (context) {
            return DropdownButtonHideUnderline(
              child: DropdownButton(
                iconSize: 30,
                value: controller.sectionName,
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
                items: const [
                  DropdownMenuItem(
                      value: 'All',
                      child: Text(
                        'All',
                      )),
                  DropdownMenuItem(value: 'us', child: Text('us')),
                  DropdownMenuItem(value: 'world', child: Text('world')),
                  DropdownMenuItem(value: 'nyregion', child: Text('nyregion')),
                  DropdownMenuItem(value: 'climate', child: Text('climate')),
                  DropdownMenuItem(value: 'style', child: Text('style')),
                  DropdownMenuItem(value: 'business', child: Text('business')),
                  DropdownMenuItem(value: 'podcasts', child: Text('podcasts')),
                  DropdownMenuItem(value: 'arts', child: Text('arts')),
                  DropdownMenuItem(value: 'opinion', child: Text('opinion')),
                  DropdownMenuItem(
                      value: 'realestate', child: Text('realestate')),
                ],
                onChanged: (section) {
                  controller.getSection(section!);
                },
              ),
            );
          }),
          const SizedBox(
            width: 20,
          )
          // ['us', 'world', 'nyregion', 'climate', 'style', 'business', 'podcasts', 'arts', 'opinion', 'realestate']
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<NewsPageController>(builder: (context) {
            return ChangeStateWidget(
              state: controller.bodyStatus.value,
              onFailure: Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.getAllData();
                  },
                  child: const Text("try again"),
                ),
              ),
              onSuccess: controller.resultsLength == 0
                  ? const Center(
                      child: Text("No news for now"),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.resultsLength,
                        itemBuilder: (context, index) => NewsCard(
                          controller: controller,
                          imageUrl: controller.searchWord.value.text == ""
                              ? controller.getImageUrl(
                                  index, controller.newsModel!.results)
                              : controller.getImageUrl(
                                  index, controller.newsAfterSearch),
                          title: controller.searchWord.value.text == ""
                              ? controller.newsModel!.results[index].title
                              : controller.newsAfterSearch[index].title,
                          author: controller.searchWord.value.text == ""
                              ? controller.newsModel!.results[index].byline
                              : controller.newsAfterSearch[index].byline,
                          section: controller.searchWord.value.text == ""
                              ? controller.newsModel!.results[index].section
                              : controller.newsAfterSearch[index].section,
                          newsAbstract: controller.searchWord.value.text == ""
                              ? controller
                                  .newsModel!.results[index].resultAbstract
                              : controller
                                  .newsAfterSearch[index].resultAbstract,
                        ),
                      ),
                    ),
            );
          })
        ],
      ),
    );
  }
}
