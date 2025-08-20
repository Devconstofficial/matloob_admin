import 'package:get/get.dart';

class StoreController extends GetxController {
  final List<Map<String, dynamic>> allStores = [
    {
      "id": "STORE-001",
      "compName": "MediCorp Distributors",
      "registeredOn": "21 Jun 2021",
      "views": "2.4k",
      "compNumber": "056653567",
      "location": "Mecca",
      "specialty": "Both",
      "status": "Active",
    },
    {
      "id": "STORE-002",
      "compName": "PharmaZone Ltd.",
      "registeredOn": "15 Jul 2022",
      "views": "--",
      "compNumber": "056653568",
      "location": "Riyadh",
      "specialty": "Services",
      "status": "Pending",
    },
    {
      "id": "STORE-003",
      "compName": "HealthFirst Supplies",
      "registeredOn": "05 Mar 2023",
      "views": "109",
      "compNumber": "056653569",
      "location": "Dammam",
      "specialty": "Products",
      "status": "Restricted",
    },
    {
      "id": "STORE-004",
      "compName": "LifeMed Co.",
      "registeredOn": "12 Jan 2022",
      "views": "350",
      "compNumber": "056653570",
      "location": "Jeddah",
      "specialty": "Both",
      "status": "Active",
    },
    {
      "id": "STORE-005",
      "compName": "Elite Care",
      "registeredOn": "30 Nov 2021",
      "views": "789",
      "compNumber": "056653571",
      "location": "Tabuk",
      "specialty": "Services",
      "status": "Active",
    },
    {
      "id": "STORE-006",
      "compName": "Wellness Traders",
      "registeredOn": "01 May 2023",
      "views": "143",
      "compNumber": "056653572",
      "location": "Abha",
      "specialty": "Products",
      "status": "Pending",
    },
    {
      "id": "STORE-007",
      "compName": "HealWell Partners",
      "registeredOn": "18 Feb 2022",
      "views": "432",
      "compNumber": "056653573",
      "location": "Khobar",
      "specialty": "Both",
      "status": "Restricted",
    },
    {
      "id": "STORE-008",
      "compName": "CareLink Inc.",
      "registeredOn": "20 Oct 2021",
      "views": "1.2k",
      "compNumber": "056653574",
      "location": "Yanbu",
      "specialty": "Products",
      "status": "Active",
    },
    {
      "id": "STORE-009",
      "compName": "PharmaConnect",
      "registeredOn": "08 Apr 2022",
      "views": "789",
      "compNumber": "056653575",
      "location": "Buraidah",
      "specialty": "Services",
      "status": "Pending",
    },
    {
      "id": "STORE-010",
      "compName": "MedSupply Express",
      "registeredOn": "25 Aug 2023",
      "views": "55",
      "compNumber": "056653576",
      "location": "Najran",
      "specialty": "Both",
      "status": "Active",
    },
    {
      "id": "STORE-011",
      "compName": "Zahra Medical",
      "registeredOn": "14 Dec 2022",
      "views": "620",
      "compNumber": "056653577",
      "location": "Mecca",
      "specialty": "Products",
      "status": "Restricted",
    },
    {
      "id": "STORE-012",
      "compName": "Al Noor Supplies",
      "registeredOn": "10 Jan 2024",
      "views": "998",
      "compNumber": "056653578",
      "location": "Riyadh",
      "specialty": "Services",
      "status": "Active",
    },
    {
      "id": "STORE-013",
      "compName": "MedCity Traders",
      "registeredOn": "03 Feb 2022",
      "views": "234",
      "compNumber": "056653579",
      "location": "Jeddah",
      "specialty": "Products",
      "status": "Pending",
    },
    {
      "id": "STORE-014",
      "compName": "Pulse Healthcare",
      "registeredOn": "17 Mar 2023",
      "views": "301",
      "compNumber": "056653580",
      "location": "Dammam",
      "specialty": "Both",
      "status": "Active",
    },
    {
      "id": "STORE-015",
      "compName": "Global MedTech",
      "registeredOn": "22 Jun 2021",
      "views": "--",
      "compNumber": "056653581",
      "location": "Tabuk",
      "specialty": "Services",
      "status": "Restricted",
    },
    {
      "id": "STORE-016",
      "compName": "BioCare Supply",
      "registeredOn": "29 Sep 2022",
      "views": "1.9k",
      "compNumber": "056653582",
      "location": "Abha",
      "specialty": "Products",
      "status": "Active",
    },
    {
      "id": "STORE-017",
      "compName": "Smart Health Solutions",
      "registeredOn": "06 Jan 2023",
      "views": "470",
      "compNumber": "056653583",
      "location": "Yanbu",
      "specialty": "Both",
      "status": "Pending",
    },
    {
      "id": "STORE-018",
      "compName": "MediServe Arabia",
      "registeredOn": "19 May 2023",
      "views": "1.1k",
      "compNumber": "056653584",
      "location": "Buraidah",
      "specialty": "Services",
      "status": "Active",
    },
    {
      "id": "STORE-019",
      "compName": "CareHub Network",
      "registeredOn": "11 Apr 2021",
      "views": "882",
      "compNumber": "056653585",
      "location": "Khobar",
      "specialty": "Products",
      "status": "Restricted",
    },
    {
      "id": "STORE-020",
      "compName": "SahaTech Medical",
      "registeredOn": "02 Oct 2023",
      "views": "2.1k",
      "compNumber": "056653586",
      "location": "Najran",
      "specialty": "Both",
      "status": "Active",
    },
    {
      "id": "STORE-021",
      "compName": "SahaTech Medical",
      "registeredOn": "02 Oct 2023",
      "views": "2.1k",
      "compNumber": "056653586",
      "location": "Najran",
      "specialty": "Both",
      "status": "Active",
    },
  ];
  var selectedStatus = ''.obs;

  var currentPage2 = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 5;

  int get totalPages => (allStores.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage2.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return allStores.sublist(
      start,
      end > allStores.length ? allStores.length : end,
    );
  }

  int get currentGroup => ((currentPage2.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage2.value = page;
  }

  void goToNextPage() {
    if (currentPage2.value < totalPages) {
      currentPage2.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPage2.value > 1) {
      currentPage2.value--;
    }
  }
}
