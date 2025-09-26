import 'dart:developer';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/image_picker_services.dart';
import 'package:matloob_admin/web_services/medical_products_services.dart';
import 'package:matloob_admin/web_services/store_services.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:matloob_admin/web_services/user_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

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
      final headers = [
        "Store ID",
        "Company Name",
        "Company Number",
        "Location",
        "Speciality",
        "Status",
        "Clicks",
        "Views",
        "Created At",
        "Updated At",
        "User Info",
        "Products",
      ];
      sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());

      for (var store in storeRequests) {
        String userInfo =
            store.user != null
                ? "Name: ${store.user!.name}, Email: ${store.user!.email}, Mobile: ${store.user!.mobile}"
                : "";

        String products =
            store.medicalProducts.isNotEmpty
                ? store.medicalProducts.map((p) => p.title).join(", ")
                : "";

        sheet.appendRow([
          TextCellValue(store.id),
          TextCellValue(store.companyName),
          TextCellValue(store.companyNumber),
          TextCellValue(store.location),
          TextCellValue(store.speciality),
          TextCellValue(store.storeStatus.toString().split('.').last),
          IntCellValue(store.clicks),
          IntCellValue(store.views),
          TextCellValue(
            store.createdAt != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(store.createdAt!)
                : "",
          ),
          TextCellValue(
            store.updatedAt != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(store.updatedAt!)
                : "",
          ),
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
          ..setAttribute(
            "download",
            "Stores_${DateTime.now().millisecondsSinceEpoch}.xlsx",
          )
          ..click();
        html.Url.revokeObjectUrl(url);
        showCustomSnackbar(
          "Success",
          "Stores exported! Check your downloads folder.",
          backgroundColor: kGreenColor,
        );
      } else {
        Directory dir = await getApplicationDocumentsDirectory();
        String path =
            "${dir.path}/Stores_${DateTime.now().millisecondsSinceEpoch}.xlsx";
        File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        showCustomSnackbar(
          "Success",
          "Stores exported to Excel at: ${path.replaceAll(dir.path, 'App Documents')}",
        );
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
    searchController.addListener(() {
      searchText.value = searchController.text;
      currentPage.value = 1;
    });
  }

  Future<void> fetchStores({int page = 1}) async {
    try {
      final response = await storeServices.getStores(
        page: page,
        limit: itemsPerPage,
      );
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
      log("Error fetching stores: $e");
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
      showCustomSnackbar(
        "Error",
        "Failed to delete store. Please check if your store has associated users or products.",
      );
    } finally {
      isDeleting.value = false;
    }
  }

  Future<void> createStore({
  required String userId,
  required String logo,
  required String companyName,
  required String companyNumber,
  required String location,
  required String speciality,
  String storeStatus = 'Accepted',
}) async {
  try {
    isAdding.value = true;
    Store newStore = await storeServices.addStore(
      userId: userId,
      logo: logo,
      companyName: companyName,
      companyNumber: companyNumber,
      location: location,
      speciality: speciality,
      storeStatus: storeStatus,
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

  final RxInt selectedTab = 0.obs;
  final RxString selectedChip = ''.obs;
  
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

  void toggleChip(String label) {
    if (selectedChip.value == label) {
      selectedChip.value = '';
    } else {
      selectedChip.value = label;
    }
  }

  void toggleContactForPrice(bool val) {
    isContactForPrice.value = val;
  }
  
  void setSelectedTab(int index) {
    if (selectedTab.value != index) {
      selectedTab.value = index;
      selectedChip.value = '';
    }
  }

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
    if (selectedChip.value.isEmpty) {
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

        String url = await imagePickerService.uploadProductImagesToFirebase(
          fileBytes,
          extension,
        );
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
        category: selectedTab.value == 0
            ? "Medical Products"
            : selectedTab.value == 1
                ? "Medical Services"
                : "Lab Equipment",
        subCategory: selectedChip.value,
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

  Future<void> deleteProductFromStore(String productId,String storeId) async {
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
    }
    finally {
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

}
