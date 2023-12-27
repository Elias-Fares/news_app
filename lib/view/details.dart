import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatelessWidget {
  final String newsAbstract;
  final String newsTitle;
  final String byLine;
  final String imageUrl;
  const Details(
      {super.key,
      required this.newsAbstract,
      required this.newsTitle,
      required this.byLine,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsTitle,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsAbstract,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 54, 54, 54)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                byLine,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 114, 114, 114)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
