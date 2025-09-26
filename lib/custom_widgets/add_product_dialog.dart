import 'dart:io' as io;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import '../utils/app_colors.dart';

class AddProductDialog extends StatefulWidget {
  String storeId;
  AddProductDialog({super.key, required this.storeId});
  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final StoreController controller = Get.put(StoreController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<XFile> selectedImages = [];

  Widget customTextField(
    String hintText, {
    int maxLines = 1,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: kBlackColor,
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.roboto(
          color: kBlackColor.withOpacity(0.5),
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        hintText: hintText,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kBlackColor.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kBlackColor.withOpacity(0.1)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog1(
      width: 750.w,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Details",
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 11.h),
          SizedBox(
            height: 48.h,
            child: customTextField(
              "Title of Product",
              controller: titleController,
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            kCatalogDetails,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => controller.setSelectedTab(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kMedicalProducts,
                        style: AppStyles.blackTextStyle().copyWith(
                          color:
                              controller.selectedTab.value == 0
                                  ? kPrimaryColor
                                  : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.h,
                        width: 110.w,
                        color:
                            controller.selectedTab.value == 0
                                ? kPrimaryColor
                                : kWhiteColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () => controller.setSelectedTab(1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kMedicalServices,
                        style: AppStyles.blackTextStyle().copyWith(
                          color:
                              controller.selectedTab.value == 1
                                  ? kPrimaryColor
                                  : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.h,
                        width: 110.w,
                        color:
                            controller.selectedTab.value == 1
                                ? kPrimaryColor
                                : kWhiteColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () => controller.setSelectedTab(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        kLaboratoriesEquipment,
                        style: AppStyles.blackTextStyle().copyWith(
                          color:
                              controller.selectedTab.value == 2
                                  ? kPrimaryColor
                                  : Colors.grey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 2.h,
                        width: 110.w,
                        color:
                            controller.selectedTab.value == 2
                                ? kPrimaryColor
                                : kWhiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() {
            final chipRows =
                controller.selectedTab.value == 0
                    ? controller.medicalProd
                    : controller.selectedTab.value == 1
                    ? controller.medServices
                    : controller.labEqu;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(chipRows.length, (rowIndex) {
                return Container(
                  margin: EdgeInsets.only(bottom: 13.h),
                  height: 35.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                            chipRows[rowIndex].map((label) {
                              final isSelected =
                                  controller.selectedChip.value == label;
                              return Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: ChoiceChip(
                                  label: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: AppStyles.whiteTextStyle().copyWith(
                                      color:
                                          isSelected
                                              ? kWhiteColor
                                              : kBlackShade1Color,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  labelPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  selected: isSelected,
                                  selectedColor: kPrimaryColor,
                                  backgroundColor: kGreyShade9Color,
                                  onSelected:
                                      (_) => controller.toggleChip(label),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    side: BorderSide(
                                      color:
                                          isSelected
                                              ? kPrimaryColor
                                              : kGreyShade9Color,
                                    ),
                                  ),
                                  showCheckmark: false,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(
                    kBrandName,
                    controller: brandController,
                  ),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(
                    kManufacturingCountry,
                    controller: countryController,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kContactForPrice,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Obx(
                () => FlutterSwitch(
                  width: 42.0.w,
                  height: 26.0.h,
                  toggleSize: 15.0.w,
                  value: controller.isContactForPrice.value,
                  activeColor: kPrimaryColor,
                  inactiveColor: kGreyColor2,
                  onToggle: controller.toggleContactForPrice,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
              height: 48.h,
              child: customTextField(
                 kContactForPriceHint
                   ,
                controller: priceController,
              ),
            ),

          SizedBox(height: 16.h),
          Text(
            kProductImages,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8.h),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            dashPattern: [12, 8],
            color: kPrimaryColor,
            strokeWidth: 0.8,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final List<XFile> images = await picker.pickMultiImage();
                  if (images.isNotEmpty) {
                    setState(() {
                      selectedImages.addAll(images);
                    });
                  }
                },
                child: Container(
                  height: 144,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Image.asset(kUploadImage, height: 36, width: 36),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              kDragBrowse,
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              kBrowse,
                              style: AppStyles.primaryTextStyle().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          kMaxAllowed,
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kGreyColor7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          if (selectedImages.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 16),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  final image = selectedImages[index];
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              kIsWeb
                                  ? Image.network(image.path, fit: BoxFit.cover)
                                  : Image.file(
                                    io.File(image.path),
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 4,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImages.removeAt(index);
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  size: 12,
                                  color: kBlackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          SizedBox(height: 15.h),
          Text(
            "Product Description",
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8.h),
          customTextField(
            "Product Description",
            controller: descriptionController,
            maxLines: 6,
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              CustomButton(
                title: kCancel,
                onTap: () {
                  Get.back();
                },
                height: 40.h,
                width: 131.w,
                color: kWhiteColor,
                borderRadius: 12,
                borderColor: kBlackColor,
                textSize: 14,
                fontWeight: FontWeight.w400,
                textColor: kBlackColor,
              ),
              const Spacer(),

              SizedBox(width: 20.w),
              Obx(
                ()=> controller.isAddingProduct.value? const Center(child: CircularProgressIndicator(),): CustomButton(
                  title: "Add Product",
                  onTap: () async {
                    if (titleController.text.isEmpty ||
                        brandController.text.isEmpty ||
                        countryController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        (!controller.isContactForPrice.value &&
                            priceController.text.isEmpty) ||
                        selectedImages.isEmpty) {
                      showCustomSnackbar(
                        "Missing Field",
                        "Please fill all required fields and select images.",
                      );
                      return;
                    }
                
                    double price = 0;
                    if (!controller.isContactForPrice.value) {
                      price = double.tryParse(priceController.text) ?? 0;
                    }
                
                    await controller.addProductToStore(
                      storeId: widget.storeId,
                      title: titleController.text.trim(),
                      brand: brandController.text.trim(),
                      country: countryController.text.trim(),
                      description: descriptionController.text.trim(),
                      selectedImages: selectedImages,
                      price: price,
                      isContactForPrice: controller.isContactForPrice.value,
                    );
                    titleController.clear();
                    brandController.clear();
                    countryController.clear(); 
                    descriptionController.clear();
                    priceController.clear();
                    selectedImages.clear();
                  },
                  height: 40.h,
                  width: 150.w,
                  borderRadius: 12,
                  textSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

