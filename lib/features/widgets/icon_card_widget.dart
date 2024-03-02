import 'package:flutter/material.dart';
import 'package:helmetdetection/features/color/parse_color.dart';

class IconTextCard extends StatelessWidget {
  final String title;
  final Color? color;
  final IconData iconData;
  final VoidCallback? onTap;
  const IconTextCard(
      {super.key,
      required this.title,
      this.color,
      this.onTap,
    required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        width: 170,

        child: Card(

          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: ParseColor.parseColor("#f1ebf5"),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconData,size: 70,color: Colors.blue,),
                Text(title,style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      )
    );
  }
}
