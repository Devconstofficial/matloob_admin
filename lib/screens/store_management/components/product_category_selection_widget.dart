import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';

import '../../../utils/app_colors.dart';

class ProductCategorySelector extends StatelessWidget {
  final StoreController controller;
  const ProductCategorySelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- TOP CATEGORY HORIZONTAL LIST ----
          SizedBox(
            height: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- Tabs Row ----
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.categoriesList.length, (index) {
                        final item = controller.categoriesList[index];
                        final isSelected = controller.selectedCategory.value == item.arName;

                        return GestureDetector(
                          onTap: () => controller.selectTop(item),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // TEXT
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isSelected ? kPrimaryColor : Colors.transparent,
                                        width: 2.0,
                                        style: BorderStyle.solid, // Customize the style of the bottom border
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    item.arName ?? '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                      color: isSelected ? kPrimaryColor : Colors.grey.shade500,
                                    ),
                                  ),
                                ),

                                // BLUE UNDERLINE
                                // Container(height: 3, width: 35, color: isSelected ? kPrimaryColor : Colors.transparent),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                // ---- Full Grey Line Under Tabs ----
                Container(height: 1, width: double.infinity, color: Colors.grey.shade300),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ---- SUBCATEGORY HORIZONTAL LIST ----
          Obx(() {
            final items = controller.subcategoriesList;

            if (items.isEmpty) return const SizedBox.shrink();

            return SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final sub = items[index];
                  // final selected = controller.selectedCategory.value == sub.arName;

                  return Obx(
                    () => ChoiceChip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(5),
                      showCheckmark: false,
                      label: Text(sub.arName ?? ''),
                      selected: controller.selectedSubCategory.value == sub.arName,
                      selectedColor: kPrimaryColor,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(color: controller.selectedSubCategory.value == sub.arName ? kWhiteColor : kBlackColor),
                      onSelected: (_) => controller.selectSub(sub),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
