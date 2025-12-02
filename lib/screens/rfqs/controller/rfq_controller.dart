import 'dart:developer';
import 'dart:html' as html;
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/web_services/rfq_services.dart';
import 'package:path_provider/path_provider.dart';

class RfqController extends GetxController {
  final RxList<RfqModel> rfqList = <RfqModel>[].obs;
  final RfqServices rfqServices = RfqServices();
  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var isDeleting = false.obs;
  var searchText = "".obs;
  var isExporting = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await fetchRFQs();
    searchController.addListener(() {
      searchText.value = searchController.text.trim().toLowerCase();
      currentPage.value = 1;
    });
  }

  Future<void> exportRFQsToExcel() async {
    try {
      isExporting.value = true;
      var excel = Excel.createExcel();
      Sheet sheetObject = excel[excel.getDefaultSheet() ?? 'RFQs'];
      final List<CellValue> headerValues =
          [
            "RFQ ID",
            "Submitted By",
            "Category",
            "Subcategory",
            "SubSubcategory",
            "City",
            "Location",
            "Condition",
            "Status",
            "Title",
            "Description",
            "Price",
            "Clicks",
            "Views",
            "Phone Clicks",
            "Created At",
            "Updated At",
            "Images",
            "Files",
          ].map((title) => TextCellValue(title)).toList();
      sheetObject.appendRow(headerValues);
      for (var rfq in rfqList) {
        sheetObject.appendRow([
          TextCellValue(rfq.rfqId),
          TextCellValue(rfq.user?.name ?? ""),
          TextCellValue(
            rfq.category == null
                ? ''
                : rfq.category is String
                ? rfq.category
                : Get.locale?.languageCode == 'ar'
                ? rfq.category.arName
                : rfq.category.enName,
          ),
          TextCellValue(
            rfq.subcategory == null
                ? ''
                : rfq.subcategory is String
                ? rfq.subcategory
                : Get.locale?.languageCode == 'ar'
                ? rfq.subcategory.arName
                : rfq.subcategory.enName,
          ),
          TextCellValue(
            rfq.subSubcategory == null
                ? ''
                : rfq.subSubcategory is String
                ? rfq.subSubcategory
                : Get.locale?.languageCode == 'ar'
                ? rfq.subSubcategory.arName
                : rfq.subSubcategory.enName,
          ),
          TextCellValue(rfq.city ?? ""),
          TextCellValue(rfq.location ?? ""),
          TextCellValue(rfq.condition),
          TextCellValue(rfq.status.name),
          TextCellValue(rfq.title),
          TextCellValue(rfq.description),
          TextCellValue(rfq.price.toString()),
          IntCellValue(rfq.clicks),
          IntCellValue(rfq.views),
          IntCellValue(rfq.phoneClicks),
          TextCellValue(rfq.createdAt != null ? DateFormat('yyyy-MM-dd HH:mm').format(rfq.createdAt!) : ""),
          TextCellValue(rfq.updatedAt != null ? DateFormat('yyyy-MM-dd HH:mm').format(rfq.updatedAt!) : ""),
          TextCellValue(rfq.images.join(", ")),
          TextCellValue(rfq.files.join(", ")),
        ]);
      }

      final fileBytes = excel.encode();
      if (fileBytes == null) throw Exception("Failed to encode Excel file.");
      if (kIsWeb) {
        final blob = html.Blob([fileBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor =
            html.AnchorElement(href: url)
              ..setAttribute("download", "RFQs_${DateTime.now().millisecondsSinceEpoch}.xlsx")
              ..click();
        html.Url.revokeObjectUrl(url);

        showCustomSnackbar("Success", "RFQs exported! Check your downloads folder.", backgroundColor: const Color(0xFF00C851));
        log("Excel file downloaded in browser");
      } else {
        Directory directory = await getApplicationDocumentsDirectory();
        String filePath = "${directory.path}/RFQs_${DateTime.now().millisecondsSinceEpoch}.xlsx";
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);

        showCustomSnackbar(
          "Success",
          "RFQs exported to Excel at: ${filePath.replaceAll(directory.path, 'App Documents')}",
          backgroundColor: const Color(0xFF00C851),
        );
        log("Excel file saved at: $filePath");
      }
    } catch (e) {
      showCustomSnackbar("Error", "Failed to export RFQs");
      log("Error exporting RFQs: $e");
    } finally {
      isExporting.value = false;
    }
  }

  Future<void> fetchRFQs() async {
    try {
      isLoading.value = true;
      rfqList.clear();

      final response = await rfqServices.getRFQs();
      final allRfqs = List<RfqModel>.from(response["items"]);

      rfqList.assignAll(allRfqs);
      log("RFQs fetched: ${rfqList.length}");
    } catch (e) {
      log("Error fetching rfqs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteRFQAction(String rfqId, int click) async {
    if (click > 0) {
      Get.back();
      showCustomSnackbar("Error", "Cannot delete RFQ with responses");
      return;
    }
    try {
      isDeleting.value = true;
      final successMessage = await rfqServices.deleteRFQ(rfqId);
      rfqList.removeWhere((rfq) => rfq.rfqId == rfqId);
      DashboardController dashboardController = Get.put(DashboardController());
      await dashboardController.fetchRFQs();

      Get.back();
      showCustomSnackbar("Success", "RFQ deleted successfully", backgroundColor: kGreenColor);

      log("SUCCESS: $successMessage");
    } catch (e) {
      log("Error deleting RFQ: $e");

      String errorMessage =
          e is Exception && e.toString().contains("Exception:") ? e.toString().substring("Exception: ".length) : "Failed to delete RFQ";
      showCustomSnackbar("Error", errorMessage);
      log("ERROR: $errorMessage");
    } finally {
      isDeleting.value = false;
    }
  }

  var currentPage = 1.obs;
  final int itemsPerPage = 7;
  final int pagesPerGroup = 5;

  List<RfqModel> get filteredRfqs {
    if (searchText.value.isEmpty) return rfqList;

    return rfqList.where((rfq) {
      final category =
          rfq.category == null
              ? ''
              : rfq.category is String
              ? rfq.category.toLowerCase()
              : Get.locale?.languageCode == 'ar'
              ? rfq.category.arName
              : rfq.category.enName.toLowerCase();
      final userName = rfq.user?.name?.toLowerCase() ?? "";
      return category.contains(searchText.value) || userName.contains(searchText.value);
    }).toList();
  }

  int get totalPages => (filteredRfqs.length / itemsPerPage).ceil();

  List<RfqModel> get pagedRFQs {
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filteredRfqs.sublist(start, end > filteredRfqs.length ? filteredRfqs.length : end);
  }

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    if (totalPages == 0) return [1]; // prevent invalid clamp
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }
}
