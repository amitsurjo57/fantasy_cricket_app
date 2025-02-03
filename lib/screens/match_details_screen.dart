import 'package:fantasy_cricket_app/model/score_model.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'scoreboard_screen.dart';
import 'squad_screen.dart';

class MatchDetailsScreen extends StatefulWidget {
  final ScoreModel scoreModel;

  const MatchDetailsScreen({
    super.key,
    required this.scoreModel,
  });

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scoreModel.matchTitle),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: _currentPage == 0
                          ? AppUtils.loaderColor
                          : Colors.white,
                      child: const Text(
                        "Scoreboard",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: _currentPage == 1
                          ? AppUtils.loaderColor
                          : Colors.white,
                      child: const Text(
                        "Squad",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                ScoreboardScreen(scoreModel: widget.scoreModel),
                SquadScreen(scoreModel: widget.scoreModel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
