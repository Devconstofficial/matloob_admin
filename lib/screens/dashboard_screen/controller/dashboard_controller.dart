import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/custom_widgets/view_details_dialog.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/models/user_model.dart';
import 'package:matloob_admin/screens/rfqs/controller/rfq_controller.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/image_picker_services.dart';
import 'package:matloob_admin/web_services/rfq_services.dart';
import 'package:matloob_admin/web_services/store_services.dart';
import 'package:matloob_admin/web_services/user_services.dart';

import '../../../models/rfq_categories_model.dart';
import '../../../models/rfq_sub_categories_model.dart';
import '../../../models/rfq_sub_sub_categories_model.dart';
import '../../../web_services/medical_products_services.dart';

class DashboardController extends GetxController {
  final RxList<Store> storeRequests = <Store>[].obs;
  final RxList<RfqModel> rfqs = <RfqModel>[].obs;
  final RxList<UserModel> users = <UserModel>[].obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  var isLoading3 = false.obs;

  var selectedCountry = ''.obs;
  var specialityController = ''.obs;

  final UserServices userServices = UserServices();
  final StoreServices storeServices = StoreServices();
  final RfqServices rfqServices = RfqServices();
  RxInt totalUsers = 0.obs;
  RxInt totalStores = 0.obs;
  RxInt totalPendingStores = 0.obs;
  RxInt totalActiveStores = 0.obs;
  RxInt totalRfqs = 0.obs;
  RxInt totalPendingRfqs = 0.obs;

  final MedicalProductsServices productServices = MedicalProductsServices();
  final RxString rfqSelectedCategory = "".obs;
  final RxString rfqSelectedCategoryId = "".obs;

  final RxString rfqSelectedSubCategory = "".obs;
  final RxString rfqSelectedSubCategoryId = "".obs;
  final RxString rfqSelectedSubSubCategory = "".obs;
  final RxString rfqSelectedSubSubCategoryId = "".obs;

