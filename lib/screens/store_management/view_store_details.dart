import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/add_product_dialog.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/custom_widgets/custom_header.dart';
import 'package:matloob_admin/generated/locale_keys.g.dart';
import 'package:matloob_admin/models/medical_product_model.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/screens/sidemenu/sidemenu.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/utils/common_code.dart';

class ViewStoreDetails extends GetView<StoreController> {
  const ViewStoreDetails({super.key});

  Widget _customDetailField(String value, String hintText) {
    return Container(
      height: 48.h,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBlackColor.withOpacity(0.1)),
      ),
      child: Text(
        value.isEmpty ? hintText : value,
        style: GoogleFonts.roboto(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: value.isEmpty ? kBlackColor.withOpacity(0.5) : kBlackColor,
        ),
      ),
    );
  }

  Widget _buildProductCard(MedicalProducts product) {
    final imageUrl = product.images.isNotEmpty ? product.images.first : '';
    final title =
        product.title.isNotEmpty == true ? product.title : "Untitled Product";

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: kGreyShade1Color.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Positioned.fill(
              child:
                  imageUrl.isNotEmpty
                      ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Center(child: Text("Image Error")),
                      )
                      : Center(
                        child: Icon(
                          Icons.medication,
                          size: 40.sp,
                          color: kGreyColor1,
                        ),
                      ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      kBlackColor.withOpacity(0.7),
                      kBlackColor.withOpacity(0.2),
                    ],
                    stops: const [0.0, 0.6],
                  ),
                ),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.whiteTextStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Obx(
                () =>
                    controller.isDeletingProduct.value
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                          onTap: () {
                            Get.dialog(
                              barrierDismissible: false,
                              CustomDialog(
                                image: kDeleteDialogImage,
                                title: CommonCode().t(
                                  LocaleKeys.areYouSureWantToDelete,
                                ),
                                btnText: CommonCode().t(
                                  LocaleKeys.confirmDelete,
                                ),
                                isLoading: controller.isDeletingProduct,
                                onTap: () {
                                  controller.deleteProductFromStore(
                                    product.id,
                                    controller.currentStoreDetail.value!.id,
                                  );
                                },
                                btnColor: kRedColor,
                                hideDetail: true,
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: const BoxDecoration(
                              color: kRedColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.delete,
                              color: kWhiteColor,
                              size: 16.sp,
                            ),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoProductFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(kNoProductImage, width: 300.w, height: 300.h)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideMenu(), // Always visible
          Expanded(
            child: Obx(() {
              // Loader or content panel
              if (controller.isFetching.value ||
                  controller.currentStoreDetail.value == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final Store store = controller.currentStoreDetail.value!;
              final products = store.medicalProducts;
              final hasProducts = products.isNotEmpty;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customHeader(store.companyName, context),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: kGreyShade1Color),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: kLightGreyColor,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            CommonCode().t(LocaleKeys.storeManagement),
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      CircleAvatar(
                        radius: 65.r,
                        backgroundColor: kGreyShade1Color.withOpacity(0.5),
                        backgroundImage:
                            store.logo.isNotEmpty
                                ? NetworkImage(store.logo)
                                : null,
                        child:
                            store.logo.isEmpty
                                ? Icon(
                                  Icons.store,
                                  color: kWhiteColor,
                                  size: 40.sp,
                                )
                                : null,
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _customDetailField(
                                        store.companyName,
                                        CommonCode().t(LocaleKeys.companyName),
                                      ),
                                    ),
                                    SizedBox(width: 11.w),
                                    Expanded(
                                      child: _customDetailField(
                                        store.companyNumber,
                                        CommonCode().t(
                                          LocaleKeys.companyNumber,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _customDetailField(
                                        store.location,
                                        CommonCode().t(LocaleKeys.location),
                                      ),
                                    ),
                                    SizedBox(width: 11.w),
                                    Expanded(
                                      child: _customDetailField(
                                        store.speciality,
                                        CommonCode().t(LocaleKeys.speciality),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CommonCode().t(LocaleKeys.products),
                            style: AppStyles.blackTextStyle().copyWith(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          CustomButton(
                            title: CommonCode().t(LocaleKeys.addProduct),
                            onTap: () {
                              log(
                                "Navigate to Add Product for store: ${store.id}",
                              );
                              Get.dialog(
                                barrierDismissible: false,
                                AddProductDialog(storeId: store.id),
                              );
                            },
                            height: 50.h,
                            width: 120.w,
                            borderRadius: 8.r,
                            textSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      SizedBox(
                        height: 500.h,
                        child:
                            hasProducts
                                ? GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        crossAxisSpacing: 16.w,
                                        mainAxisSpacing: 16.h,
                                        childAspectRatio: 0.8,
                                      ),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    return _buildProductCard(products[index]);
                                  },
                                )
                                : _buildNoProductFound(),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
