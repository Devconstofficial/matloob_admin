import 'package:get/get.dart';

class RfqController extends GetxController {
  final List<Map<String, dynamic>> rfqs = [
    {
      "id": "RFQ1021",
      "subBy": "Ahmed Al-Mutairi",
      "category": "PPE Equipment",
      "city": "Riyadh",
      "subOn": "21 Jul 2025, 10:32",
      "response": "3",
      "status": "Published",
    },
    {
      "id": "RFQ1022",
      "subBy": "Sara Al-Dosari",
      "category": "Ventilators",
      "city": "Jeddah",
      "subOn": "20 Jul 2025, 14:10",
      "response": "5",
      "status": "Pending",
    },
    {
      "id": "RFQ1023",
      "subBy": "Mohammed Al-Qahtani",
      "category": "Surgical Masks",
      "city": "Dammam",
      "subOn": "19 Jul 2025, 09:45",
      "response": "2",
      "status": "Expired",
    },
    {
      "id": "RFQ1024",
      "subBy": "Faisal Al-Saadi",
      "category": "Gloves",
      "city": "Mecca",
      "subOn": "18 Jul 2025, 11:00",
      "response": "7",
      "status": "Published",
    },
    {
      "id": "RFQ1025",
      "subBy": "Mona Al-Otaibi",
      "category": "Thermometers",
      "city": "Tabuk",
      "subOn": "17 Jul 2025, 15:30",
      "response": "4",
      "status": "Pending",
    },
    {
      "id": "RFQ1026",
      "subBy": "Hassan Al-Harbi",
      "category": "Face Shields",
      "city": "Abha",
      "subOn": "16 Jul 2025, 08:20",
      "response": "1",
      "status": "Expired",
    },
    {
      "id": "RFQ1027",
      "subBy": "Layla Al-Sabah",
      "category": "Sanitizers",
      "city": "Khobar",
      "subOn": "15 Jul 2025, 13:15",
      "response": "6",
      "status": "Published",
    },
    {
      "id": "RFQ1028",
      "subBy": "Yasir Al-Rashid",
      "category": "Disinfectants",
      "city": "Najran",
      "subOn": "14 Jul 2025, 17:50",
      "response": "3",
      "status": "Pending",
    },
    {
      "id": "RFQ1029",
      "subBy": "Noura Al-Hamad",
      "category": "Oxygen Cylinders",
      "city": "Yanbu",
      "subOn": "13 Jul 2025, 10:05",
      "response": "4",
      "status": "Expired",
    },
    {
      "id": "RFQ1030",
      "subBy": "Saleh Al-Fahad",
      "category": "Hospital Beds",
      "city": "Buraidah",
      "subOn": "12 Jul 2025, 09:00",
      "response": "2",
      "status": "Published",
    },
    {
      "id": "RFQ1031",
      "subBy": "Rania Al-Farsi",
      "category": "Medical Monitors",
      "city": "Jazan",
      "subOn": "11 Jul 2025, 16:45",
      "response": "3",
      "status": "Pending",
    },
    {
      "id": "RFQ1032",
      "subBy": "Tariq Al-Khalid",
      "category": "Needles & Syringes",
      "city": "Hail",
      "subOn": "10 Jul 2025, 08:00",
      "response": "5",
      "status": "Expired",
    },
    {
      "id": "RFQ1033",
      "subBy": "Huda Al-Mansour",
      "category": "Medical Gowns",
      "city": "Al-Kharj",
      "subOn": "09 Jul 2025, 14:40",
      "response": "7",
      "status": "Published",
    },
    {
      "id": "RFQ1034",
      "subBy": "Nasser Al-Tamimi",
      "category": "Medical Trolleys",
      "city": "Riyadh",
      "subOn": "08 Jul 2025, 11:30",
      "response": "2",
      "status": "Pending",
    },
    {
      "id": "RFQ1035",
      "subBy": "Alya Al-Madi",
      "category": "IV Stands",
      "city": "Jeddah",
      "subOn": "07 Jul 2025, 10:20",
      "response": "3",
      "status": "Expired",
    },
    {
      "id": "RFQ1036",
      "subBy": "Adel Al-Ghamdi",
      "category": "Ultrasound Devices",
      "city": "Dammam",
      "subOn": "06 Jul 2025, 15:10",
      "response": "6",
      "status": "Published",
    },
    {
      "id": "RFQ1037",
      "subBy": "Dalal Al-Saeed",
      "category": "Defibrillators",
      "city": "Mecca",
      "subOn": "05 Jul 2025, 12:35",
      "response": "1",
      "status": "Pending",
    },
    {
      "id": "RFQ1038",
      "subBy": "Ibrahim Al-Dabbagh",
      "category": "Infusion Pumps",
      "city": "Tabuk",
      "subOn": "04 Jul 2025, 09:15",
      "response": "2",
      "status": "Expired",
    },
    {
      "id": "RFQ1039",
      "subBy": "Reem Al-Sultan",
      "category": "ECG Machines",
      "city": "Abha",
      "subOn": "03 Jul 2025, 11:50",
      "response": "5",
      "status": "Published",
    },
    {
      "id": "RFQ1040",
      "subBy": "Ziyad Al-Zahrani",
      "category": "Diagnostic Kits",
      "city": "Khobar",
      "subOn": "02 Jul 2025, 10:00",
      "response": "4",
      "status": "Pending",
    },
    {
      "id": "RFQ1041",
      "subBy": "Fatimah Al-Bassam",
      "category": "Blood Pressure Monitors",
      "city": "Najran",
      "subOn": "01 Jul 2025, 13:25",
      "response": "3",
      "status": "Expired",
    },
  ];

  var currentPage2 = 1.obs;
  final int itemsPerPage = 7;
  final int pagesPerGroup = 5;

  int get totalPages => (rfqs.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage2.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return rfqs.sublist(
      start,
      end > rfqs.length ? rfqs.length : end,
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
