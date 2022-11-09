import 'package:flutter/material.dart';

class ChangePageViewAuto extends StatefulWidget {
  @override
  _ChangePageViewAutoState createState() => _ChangePageViewAutoState();
}

class _ChangePageViewAutoState extends State<ChangePageViewAuto>
    with SingleTickerProviderStateMixin {
  //declare the variables
  late AnimationController _animationController;
  late Animation<double> _nextPage;
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    //Start at the controller and set the time to switch pages
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    //Add listener to AnimationController for know when end the count and change to the next page
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset(); //Reset the controller
        final int page = 4; //Number of pages in your PageView
        if (_currentPage < page) {
          _currentPage++;
          _pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
        } else {
          _currentPage = 0;
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _animationController.forward(); //Start controller with widget
    print(_nextPage.value);
    return Scaffold(
      body: PageView.builder(
          // itemCount: 4,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: (value) {
            //When page change, start the controller
            _animationController.forward();
          },
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Text('${index % 4}'),
            );
          }),
    );
  }
}
