import 'dart:developer';
import 'dart:html' as html;
import 'dart:io' as io;
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/image_picker_services.dart';
import 'package:matloob_admin/web_services/medical_products_services.dart';
import 'package:matloob_admin/web_services/store_services.dart';
import 'package:matloob_admin/web_services/user_services.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/rfq_categories_model.dart';
import '../../../models/rfq_sub_categories_model.dart';
import '../../../models/rfq_sub_sub_categories_model.dart';

class StoreController extends GetxController {
  final StoreServices storeServices = StoreServices();
  final UserServices userServices = UserServices();
  TextEditingController searchController = TextEditingController();
  var searchText = "".obs;
  final RxList<Store> storeRequests = <Store>[].obs;
  var isDeleting = false.obs;
  var isDeletingProduct = false.obs;
  var isFetching = false.obs;
  var isAdding = false.obs;
  var isAddingProduct = false.obs;
  DashboardController dashboardController = Get.put(DashboardController());
  var totalPages = 1.obs;
  var currentPage = 1.obs;
  final int itemsPerPage = 10;
  final int pagesPerGroup = 5;
  var isExporting = false.obs;
  var selectedStatus = ''.obs;
  var usersBasicList = <Map<String, dynamic>>[].obs;
  var isFetchingUsers = false.obs;

  RxList<RfqCategoriesModel> categoriesList = RxList();
  RxList<RfqSubCategoriesModel> subcategoriesList = RxList();
  RxBool isListLoading = false.obs;
  RxBool isDataLoading = false.obs;
  final RxString selectedCategory = "".obs;
  final RxString selectedCategoryId = "".obs;
  final RxString selectedSubCategory = "".obs;
  final RxString selectedSubCategoryId = "".obs;

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

  Future<void> fetchUsersBasic() async {
    try {
      isFetchingUsers.value = true;
      final users = await userServices.getUsersBasic();
      usersBasicList.assignAll(users);
    } catch (e) {
      log("Error fetching basic users: $e");
      showCustomSnackbar("Error", "Failed to fetch users");
    } finally {
      isFetchingUsers.value = false;
    }
  }

