import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import 'package:matloob_admin/custom_widgets/customDialog1.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/custom_widgets/custom_dialog.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/screens/auth/controller/auth_controller.dart';
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:matloob_admin/utils/app_images.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_styles.dart';
import 'custom_dropdown.dart';
import '../utils/app_colors.dart';

class FileItem {
  final String path;
  final String displayName;
  final bool isNetwork;
  final Uint8List? fileBytes;
  FileItem({
    required this.path,
    required this.displayName,
    this.isNetwork = true,
    this.fileBytes,
  });
}

class ViewDetailModel extends StatefulWidget {
  final RfqModel rfq;
  final bool isEditable;
  const ViewDetailModel({required this.rfq, this.isEditable=true, super.key});

  @override
  State<ViewDetailModel> createState() => _ViewDetailModelState();
}

class _ViewDetailModelState extends State<ViewDetailModel> {
  late TextEditingController locationController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  late RxString selectedDelivery;
  late RxString selectedCondition;
  late RxString selectedStatus;
  late RxList<FileItem> imageList;
  late RxList<FileItem> fileList;

  DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController(
      text: "${widget.rfq.city ?? ''}, ${widget.rfq.district ?? ''}",
    );
    titleController = TextEditingController(text: widget.rfq.title);
    descriptionController = TextEditingController(text: widget.rfq.description);
    priceController = TextEditingController(
      text: widget.rfq.price > 0 ? widget.rfq.price.toStringAsFixed(0) : "",
    );
    selectedDelivery = (widget.rfq.isWantDelivery ? "Yes" : "No").obs;
    selectedCondition = widget.rfq.condition.obs;
    selectedStatus = widget.rfq.status.name.obs;

