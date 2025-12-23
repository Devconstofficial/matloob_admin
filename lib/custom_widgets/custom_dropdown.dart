import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../models/rfq_categories_model.dart';
import '../models/rfq_sub_categories_model.dart';
import '../models/rfq_sub_sub_categories_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomDropdown extends StatelessWidget {
  final RxString selected;
  final List<String> items;
  final String hint;
  final double height;

  const CustomDropdown({super.key, required this.selected, required this.items, required this.hint, this.height = 48});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Obx(() {
        final value = selected.value.isEmpty ? null : selected.value;
        return DropdownButtonFormField2<String>(
          value: value,
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(maxHeight: 230, decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(8.r))),
          hint: Text(hint, style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: kBlackColor.withOpacity(0.5))),
          style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: kBlackColor.withOpacity(0.5)),

          decoration: InputDecoration(
            hintStyle: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: kBlackColor.withOpacity(0.5)),
            filled: true,

            fillColor: kBlackShade1Color.withOpacity(0.01),
            contentPadding: EdgeInsets.only(right: 6.w, top: 15.h, bottom: 15.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
          ),
          items:
              items.map((e) => DropdownMenuItem<String>(value: e, child: Text(e, style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400, fontSize: 14)))).toList(),
          onChanged: (v) => selected.value = v ?? '',
        );
      }),
    );
  }
}

class CustomDropdownWithModel<T> extends StatelessWidget {
  final Rx<T?> selected;
  final List<T> items;
  final String hint;
  final double height;
  final String Function(T) itemLabel;
  final Function(T?)? onChanged;

  const CustomDropdownWithModel({super.key, required this.selected, required this.items, required this.hint, required this.itemLabel, this.height = 55, this.onChanged});

  // Add this helper method to get unique items
  List<T> _getUniqueItems() {
    if (items.isEmpty) return items;

    // Check if T is RfqCategoriesModel
    if (items.first is RfqCategoriesModel) {
      final seen = <String>{};
      return items.where((item) {
        final model = item as RfqCategoriesModel;
        if (seen.contains(model.id)) {
          return false;
        }
        seen.add(model.id!);
        return true;
      }).toList();
    }
    // Check if T is RfqSubCategoriesModel
    else if (items.first is RfqSubCategoriesModel) {
      final seen = <String>{};
      return items.where((item) {
        final model = item as RfqSubCategoriesModel;
        if (seen.contains(model.id)) {
          return false;
        }
        seen.add(model.id!);
        return true;
      }).toList();
    }
    // Check if T is RfqSubSubCategoriesModel
    else if (items.first is RfqSubSubCategoriesModel) {
      final seen = <String>{};
      return items.where((item) {
        final model = item as RfqSubSubCategoriesModel;
        if (seen.contains(model.id)) {
          return false;
        }
        seen.add(model.id!);
        return true;
      }).toList();
    }

    // For other types, remove exact duplicates
    return items.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Obx(() {
        // Get unique items
        final uniqueItems = _getUniqueItems();

        // Handle empty items list
        if (uniqueItems.isEmpty) {
          return Container(
            height: height.h,
            decoration: BoxDecoration(
              color: kBlackShade1Color.withOpacity(0.01),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: kBlackShade1Color.withOpacity(0.10)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            alignment: Alignment.centerLeft,
            child: Text(hint, style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp, color: kBlackShade1Color)),
          );
        }

        // Check if selected value exists in items and get matching item
        T? currentValue = selected.value;

        if (currentValue != null) {
          T? matchingItem = uniqueItems.firstWhereOrNull((item) {
            // Check for RfqCategoriesModel
            if (item is RfqCategoriesModel && currentValue is RfqCategoriesModel) {
              return item.id == currentValue.id;
            }
            // Check for RfqSubCategoriesModel
            else if (item is RfqSubCategoriesModel && currentValue is RfqSubCategoriesModel) {
              return item.id == currentValue.id;
            }
            // Check for RfqSubSubCategoriesModel
            else if (item is RfqSubSubCategoriesModel && currentValue is RfqSubSubCategoriesModel) {
              return item.id == currentValue.id;
            }
            // For other types, use equality
            else {
              return item == currentValue;
            }
          });

          // Use the matching item from uniqueItems to ensure same reference
          currentValue = matchingItem;
        }

        return DropdownButtonFormField2<T>(
          value: currentValue,
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(maxHeight: 230, decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(8.r))),
          hint: Text(hint, style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp, color: kBlackShade1Color)),
          style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: kBlackShade1Color),
          decoration: InputDecoration(
            hintStyle: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: kBlackShade1Color),
            filled: true,
            fillColor: kBlackShade1Color.withOpacity(0.01),
            contentPadding: EdgeInsets.only(right: 6.w, top: 15.h, bottom: 15.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10))),
          ),
          items:
              uniqueItems
                  .map(
                    (item) => DropdownMenuItem<T>(value: item, child: Text(itemLabel(item), style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500, fontSize: 14))),
                  )
                  .toList(),
          onChanged: (v) {
            selected.value = v;
            if (onChanged != null) {
              onChanged!(v);
            }
          },
        );
      }),
    );
  }
}
