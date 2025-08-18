import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_images.dart';
import '../utils/app_styles.dart';

 Widget customHeader(String title){
  return Padding(
    padding: EdgeInsets.only(bottom: 29.h),
    child: Row(
      children: [
        Text(
          title,
          style: AppStyles.blackTextStyle()
              .copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        SizedBox(width: 21.w),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              kPersonImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}