import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_images.dart';
import '../utils/app_styles.dart';

class ColumnRowWidget extends StatelessWidget {
  String title;
  ColumnRowWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
          AppStyles.blackTextStyle()
              .copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        SvgPicture.asset(kUpDownArrowsIcon,height: 13,width: 9,)
      ],
    );
  }
}
