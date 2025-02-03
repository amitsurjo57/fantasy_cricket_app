import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasy_cricket_app/model/news_model.dart';
import 'package:fantasy_cricket_app/screens/news_detail_screen.dart';
import 'package:fantasy_cricket_app/widgets/news_card_widget.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  final List<NewsCardWidget> _listOfNews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('news').snapshots(),
          builder: (context, snapshot) {
            _listOfNews.clear();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            for (DocumentSnapshot snap in snapshot.data?.docs ?? []) {
              _listOfNews.add(
                NewsCardWidget(
                  newsModel: NewsModel(
                    image: snap.get('image'),
                    headline: snap.id,
                    content: snap.get('content'),
                  ),
                ),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: _listOfNews.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(
                        newsModel: _listOfNews[index].newsModel,
                      ),
                    ),
                  );
                },
                child: _listOfNews[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