    imageList = RxList.from(
      widget.rfq.images.map(
        (path) => FileItem(
          path: path,
          displayName: path.split('/').last,
          isNetwork: true,
        ),
      ),
    );
    fileList = RxList.from(
      widget.rfq.files.map(
        (path) => FileItem(
          path: path,
          displayName: path.split('/').last,
          isNetwork: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Widget _customTextField({
    required TextEditingController controller,
    String hintText = "",
    int maxLines = 1,
    bool readOnly = false,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
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
        contentPadding: contentPadding.copyWith(
          top: maxLines > 1 ? 20.h : 0,
          bottom: maxLines > 1 ? 20.h : 0,
        ),
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

  Widget _priceTextField() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBlackColor.withOpacity(0.1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              readOnly: false,
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: kBlackColor,
              ),
              decoration: InputDecoration(
                hintText: "0",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 15.h),
              ),
            ),
          ),
          Text(
            "SAR",
            style: GoogleFonts.roboto(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: kBlackColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFileDisplay(RxList<FileItem> items, {required bool isImage}) {
    final String fileIconAsset = kFile;

    Future<void> pickFile() async {
      FilePickerResult? result;

      if (isImage) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: true,
          withData: true,
        );
      } else {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
          allowMultiple: true,
          withData: true,
        );
      }

      if (result != null && result.files.isNotEmpty) {
        for (PlatformFile file in result.files) {
          if (file.bytes != null) {
            items.add(
              FileItem(
                path: file.name,
                displayName: file.name,
                isNetwork: false,
                fileBytes: file.bytes,
              ),
            );
          }
        }
      }
    }

    return Obx(
      () => Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          ...items.map(
            (item) => Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: isImage ? 80.h : 40.h,
                  width: isImage ? 80.w : 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kBlackColor.withOpacity(0.1)),
                    color: isImage ? kWhiteColor : kCreamColor3,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        isImage
                            ? item.isNetwork
                                ? Image.network(item.path, fit: BoxFit.cover)
                                : Image.memory(
                                  item.fileBytes!,
                                  fit: BoxFit.cover,
                                )
                            : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                children: [
                                  Image.asset(
                                    fileIconAsset,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Text(
                                      item.displayName,
                                      style: AppStyles.blackTextStyle()
                                          .copyWith(fontSize: 10.sp),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: GestureDetector(
                    onTap: () => items.remove(item),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kRedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: kWhiteColor, width: 2),
                      ),
                      child: Icon(Icons.close, color: kWhiteColor, size: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: pickFile,
            child: Container(
              height: isImage ? 80.h : 40.h,
              width: isImage ? 80.w : 150.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kBlackColor.withOpacity(0.1)),
                color: kWhiteColor,
              ),
              child: Center(
                child: Icon(
                  isImage ? Icons.add_a_photo : Icons.add,
                  color: kBlackColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = widget.rfq.user?.name ?? "User Not Found";
    final String? profileImageUrl = widget.rfq.user?.profileImage;
    final bool hasProfileImage =
        profileImageUrl != null && profileImageUrl.isNotEmpty;

    return CustomDialog1(
      width: 750.w,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                kRFQInformation,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 11.h),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:
                        hasProfileImage
                            ? Image.network(
                              profileImageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  kPersonImage,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                            : Image.asset(kPersonImage, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  userName,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Text(
              "Category: ${widget.rfq.category} | ${widget.rfq.subcategory} | ${widget.rfq.subSubcategory}",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: kBlackColor.withOpacity(0.6),
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Delivery",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            CustomDropdown(
              selected: selectedDelivery,
              items: const ["Yes", "No"],
              hint: "Delivery Required",
            ),

            SizedBox(height: 16.h),
            Text(
              kLocation,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            _customTextField(
              controller: locationController,
              hintText: "City, District",
              readOnly: true,
            ),

            SizedBox(height: 16.h),
            Text(
              kCondition,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            CustomDropdown(
              selected: selectedCondition,
              items: const ["New", "Used", "Refurbished"],
              hint: "Select Condition",
            ),

            SizedBox(height: 16.h),
            Text(
              "Status",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            CustomDropdown(
              selected: selectedStatus,
              items: const [
                "Pending",
                "Accepted",
                "Rejected",
                "Completed",
                "Cancelled",
              ],
              hint: "Select Status",
            ),

            SizedBox(height: 16.h),
            Text(
              kTargetedPrice,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            _priceTextField(),

            SizedBox(height: 16.h),
            Text(
              kTitle,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            _customTextField(
              controller: titleController,
              hintText: "Enter RFQ Title",
              readOnly: false,
            ),

            SizedBox(height: 16.h),
            Text(
              "Description",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            _customTextField(
              controller: descriptionController,
              hintText: "Enter RFQ Description",
              maxLines: 6,
              readOnly: false,
            ),

            SizedBox(height: 32.h),
            Text(
              "Product Images",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            _imageFileDisplay(imageList, isImage: true),

            SizedBox(height: 16.h),
            Text(
              "Files",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 8.h),
            _imageFileDisplay(fileList, isImage: false),

            SizedBox(height: 32.h),
            Row(
              children: [
                if (widget.isEditable)
                  Obx(
                    () =>
                        controller.isLoadingRFQStatus.value
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                              title: kReject,
                              onTap: () {
                                final reasonController =
                                    TextEditingController();

                                Get.dialog(
                                  barrierDismissible: false,
                                  CustomDialog(
                                    image: kRejectReasonImage,
                                    title: kRejectionReason,
                                    btnText: kReject,
                                    isLoading: controller.isLoadingRFQStatus,
                                    onTap: () async {
                                      await controller.updateRFQStatusAction(
                                        rfqId: widget.rfq.rfqId,
                                        status: "Rejected",
                                      );
                                      reasonController.clear();
                                      Get.back();
                                      showCustomSnackbar(
                                        "Success",
                                        "RFQ status updated to Rejected",
                                        backgroundColor: kGreenColor,
                                      );
                                    },
                                    hideDetail: true,
                                    showRejection: true,
                                    btnColor: kRedColor,

                                    reasonController: reasonController,
                                  ),
                                );
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
                  ),
                Spacer(),
                Obx(
                  () =>
                      controller.isUpdatingRFQ.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                            title: kEdit,
                            onTap: () async {
                              double parsedPrice =
                                  double.tryParse(priceController.text) ?? 0;

                              await controller.updateRFQFromUI(
                                rfq: widget.rfq,
                                imageList: imageList,
                                fileList: fileList,
                                title: titleController.text,
                                description: descriptionController.text,
                                price: parsedPrice,
                                condition: selectedCondition.value,
                                status: selectedStatus.value,
                                isWantDelivery: selectedDelivery.value == "Yes",
                              );
                            },
                            height: 40.h,
                            width: 133.w,
                            color: kWhiteColor,
                            borderRadius: 12,
                            borderColor: kBlackColor,
                            textSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: kBlackColor,
                          ),
                ),
                SizedBox(width: 16.w),
                if (widget.isEditable)
                  Obx(
                    () =>
                        controller.isLoadingRFQStatus.value
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                              title: kApprove,
                              onTap: () {
                                Get.dialog(
                                  barrierDismissible: false,
                                  CustomDialog(
                                    image: kApproveDialogImage,
                                    title: kApproveDetail,
                                    isLoading: controller.isLoadingRFQStatus,
                                    btnText: kApprove,
                                    onTap: () async {
                                      await controller.updateRFQStatusAction(
                                        rfqId: widget.rfq.rfqId,
                                        status: "Accepted",
                                      );

                                      Get.back();
                                      showCustomSnackbar(
                                        "Success",
                                        "RFQ status updated to Accepted",
                                        backgroundColor: kGreenColor,
                                      );
                                    },
                                    hideDetail: true,
                                  ),
                                );
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
      ),
    );
  }
}
