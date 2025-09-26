import 'dart:developer';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:matloob_admin/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/user_analytics_model.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/web_services/user_services.dart';

class UserController extends GetxController {
  final RxList<UserWithAnalytics> users = <UserWithAnalytics>[].obs;
  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var isDeleting = false.obs;
  RxInt totalUsers = 0.obs;
  final UserServices userServices = UserServices();
  DashboardController dashboardController = Get.put(DashboardController());

  var selectedStatus = ''.obs;
  var currentPage = 1.obs;
  final int itemsPerPage = 7;
  final int pagesPerGroup = 5;
  var searchText = "".obs;
  var isExporting = false.obs;
  var isAdding = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    searchController.addListener(() {
      searchText.value = searchController.text;
      currentPage.value = 1;
    });
  }

  Future<void> deleteUserInController(String userId) async {
    try {
      isDeleting.value = true;
      final message = await userServices.deleteUser(userId);
      await fetchUsers();

      await dashboardController.fetchUsers();
      Get.back();
      showCustomSnackbar("Success", message, backgroundColor: kGreenColor);
    } catch (e) {
      log("Error deleting user: $e");
      showCustomSnackbar(
        "Error",
        "Failed to delete user. User might be associated with existing RFQs or Store.",
      );
    } finally {
      isDeleting.value = false;
    }
  }

  Future<void> addUserInController({
    required String name,
    required String mobile,
    required String email,
    String? companyName,
    String? roles,
  }) async {
    if (name.isEmpty || mobile.isEmpty || email.isEmpty) {
      showCustomSnackbar("Error", "Name, Mobile and Email are required");
      return;
    }
    try {
      isAdding.value = true;

      final newUser = await userServices.addUser(
        name: name,
        mobile: mobile,
        email: email,
      );

      await fetchUsers();
      await dashboardController.fetchUsers();
      Get.back();
      showCustomSnackbar(
        "Success",
        "User added successfully",
        backgroundColor: kGreenColor,
      );
    } catch (e) {
      log("Error adding user: $e");
      showCustomSnackbar("Error", e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isAdding.value = false;
    }
  }

  Future<void> exportUsersToExcel() async {
    try {
      isExporting.value = true;
      var excel = Excel.createExcel();
      Sheet sheetObject = excel[excel.getDefaultSheet() ?? 'Users'];

      final List<CellValue> headerValues =
          [
            "User ID",
            "Name",
            "Email",
            "Mobile",
            "Company Name",
            "Verified",
            "Status",
            "Roles",
            "Total RFQs",
            "RFQ Supplier Response",
            "RFQ No Response",
            "Created At",
            "Updated At",
          ].map((title) => TextCellValue(title)).toList();
      sheetObject.appendRow(headerValues);
      for (var user in users) {
        sheetObject.appendRow([
          TextCellValue(user.id),
          TextCellValue(user.name ?? ""),
          TextCellValue(user.email ?? ""),
          TextCellValue(user.mobile ?? ""),
          TextCellValue(user.companyName ?? ""),
          TextCellValue(user.isVerified ? "Yes" : "No"),
          TextCellValue(user.status),
          TextCellValue(user.roles),
          IntCellValue(user.totalRfqs),
          IntCellValue(user.rfqSupplierResponse),
          IntCellValue(user.rfqNoResponse),
          TextCellValue(
            user.createdAt != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(user.createdAt!)
                : "",
          ),
          TextCellValue(
            user.updatedAt != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(user.updatedAt!)
                : "",
          ),
        ]);
      }

      final fileBytes = excel.encode();
      if (fileBytes == null) throw Exception("Failed to encode Excel file.");

      if (kIsWeb) {
        final blob = html.Blob([fileBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor =
            html.AnchorElement(href: url)
              ..setAttribute(
                "download",
                "Users_${DateTime.now().millisecondsSinceEpoch}.xlsx",
              )
              ..click();
        html.Url.revokeObjectUrl(url);

        showCustomSnackbar(
          "Success",
          "Users exported! Check your downloads folder.",
          backgroundColor: kGreenColor,
        );
        log("Excel file downloaded in browser");
      } else {
        Directory directory = await getApplicationDocumentsDirectory();
        String filePath =
            "${directory.path}/Users_${DateTime.now().millisecondsSinceEpoch}.xlsx";
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);

        showCustomSnackbar(
          "Success",
          "Users exported to Excel at: ${filePath.replaceAll(directory.path, 'App Documents')}",
          backgroundColor: kGreenColor,
        );
        log("Excel file saved at: $filePath");
      }
    } catch (e) {
      log("Error exporting users: $e");
      showCustomSnackbar("Error", "Failed to export users");
    } finally {
      isExporting.value = false;
    }
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      users.clear();

      final fetchedUsers = await userServices.getUsersWithAnalytics();

      final nonAdminUsers =
          fetchedUsers.where((u) => u.roles.toLowerCase() != "admin").toList();

      users.assignAll(nonAdminUsers);
      totalUsers.value = users.length;
      currentPage.value = 1;
    } catch (e) {
      log("Error fetching users: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<UserWithAnalytics> get filteredUsers {
    final query = searchText.value.trim().toLowerCase();
    if (query.isEmpty) return users;

    return users.where((u) {
      final name = u.name?.toLowerCase() ?? '';
      final email = u.email?.toLowerCase() ?? '';
      final mobile = u.mobile?.toLowerCase() ?? '';
      return name.contains(query) ||
          email.contains(query) ||
          mobile.contains(query);
    }).toList();
  }

  int get totalPages => (filteredUsers.length / itemsPerPage).ceil();

  List<UserWithAnalytics> get pagedUsers {
    if (filteredUsers.isEmpty) return [];
    int start = (currentPage.value - 1) * itemsPerPage;
    if (start >= filteredUsers.length) return [];
    int end = start + itemsPerPage;
    return filteredUsers.sublist(
      start,
      end > filteredUsers.length ? filteredUsers.length : end,
    );
  }

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  Future<void> updateUserInController({
    required String userId,
    String? name,
    String? mobile,
    String? email,
    String? companyName,
    String? status,
    String? roles,
  }) async {
    try {
      isUpdating.value = true;

      final updatedUser = await userServices.updateUser(
        userId: userId,
        name: name,
        mobile: mobile,
        email: email,
        companyName: companyName,
        status: status,
        roles: roles,
      );
      if (status != null) {
        await updateUserStatusInController(userId: userId, status: status);
      }
      await fetchUsers();
      Get.back();

      showCustomSnackbar(
        'Success',
        'User updated successfully',
        backgroundColor: kGreenColor,
      );
    } catch (e) {
      log("Error updating user: $e");
      showCustomSnackbar('Error', 'Failed to update user');
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> updateUserStatusInController({
    required String userId,
    required String status,
  }) async {
    try {
      isUpdating.value = true;
      await userServices.updateUserStatus(userId: userId, status: status);
    } catch (e) {
      log("Error updating user status: $e");
      showCustomSnackbar('Error', 'Failed to update user status');
    } finally {
      isUpdating.value = false;
    }
  }
}
