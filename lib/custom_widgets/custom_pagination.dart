import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matloob_admin/utils/app_strings.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomPagination extends StatelessWidget {
  final int currentPage;
  final List<int> visiblePages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Function(int) onPageSelected;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.visiblePages,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPrevious,
          child: Container(
            height: 36,
            width: 77,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: kGreyLightColor,width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back_ios, size: 12,color: kBlackShade11Color,),
                SizedBox(width: 4,),
                Text(kBack, style: AppStyles.blackTextStyle().copyWith(fontSize: 12)),
              ],
            ),
          ),
        ),

        const SizedBox(width: 6),

        ...visiblePages.map((page) {
          final isSelected = currentPage == page;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => onPageSelected(page),
              child: Container(
                height: 36,
                width: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isSelected ? kPrimaryColor : kWhiteColor,
                  border: Border.all(
                    color: isSelected ? kPrimaryColor : kGreyLightColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    page.toString(),
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? kWhiteColor : kBlackColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),

        const SizedBox(width: 18),

        GestureDetector(
          onTap: onNext,
          child: Container(
            height: 36,
            width: 77,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: kGreyLightColor,width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(kNext, style: AppStyles.blackTextStyle().copyWith(fontSize: 12)),
                SizedBox(width: 4,),
                Icon(Icons.arrow_forward_ios_outlined, size: 12,color: kBlackShade11Color,),
              ],
            ),
          ),
        ),


      ],
    );
  }
}
