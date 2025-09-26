import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dropdown.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'package:matloob_admin/utils/image_picker_services.dart';
import '../utils/app_colors.dart';
import 'dart:html' as html;

class AddStoreDialog extends StatefulWidget {
  const AddStoreDialog({super.key});

  @override
  State<AddStoreDialog> createState() => _AddStoreDialogState();
}

class _AddStoreDialogState extends State<AddStoreDialog> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyContactController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  RxString speciality = ''.obs;
  RxString userId = ''.obs;
  Rx<Uint8List?> selectedLogoBytes = Rx<Uint8List?>(null);
  RxString logoUrl = ''.obs;

  StoreController storeController = Get.put(StoreController());

  Widget customTextField(
    TextEditingController controller,
    String hintText, {
    int maxLines = 1,
    IconData? prefixIcon,
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
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: kBlackColor) : null,
        hintStyle: GoogleFonts.roboto(
          color: kBlackColor.withOpacity(0.5),
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
      width: 770.w,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kUserDetails,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 13.h),
          Obx(() {
  final value = userId.value.isEmpty ? null : userId.value;
  return DropdownButtonFormField2<String>(
    value: value,
    isExpanded: true,
    dropdownStyleData: DropdownStyleData(
      maxHeight: 230,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
    hint: Text(
      "Select User",
      style: AppStyles.blackTextStyle()
          .copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: kBlackColor.withOpacity(0.5)),
    ),
    style: AppStyles.blackTextStyle()
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: kBlackColor.withOpacity(0.5)),
    decoration: InputDecoration(
      filled: true,
      fillColor: kBlackShade1Color.withOpacity(0.01),
      contentPadding: EdgeInsets.only(right: 6.w, top: 15.h, bottom: 15.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: kBlackShade1Color.withOpacity(0.10)),
      ),
    ),
    items: storeController.usersBasicList.map((user) {
      return DropdownMenuItem<String>(
        value: user['id'],
        child: Text(
          "Id: ${user['id']}, Name: ${user['name']}",
          style: AppStyles.blackTextStyle()
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
        ),
      );
    }).toList(),
    onChanged: (val) {
      if (val != null) userId.value = val; 
    },
  );
}),
          SizedBox(height: 30.h),
          Text(
            kStoreDetails,
            style: AppStyles.blackTextStyle().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 13.h),

          Obx(() => Stack(
          children: [
            GestureDetector(
              onTap: () async {
                final input = html.FileUploadInputElement()..accept = 'image/*';
                input.click();
                input.onChange.listen((e) async {
                  final file = input.files?.first;
                  if (file != null) {
                    final reader = html.FileReader();
                    reader.readAsArrayBuffer(file);
                    reader.onLoadEnd.listen((e) {
                      selectedLogoBytes.value = reader.result as Uint8List?;
                    });
                  }
                });
              },
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: selectedLogoBytes.value == null
                      ? Border.all(
                          color: kGreyColor1,
                          width: 2,
                          style: BorderStyle.solid, 
                        )
                      : null,
                  color: kBlackColor.withOpacity(0.05),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: selectedLogoBytes.value == null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 40.sp,
                                color: kGreyColor1,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Add Logo",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kBlackColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image.memory(
                          selectedLogoBytes.value!,
                          fit: BoxFit.cover,
                          width: 150.w,
                          height: 150.h,
                        ),
                ),
              ),
            ),
            if (selectedLogoBytes.value != null)
              Positioned(
                top: 6.h,
                right: 6.w,
                child: GestureDetector(
                  onTap: () {
                    selectedLogoBytes.value = null;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                  ),
                ),
              ),
          ],
        )),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(companyNameController, kCompanyName),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(companyContactController, kCompanyNumber),
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: customTextField(locationController, kLocation),
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: CustomDropdown(
                    selected: speciality,
                    items: ["Services", "Product", "Both"],
                    hint: kSpecialty,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

              Obx(
                () =>
                    storeController.isAdding.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                          title: "Add Store",
                          onTap: () async {
                            if (userId.value.isEmpty ||
                                selectedLogoBytes.value == null ||
                                companyNameController.text.isEmpty ||
                                locationController.text.isEmpty ||
                                speciality.value.isEmpty) {
                              showCustomSnackbar(
                                "Error",
                                "Please fill all fields and select a logo",
                              );
                              return;
                            }

                            storeController.isAdding.value = true;

                            try {
                              final extension = "png";
                              final uploadedUrl = await ImagePickerService()
                                  .uploadImageToFirebase(
                                    selectedLogoBytes.value!,
                                    extension,
                                  );

                              if (uploadedUrl.isEmpty) {
                                showCustomSnackbar(
                                  "Error",
                                  "Failed to upload logo",
                                );
                                storeController.isAdding.value = false;
                                return;
                              }
                              await storeController.createStore(
                                userId: userId.value,
                                logo: uploadedUrl,
                                companyName: companyNameController.text,
                                companyNumber: companyContactController.text,
                                location: locationController.text,
                                speciality: speciality.value,
                                storeStatus: 'Accepted',
                              );
                            } catch (e) {
                              log("Error creating store: $e");
                              showCustomSnackbar(
                                "Error",
                                "Failed to create store",
                              );
                            } finally {
                              storeController.isAdding.value = false;
                            }
                          },
                          height: 40.h,
                          width: 140.w,
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
