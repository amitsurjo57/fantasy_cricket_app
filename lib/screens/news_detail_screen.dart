import 'package:fantasy_cricket_app/model/news_model.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModel newsModel;

  const NewsDetailScreen({super.key, required this.newsModel});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            floating: false,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.newsModel.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.newsModel.headline,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.newsModel.content,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
