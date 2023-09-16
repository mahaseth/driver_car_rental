import 'package:flutter/material.dart';
import 'package:myride/constant/app_color.dart';
import 'package:myride/constant/app_screen_size.dart';
import 'package:myride/constant/app_text_style.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTileOwner extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String suntitle;
  const MyTimelineTileOwner({super.key, required this.isFirst, required this.isLast, required this.isPast, required this.title, required this.suntitle});    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSceenSize.getHeight(context)*0.15,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(color: Appcolors.appgreen),
        indicatorStyle: IndicatorStyle(width: 30, color: Appcolors.appgreen, iconStyle: IconStyle(iconData: Icons.done, color: Colors.white)),
        endChild: ListTile(
          title: Text(title, style: AppTextStyle.timelineheadingtext,),
          subtitle: Text(suntitle, style: AppTextStyle.timelinesubheading,),
        ),
        
      ),
    );
  }
}