  RxList<RfqCategoriesModel> rfqCategoriesList = RxList();
  Rx<RfqCategoriesModel?> rfqSelectedCategoriesObj = Rx(RfqCategoriesModel());
  RxList<RfqSubCategoriesModel> rfqSubcategoriesList = RxList();
  Rx<RfqSubCategoriesModel?> rfqSelectedSubCategoriesObj = Rx(RfqSubCategoriesModel());
  RxList<RfqSubSubCategoriesModel> rfqSubSubcategoriesModelList = RxList();
  Rx<RfqSubSubCategoriesModel?> rfqSelectedSubSubCategoriesObj = Rx(RfqSubSubCategoriesModel());
  RxList<String> subSubcategoriesList = RxList();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    getRfqCategories();
  }

  Future<void> fetchDashboardData() async {
    await Future.wait([fetchUsers(), fetchStores(), fetchRFQs()]);
  }

  Future<void> fetchUsers() async {
    try {
      final fetchedUsers = await userServices.getAllUsers();

      final nonAdminUsers = fetchedUsers.where((u) => u.roles.toLowerCase() != "admin").toList();

      users.assignAll(nonAdminUsers);
      totalUsers.value = users.length;
    } catch (e) {
      log("Error fetching users: $e");
    }
  }

  Future<void> fetchStores() async {
    try {
      final response = await storeServices.getStores();
      final allStores = List<Store>.from(response["stores"]);
      storeRequests.clear();
      totalStores.value = allStores.length;
      totalPendingStores.value = allStores.where((s) => s.storeStatus == StoreStatus.Pending).length;
      totalActiveStores.value = allStores.where((s) => s.storeStatus == StoreStatus.Accepted).length;
      storeRequests.assignAll(allStores.where((s) => s.storeStatus == StoreStatus.Pending).toList());
    } catch (e) {
      log("Error fetching stores: $e");
    }
  }

  Future<void> fetchRFQs() async {
    try {
      final response = await rfqServices.getRFQs();
      final allRfqs = List<RfqModel>.from(response["items"]);

      totalRfqs.value = allRfqs.length;
      totalPendingRfqs.value = allRfqs.where((r) => r.status == RfqStatus.Pending).length;

      rfqs.assignAll(allRfqs.where((r) => r.status == RfqStatus.Pending).toList());

      log("Total RFQs: ${totalRfqs.value}, Pending RFQs: ${totalPendingRfqs.value}");
    } catch (e) {
      log("Error fetching rfqs: $e");
    }
  }

  Future<void> updateStoreStatusAction({required String storeId, required String newStatus}) async {
    try {
      isLoading1(true);
      final updatedStore = await storeServices.updateStoreStatus(storeId, newStatus);
      int index = storeRequests.indexWhere((s) => s.id == updatedStore.id);
      if (index != -1) {
        storeRequests[index] = updatedStore;
      }
      await fetchStores();
      StoreController control = Get.put(StoreController());
      await control.fetchStores();
      Get.back();
    } catch (e) {
      log("Error updating store status: $e");
      showCustomSnackbar("Error", "Failed to update store status");
    } finally {
      isLoading1(false);
    }
  }

  Future<void> updateStoreDetails({required String storeId, required Map<String, dynamic> updateData}) async {
    try {
      isLoading2(true);
      final updatedStore = await storeServices.updateStore(storeId, updateData);

      await fetchStores();
      StoreController control = Get.put(StoreController());
      await control.fetchStores();
      Get.back();
      showCustomSnackbar("Success", "Store details updated successfully", backgroundColor: kGreenColor);
    } catch (e) {
      log("Error updating store details: $e");
      showCustomSnackbar("Error", "Failed to update store details");
    } finally {
      isLoading2(false);
    }
  }

  Future<void> rejectStore({required String storeId, String reason = ""}) async {
    try {
      isLoading3(true);
      await storeServices.updateStoreStatus(storeId, "Rejected");

      await fetchStores();
      StoreController control = Get.put(StoreController());
      await control.fetchStores();
      Get.back();
    } catch (e) {
      log("Error rejecting store: $e");
      showCustomSnackbar("Error", "Failed to reject store");
    } finally {
      isLoading3(false);
    }
  }

  var isUpdatingRFQ = false.obs;
  var isLoadingRFQStatus = false.obs;

  final ImagePickerService imagePickerService = ImagePickerService();

  Future<void> updateRFQFromUI({
    required RfqModel rfq,
    required RxList<FileItem> imageList,
    required RxList<FileItem> fileList,
    required String title,
    required String description,
    required double price,
    required String condition,
    required String status,
    required bool isWantDelivery,
  }) async {
    try {
      isUpdatingRFQ(true);
      List<String> updatedImageUrls = [];

      for (var img in imageList) {
        if (!img.isNetwork && img.fileBytes != null) {
          String extension = img.path.split('.').last;
          String url = await imagePickerService.uploadRfqImagesToFirebase(img.fileBytes!, extension);
          updatedImageUrls.add(url);
        } else {
          updatedImageUrls.add(img.path);
        }
      }

      List<String> updatedFileUrls = [];
      for (var file in fileList) {
        if (!file.isNetwork && file.fileBytes != null) {
          String url = await imagePickerService.uploadRfqFileToFirebase(file.fileBytes!, file.displayName);
          updatedFileUrls.add(url);
        } else {
          updatedFileUrls.add(file.path);
        }
      }

      Map<String, dynamic> updateData = {
        "title": title,
        "description": description,
        "price": price,
        "condition": condition,
        "isWantDelivery": isWantDelivery,
        "status": status,
        "images": updatedImageUrls,
        "files": updatedFileUrls,
      };

      RfqModel updatedRfq = await rfqServices.updateRFQ(rfq.rfqId, updateData);
      await updateRFQStatusAction(rfqId: rfq.rfqId, status: status);

      await fetchRFQs();
      RfqController control = Get.put(RfqController());
      await control.fetchRFQs();
      // Get.back();
      showCustomSnackbar("Success", "RFQ updated successfully", backgroundColor: kGreenColor);
    } catch (e) {
      log("Error updating RFQ: $e");
      showCustomSnackbar("Error", "Failed to update RFQ");
    } finally {
      isUpdatingRFQ(false);
    }
  }

  Future<void> updateRFQStatusAction({required String rfqId, required String status}) async {
    try {
      isLoadingRFQStatus(true);
      RfqModel updatedRfq = await rfqServices.updateRFQStatus(rfqId, status);

      await fetchRFQs();
      RfqController control = Get.put(RfqController());
      await control.fetchRFQs();

      Get.back();
    } catch (e) {
      log("Error updating RFQ status: $e");
      showCustomSnackbar("Error", "Failed to update RFQ status");
    } finally {
      isLoadingRFQStatus(false);
    }
  }

  Future getRfqCategories() async {
    try {
      var result = await productServices.getProductCategories();

      if (result is List<RfqCategoriesModel> && result.isNotEmpty) {
        rfqCategoriesList.assignAll(result);
        rfqCategoriesList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else {}
    } catch (e) {
      print("getRfqCategories Exception $e");
      showCustomSnackbar("Error", "Something went wrong, please try again");
      return false;
    }
  }

  Future getRfqSubCategories({required String categoryId, bool isFromDropDown = false, RfqCategoriesModel? previousCategory, bool isEdit = false}) async {
    try {
      rfqSubcategoriesList.clear();
      rfqSubSubcategoriesModelList.clear();

      var result = await productServices.getProductSubCategories(categoryId: categoryId);

      if (result is List<RfqSubCategoriesModel> && result.isNotEmpty) {
        rfqSubcategoriesList.assignAll(result);
        rfqSubcategoriesList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

        if (isEdit) {
          String categoryName = (Get.locale?.languageCode == 'ar' ? rfqSelectedSubCategoriesObj.value?.arName : rfqSelectedSubCategoriesObj.value?.enName) ?? "";
          rfqSelectedSubCategory.value = categoryName;
          rfqSelectedSubCategoryId.value = rfqSelectedSubCategoriesObj.value?.id ?? "";
          return true;
        } else {
          rfqSelectedSubCategoriesObj.value = null;
          // selectedSubCategoriesObj.value = subcategoriesList[0];
          String categoryName = (Get.locale?.languageCode == 'ar' ? rfqSelectedSubCategoriesObj.value?.arName : rfqSelectedSubCategoriesObj.value?.enName) ?? "";
          rfqSelectedSubCategory.value = categoryName;
          rfqSelectedSubCategoryId.value = rfqSelectedSubCategoriesObj.value?.id ?? "";
          return true;
        }
      } else if (result is String && result.toLowerCase() == "coming soon") {
        // Revert to previous category selection
        if (previousCategory != null) {
          rfqSelectedCategoriesObj.value = previousCategory;
          String categoryName = (Get.locale?.languageCode == 'ar' ? previousCategory.arName : previousCategory.enName) ?? "";
          rfqSelectedCategory.value = categoryName;
          rfqSelectedCategoryId.value = previousCategory.id ?? '';
        }

        rfqSelectedSubCategoryId.value = '';
        rfqSelectedSubSubCategoryId.value = '';
        showCustomSnackbar("Coming Soon", "We're working hard to bring you something amazing.Stay tuned for the launch!", backgroundColor: Colors.orange);
      } else {}
      return false;
    } catch (e) {
      print("getRfqSubCategories Exception $e");
      showCustomSnackbar("Error", "Something went wrong, please try again");
      return false;
    }
  }

  Future getRfqSubSubCategories({required String categoryId, required String subCategoryId, bool isFromDropDown = false, bool isEdit = false}) async {
    try {
      rfqSubSubcategoriesModelList.clear();

      var result = await productServices.getRfqsSubSubCategories(categoryId: categoryId, subCategoryId: subCategoryId);

      if (result is List<RfqSubSubCategoriesModel> && result.isNotEmpty) {
        rfqSubSubcategoriesModelList.assignAll(result);
        rfqSubSubcategoriesModelList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

        if (isEdit) {
          String categoryName = (Get.locale?.languageCode == 'ar' ? rfqSelectedSubSubCategoriesObj.value?.arName : rfqSelectedSubSubCategoriesObj.value?.enName) ?? "";
          rfqSelectedSubSubCategory.value = categoryName;
          rfqSelectedSubSubCategoryId.value = rfqSelectedSubSubCategoriesObj.value?.id ?? "";
          return true;
        } else {
          rfqSelectedSubSubCategoriesObj.value = null;
          String categoryName = (Get.locale?.languageCode == 'ar' ? rfqSelectedSubSubCategoriesObj.value?.arName : rfqSelectedSubSubCategoriesObj.value?.enName) ?? "";
          rfqSelectedSubSubCategory.value = categoryName;
          rfqSelectedSubSubCategoryId.value = rfqSelectedSubSubCategoriesObj.value?.id ?? "";
          return true;
        }
      } else if (result is String && result.toLowerCase() == "coming soon") {
        rfqSelectedSubSubCategoryId.value = '';
        showCustomSnackbar("Coming Soon", "We're working hard to bring you something amazing.Stay tuned for the launch!", backgroundColor: Colors.orange);
      } else {}

      return false;
    } catch (e) {
      print("getRfqSubSubCategories Exception $e");
      showCustomSnackbar("Error", "Something went wrong, please try again");
      return false;
    }
  }
}