  Future<void> exportStoresToExcel() async {
    try {
      isExporting.value = true;

      var excel = Excel.createExcel();
      Sheet sheet = excel[excel.getDefaultSheet() ?? 'Stores'];
      final headers = ["Store ID", "Company Name", "Company Number", "Location", "Speciality", "Status", "Clicks", "Views", "Created At", "Updated At", "User Info", "Products"];
      sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());

      for (var store in storeRequests) {
        String userInfo = store.user != null ? "Name: ${store.user!.name}, Email: ${store.user!.email}, Mobile: ${store.user!.mobile}" : "";

        String products = store.medicalProducts.isNotEmpty ? store.medicalProducts.map((p) => p.title).join(", ") : "";

        sheet.appendRow([
          TextCellValue(store.id),
          TextCellValue(store.companyName),
          TextCellValue(store.companyNumber),
          TextCellValue(store.location),
          TextCellValue(store.speciality),
          TextCellValue(store.storeStatus.toString().split('.').last),
          IntCellValue(store.clicks),
          IntCellValue(store.views),
          TextCellValue(store.createdAt != null ? DateFormat('yyyy-MM-dd HH:mm').format(store.createdAt!) : ""),
          TextCellValue(store.updatedAt != null ? DateFormat('yyyy-MM-dd HH:mm').format(store.updatedAt!) : ""),
          TextCellValue(userInfo),
          TextCellValue(products),
        ]);
      }

      final fileBytes = excel.encode();
      if (fileBytes == null) throw Exception("Failed to encode Excel file.");

      if (kIsWeb) {
        final blob = html.Blob([fileBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.AnchorElement(href: url)
          ..setAttribute("download", "Stores_${DateTime.now().millisecondsSinceEpoch}.xlsx")
          ..click();
        html.Url.revokeObjectUrl(url);
        showCustomSnackbar("Success", "Stores exported! Check your downloads folder.", backgroundColor: kGreenColor);
      } else {
        Directory dir = await getApplicationDocumentsDirectory();
        String path = "${dir.path}/Stores_${DateTime.now().millisecondsSinceEpoch}.xlsx";
        File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        showCustomSnackbar("Success", "Stores exported to Excel at: ${path.replaceAll(dir.path, 'App Documents')}");
      }
    } catch (e) {
      log("Error exporting stores: $e");
      showCustomSnackbar("Error", "Failed to export stores");
    } finally {
      isExporting.value = false;
    }
  }

  List<Store> get filteredStores {
    final query = searchText.value.trim().toLowerCase();
    if (query.isEmpty) return storeRequests;

    return storeRequests.where((store) {
      final company = store.companyName.toLowerCase();
      final speciality = store.speciality.toLowerCase();
      return company.contains(query) || speciality.contains(query);
    }).toList();
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchStores();
    await fetchUsersBasic();
    getProductCategories();
    getRfqCategories();
    searchController.addListener(() {
      searchText.value = searchController.text;
      currentPage.value = 1;
    });
  }

  Future<void> fetchStores({int page = 1}) async {
    try {
      final response = await storeServices.getStores(page: page, limit: itemsPerPage);
      storeRequests.clear();

      final List<Store> allStores = response["stores"] ?? [];
      final meta = response["meta"] ?? {};

      storeRequests.assignAll(allStores);
      if (meta.containsKey("totalPages")) {
        totalPages.value = meta["totalPages"];
      } else if (meta.containsKey("total") && itemsPerPage > 0) {
        totalPages.value = (meta["total"] / itemsPerPage).ceil();
      }

      currentPage.value = page;
    } catch (e) {
      log("Store screen Error fetching stores: $e");
    }
  }

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages.value);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      fetchStores(page: page);
    }
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value) {
      fetchStores(page: currentPage.value + 1);
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      fetchStores(page: currentPage.value - 1);
    }
  }

  Future<void> deleteStoreInController(String storeId) async {
    try {
      isDeleting.value = true;

      final message = await storeServices.deleteStore(storeId);

      await fetchStores();
      await dashboardController.fetchStores();

      Get.back();
      showCustomSnackbar("Success", message);
    } catch (e) {
      log("Error deleting store: $e");
      showCustomSnackbar("Error", "Failed to delete store. Please check if your store has associated users or products.");
    } finally {
      isDeleting.value = false;
    }
  }

  Future<void> createStore({
    required String userId,
    required String logo,
    required String companyName,
    required String bio,
    required String companyNumber,
    required String location,
    required String speciality,
    String storeStatus = 'Accepted',
    required String categoryId,
    required String subcategoryId,
    required String subSubcategoryId,
  }) async {
    try {
      isAdding.value = true;
      Store newStore = await storeServices.addStore(
        userId: userId,
        logo: logo,
        companyName: companyName,
        bio: bio,
        companyNumber: companyNumber,
        location: location,
        speciality: speciality,
        storeStatus: storeStatus,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        subSubcategoryId: subSubcategoryId,
      );
      await fetchStores();
      Get.back();

      showCustomSnackbar("Success", "Store created successfully", backgroundColor: kGreenColor);
    } catch (e) {
      log("Error creating store: $e");
      showCustomSnackbar("Error", "Failed to create store");
    } finally {
      isAdding.value = false;
    }
  }

  // final RxInt selectedTab = 0.obs;
  // final RxString selectedChip = ''.obs;

  final RxBool isContactForPrice = false.obs;

  final List<List<String>> medicalProd = const [
    ['Medical Supplies', 'Diagnostics', 'Pharmaceuticals', 'Personal Care', 'Orthopedics'],
    ['Blood Pressure', 'Diabetic Care', 'Injections', 'Dressings'],
  ];

  final List<List<String>> medServices = const [
    ['Consultation', 'Telemedicine', 'Home Care', 'Physiotherapy'],
    ['Lab Tests', 'Radiology', 'Surgery Assistance'],
  ];

  final List<List<String>> labEqu = const [
    ['Analytical Instruments', 'Safety Equipment', 'Reagents & Kits'],
    ['Microscopes', 'Centrifuges', 'Autoclaves', 'Pipettes'],
  ];

  /*  void toggleChip(String label) {
    if (selectedChip.value == label) {
      selectedChip.value = '';
    } else {
      selectedChip.value = label;
    }
  }*/

  void toggleContactForPrice(bool val) {
    isContactForPrice.value = val;
  }

  /*  void setSelectedTab(int index) {
    if (selectedTab.value != index) {
      selectedTab.value = index;
      selectedChip.value = '';
    }
  }*/

  final MedicalProductsServices productServices = MedicalProductsServices();
  final ImagePickerService imagePickerService = ImagePickerService();
  Future<void> addProductToStore({
    required String storeId,
    required String title,
    required String brand,
    required String country,
    required String description,
    required List<XFile> selectedImages,
    required double price,
    required bool isContactForPrice,
  }) async {
    if (selectedSubCategory.value.isEmpty) {
      showCustomSnackbar("Missing Field", "Please select a product subcategory.");
      return;
    }

    try {
      isAddingProduct.value = true;
      final List<String> imageUrls = [];
      for (var image in selectedImages) {
        String? extension;
        Uint8List fileBytes;

        if (kIsWeb) {
          final response = await image.readAsBytes();
          fileBytes = response.buffer.asUint8List();
          extension = image.name.split('.').last;
        } else {
          fileBytes = await io.File(image.path).readAsBytes();
          extension = image.path.split('.').last;
        }

        String url = await imagePickerService.uploadProductImagesToFirebase(fileBytes, extension);
        if (url.isNotEmpty) {
          imageUrls.add(url);
        }
      }

      if (imageUrls.isEmpty && selectedImages.isNotEmpty) {
        throw Exception("Failed to upload product images.");
      }

      await productServices.createProduct(
        storeId: storeId,
        brand: brand,
        category: selectedCategory.value,
        subCategory: selectedSubCategory.value,
        title: title,
        country: country,
        isContactForPrice: isContactForPrice,
        images: imageUrls,
        description: description,
        price: isContactForPrice ? 0 : price,
      );

      await fetchStores();
      await fetchStoreDetails(storeId);
      Get.back();
      showCustomSnackbar("Success", "Product added successfully!", backgroundColor: kGreenColor);
    } catch (e) {
      log("Error adding product: $e", name: "StoreController");
      showCustomSnackbar("Error", "Failed to add product: ${e.toString().split(':').last.trim()}");
    } finally {
      isAddingProduct.value = false;
    }
  }

  Future<void> deleteProductFromStore(String productId, String storeId) async {
    try {
      isDeletingProduct.value = true;
      final message = await productServices.deleteProduct(productId);
      await fetchStores();
      await fetchStoreDetails(storeId);
      Get.back();
      showCustomSnackbar("Success", message, backgroundColor: kGreenColor);
    } catch (e) {
      log("Error deleting product: $e", name: "StoreController");
      showCustomSnackbar("Error", "Failed to delete product: ${e.toString().split(':').last.trim()}");
    } finally {
      isDeletingProduct.value = false;
    }
  }

  final Rx<Store?> currentStoreDetail = Rx<Store?>(null);

  Future<void> fetchStoreDetails(String storeId) async {
    try {
      isFetching.value = true;
      currentStoreDetail.value = null;

      final store = await storeServices.getStoreDetail(storeId);
      currentStoreDetail.value = store;
    } catch (e) {
      log("Error fetching store details for $storeId: $e");
      showCustomSnackbar("Error", "Failed to load store details.");
    } finally {
      isFetching.value = false;
    }
  }

  //Product categories

  Future getProductCategories() async {
    try {
      isListLoading.value = true;
      var result = await productServices.getProductCategories();

      if (result is List<RfqCategoriesModel> && result.isNotEmpty) {
        categoriesList.assignAll(result);
        categoriesList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        selectedCategory.value = categoriesList[0].arName ?? '';
        selectedCategoryId.value = categoriesList[0].id ?? '';
        await getProductSubCategories(categoryId: categoriesList[0].id ?? '');

        isListLoading.value = false;
      } else {
        isListLoading.value = false;
      }
    } catch (e) {
      isListLoading.value = false;
    }
  }

  Future getProductSubCategories({required String categoryId}) async {
    try {
      subcategoriesList.clear();
      isDataLoading.value = true;
      var result = await productServices.getProductSubCategories(categoryId: categoryId);

      if (result is List<RfqSubCategoriesModel> && result.isNotEmpty) {
        subcategoriesList.addAll(result);
        subcategoriesList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        isDataLoading.value = false;

        return true;
      } else if (result is String && result.toLowerCase() == "coming soon") {
        isDataLoading.value = false;

        showCustomSnackbar("Coming Soon", "We're working hard to bring you something amazing.Stay tuned for the launch!", backgroundColor: Colors.orange);
        // Get.dialog(ComingSoonDialog(image: kComingSoonImage, text: lt.tr('kComingSoon'), details: lt.tr('kComingSoonMsg')));
      } else {
        isDataLoading.value = false;
      }
      return false;
    } catch (e) {
      isDataLoading.value = false;
      showCustomSnackbar("Error", "Something went wrong, please try again");
      return false;
    }
  }

  Future<void> selectTop(RfqCategoriesModel value) async {
    selectedCategoryId.value = value.id ?? "";
    selectedCategory.value = value.arName ?? "";
    bool hasData = await getProductSubCategories(categoryId: value.id ?? '');
    /* if (hasData) {
      selectedCategoryId.value = value.id ?? "";
      selectedCategory.value = value.arName ?? "";
    }*/
  }

  void selectSub(RfqSubCategoriesModel value) {
    selectedSubCategory.value = value.arName ?? '';
    selectedSubCategoryId.value = value.id ?? '';
  }

  Future getRfqCategories() async {
    try {
      isListLoading.value = true;
      var result = await productServices.getProductCategories();

      if (result is List<RfqCategoriesModel> && result.isNotEmpty) {
        rfqCategoriesList.assignAll(result);
        rfqCategoriesList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        isListLoading.value = false;
      } else {
        isListLoading.value = false;
      }
    } catch (e) {
      isListLoading.value = false;
    }
  }

  Future getRfqSubCategories({required String categoryId, bool isFromDropDown = false, RfqCategoriesModel? previousCategory, bool isEdit = false}) async {
    try {
      rfqSubcategoriesList.clear();
      rfqSubSubcategoriesModelList.clear();
      isDataLoading.value = true;
      var result = await productServices.getProductSubCategories(categoryId: categoryId);

      if (result is List<RfqSubCategoriesModel> && result.isNotEmpty) {
        rfqSubcategoriesList.assignAll(result);
        rfqSubcategoriesList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        isDataLoading.value = false;
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
        showCustomSnackbar("Coming Soon", "We're working hard to bring you something amazing.Stay tuned for the launch!", backgroundColor: Colors.orange);
      } else {
        isDataLoading.value = false;
      }
      return false;
    } catch (e) {
      isDataLoading.value = false;
      showCustomSnackbar("Error", "Something went wrong, please try again");
      return false;
    }
  }

  Future getRfqSubSubCategories({required String categoryId, required String subCategoryId, bool isFromDropDown = false, bool isEdit = false}) async {
    try {
      rfqSubSubcategoriesModelList.clear();
      isDataLoading.value = true;
      var result = await productServices.getRfqsSubSubCategories(categoryId: categoryId, subCategoryId: subCategoryId);

      if (result is List<RfqSubSubCategoriesModel> && result.isNotEmpty) {
        rfqSubSubcategoriesModelList.assignAll(result);
        rfqSubSubcategoriesModelList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        isDataLoading.value = false;
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
        isDataLoading.value = false;

        showCustomSnackbar("Coming Soon", "We're working hard to bring you something amazing.Stay tuned for the launch!", backgroundColor: Colors.orange);
      } else {
        isDataLoading.value = false;
      }

      return false;
    } catch (e) {
      isDataLoading.value = false;
      showCustomSnackbar("Error", "Something went wrong, please try again");
      return false;
    }
  }
}
