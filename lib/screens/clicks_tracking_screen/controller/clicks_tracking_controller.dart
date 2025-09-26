import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../web_services/click_services.dart';
import '../../../models/rfq_click_model.dart';
import '../../../models/store_click_model.dart';

class ClickTrackingController extends GetxController {
  final ClickServices service = ClickServices();
  RxList<StoreClick> storeClicks = <StoreClick>[].obs;
  RxList<RFQClick> rfqClicks = <RFQClick>[].obs;
  RxList<StoreClick> filteredStoreClicks = <StoreClick>[].obs;
  RxList<RFQClick> filteredRFQClicks = <RFQClick>[].obs;
  TextEditingController storeSearchController = TextEditingController();
  TextEditingController rfqSearchController = TextEditingController();
  RxBool isStoreLoading = false.obs;
  RxBool isRFQLoading = false.obs;
  var currentStorePage = 1.obs;
  var currentRFQPage = 1.obs;
  final int itemsPerPage = 3;

  int get totalStorePages => (filteredStoreClicks.length / itemsPerPage).ceil();
  int get totalRFQPages => (filteredRFQClicks.length / itemsPerPage).ceil();

  List<StoreClick> get pagedStoreClicks {
    int start = (currentStorePage.value - 1) * itemsPerPage;
    int end = (start + itemsPerPage).clamp(0, filteredStoreClicks.length);
    return filteredStoreClicks.sublist(start, end);
  }

  List<RFQClick> get pagedRFQClicks {
    int start = (currentRFQPage.value - 1) * itemsPerPage;
    int end = (start + itemsPerPage).clamp(0, filteredRFQClicks.length);
    return filteredRFQClicks.sublist(start, end);
  }

  @override
  void onInit() {
    super.onInit();
    fetchStoreClicks();
    fetchRFQClicks();

    storeSearchController.addListener(applyStoreSearch);
    rfqSearchController.addListener(applyRFQSearch);
  }

  Future<void> fetchStoreClicks() async {
    try {
      isStoreLoading.value = true;
      final data = await service.getStoreClicks();
      storeClicks.assignAll(data);
      filteredStoreClicks.assignAll(data);
      currentStorePage.value = 1;
    } catch (e) {
      log("Error fetching store clicks: $e");
    } finally {
      isStoreLoading.value = false;
    }
  }

  Future<void> fetchRFQClicks() async {
    try {
      isRFQLoading.value = true;
      final data = await service.getRFQClicks();
      rfqClicks.assignAll(data);
      filteredRFQClicks.assignAll(data);
      currentRFQPage.value = 1;
    } catch (e) {
      log("Error fetching RFQ clicks: $e");
    } finally {
      isRFQLoading.value = false;
    }
  }

  void applyStoreSearch() {
    String query = storeSearchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredStoreClicks.assignAll(storeClicks);
    } else {
      filteredStoreClicks.assignAll(storeClicks.where((s) =>
          s.companyName.toLowerCase().contains(query) ||
          s.location.toLowerCase().contains(query)
          ));
    }
    currentStorePage.value = 1;
  }

  void applyRFQSearch() {
    String query = rfqSearchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredRFQClicks.assignAll(rfqClicks);
    } else {
      filteredRFQClicks.assignAll(rfqClicks.where((r) =>
          r.title.toLowerCase().contains(query)));
    }
    currentRFQPage.value = 1;
  }

  void nextStorePage() {
    if (currentStorePage.value < totalStorePages) currentStorePage.value++;
  }

  void previousStorePage() {
    if (currentStorePage.value > 1) currentStorePage.value--;
  }

  void nextRFQPage() {
    if (currentRFQPage.value < totalRFQPages) currentRFQPage.value++;
  }

  void previousRFQPage() {
    if (currentRFQPage.value > 1) currentRFQPage.value--;
  }
}
