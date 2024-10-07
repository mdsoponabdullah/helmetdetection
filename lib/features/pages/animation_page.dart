import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});

  @override
  State<MyAnimation> createState() => _AnimationState();
}

class _AnimationState extends State<MyAnimation> with SingleTickerProviderStateMixin {

  late Animation animation;
  late AnimationController animationController;
  late Animation colorAnimation;
  late Animation colorAnimation2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween(begin: 0.0,end: 300.0).animate(animationController);
    colorAnimation = ColorTween(begin: Colors.blue,end: Colors.green).animate(animationController);
    colorAnimation2 = ColorTween(begin: Colors.yellowAccent,end: Colors.red).animate(animationController);

    animationController.addListener(() {

      setState(() {

      });

      print(animation.value);
    });

    animationController.forward();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 10,
        title: Text("tween Animation",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Container(
          width: animation.value*1.3,
          height: animation.value,
          color: colorAnimation.value,
          child: Center(
            child: Container(
              width: animation.value/2,
              height: animation.value/2,

              decoration:BoxDecoration(
                color: colorAnimation2.value,
                borderRadius:BorderRadius.circular(100.0),
              ) ,

            ),
          ),
        ),
      )
    );
  }
}
