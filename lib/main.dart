import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final InfiniteScrollController _infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: InfiniteAnimation(
            durationInSeconds: 10, // this is the default value
            child: Container(
              height: 200,
              width: 200,
              color: Colors.grey,
            )),
      ),
    ));
  }
}

class InfiniteAnimation extends StatefulWidget {
  final Widget child;
  final int durationInSeconds;

  InfiniteAnimation({
    required this.child,
    this.durationInSeconds = 2,
  });

  @override
  _InfiniteAnimationState createState() => _InfiniteAnimationState();
}

class _InfiniteAnimationState extends State<InfiniteAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    );
    animation = Tween<double>(
      begin: 0,
      end: 12.5664, // 2Radians (360 degrees)
    ).animate(animationController);
    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => GestureDetector(
        onTap: () {
          if (!animationController.isAnimating) {
            print('stopped');
            animationController.forward();
          } else {
            animationController.stop();
          }
        },
        child: Transform.rotate(
          angle: animation.value,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();

    super.dispose();
  }
}
