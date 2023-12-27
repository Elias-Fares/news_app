import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/news_page_controller.dart';
import 'package:news_app/view/details.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String section;
  final String newsAbstract;
  final NewsPageController controller;
  const NewsCard({
    super.key,
    required this.controller,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.section, required this.newsAbstract,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: InkWell(
        onTap: () {
          Get.to(Details(
              newsAbstract: newsAbstract,
              newsTitle: title,
              byLine: author,
              imageUrl: imageUrl));
        },
        child: Container(
          // height: 140,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 197, 197, 197),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text("No image"),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/loading.jpg"));
                        },
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                        width: 190,
                        child: Text(
                          author,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(color: Colors.grey),
                        )),
                    SizedBox(
                      child: Text(
                        section.toUpperCase(),
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
