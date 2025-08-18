import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class DashboardController extends GetxController {
  final List<Map<String, dynamic>> storeRequests = [
    {
      "name": "Christine Brooks",
      "companyNumber": "00001",
      "location": "New York, USA",
      "speciality": "Both",
    },
    {
      "name": "Christine Brooks",
      "companyNumber": "00002",
      "location": "Los Angeles, USA",
      "speciality": "Products",
    },
    {
      "name": "Rosie Pearson",
      "companyNumber": "00003",
      "location": "Chicago, USA",
      "speciality": "Services",
    },
    {
      "name": "Christine Brooks",
      "companyNumber": "00004",
      "location": "Houston, USA",
      "speciality": "Both",
    },
  ];

  final List<Map<String, dynamic>> rfqs = [
    {
      "id": "RFQ1021",
      "submittedBy": "Ahmed Al-Mutairi",
      "category": "PPE Equipment",
      "city": "Riyadh",
    },
    {
      "id": "RFQ1022",
      "submittedBy": "Fatima Al-Harbi",
      "category": "Medical Supplies",
      "city": "Jeddah",
    },
    {
      "id": "RFQ1023",
      "submittedBy": "Mohammed Al-Qahtani",
      "category": "Hospital Furniture",
      "city": "Dammam",
    },
    {
      "id": "RFQ1024",
      "submittedBy": "Layla Al-Otaibi",
      "category": "Pharmaceuticals",
      "city": "Mecca",
    }
  ];


  // var currentPage2 = 1.obs;
  // final int itemsPerPage = 5;
  // final int pagesPerGroup = 4;
  //
  // int get totalPages => (allUsers.length / itemsPerPage).ceil();
  //
  // List get pagedUsers {
  //   int start = (currentPage2.value - 1) * itemsPerPage;
  //   int end = start + itemsPerPage;
  //   return allUsers.sublist(start, end > allUsers.length ? allUsers.length : end);
  // }
  //
  // int get currentGroup => ((currentPage2.value - 1) / pagesPerGroup).floor();
  //
  // List<int> get visiblePageNumbers {
  //   int startPage = currentGroup * pagesPerGroup + 1;
  //   int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
  //   return List.generate(endPage - startPage + 1, (index) => startPage + index);
  // }
  //
  // void goToPage(int page) {
  //   if (page >= 1 && page <= totalPages) currentPage2.value = page;
  // }
  //
  // void goToNextPage() {
  //   if (currentPage2.value < totalPages) {
  //     currentPage2.value++;
  //   }
  // }
  //
  // void goToPreviousPage() {
  //   if (currentPage2.value > 1) {
  //     currentPage2.value--;
  //   }
  // }
}