import 'package:fantasy_cricket_app/model/news_model.dart';
import 'package:flutter/material.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel newsModel;

  const NewsCardWidget({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(newsModel.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    Text(
                      newsModel.headline,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      newsModel.content,
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
