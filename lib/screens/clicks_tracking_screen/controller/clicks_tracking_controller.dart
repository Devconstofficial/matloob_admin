import 'package:get/get.dart';

class ClickTrackingController extends GetxController {

  final List<Map<String, dynamic>> storeRequests = [
    {
      "id": "RFQ2001",
      "issuer": "Khalid Al-Fahad",
      "clickedBy": "Lina Al-Mutairi",
      "clicks": "11",
    },
    {
      "id": "RFQ2002",
      "issuer": "Noor Al-Rashed",
      "clickedBy": "Fahad Al-Zahrani",
      "clicks": "7",
    },
    {
      "id": "RFQ2003",
      "issuer": "Amal Al-Qahtani",
      "clickedBy": "Saeed Al-Otaibi",
      "clicks": "18",
    },
    {
      "id": "RFQ2004",
      "issuer": "Yousef Al-Harbi",
      "clickedBy": "Rana Al-Khalid",
      "clicks": "23",
    },
    {
      "id": "RFQ2005",
      "issuer": "Aisha Al-Jabri",
      "clickedBy": "Khaled Al-Shehri",
      "clicks": "42",
    },
    {
      "id": "RFQ2006",
      "issuer": "Rashed Al-Farhan",
      "clickedBy": "Sultan Al-Sabah",
      "clicks": "9",
    },
    {
      "id": "RFQ2007",
      "issuer": "Waleed Al-Dosari",
      "clickedBy": "Manal Al-Dabbagh",
      "clicks": "36",
    },
    {
      "id": "RFQ2008",
      "issuer": "Maha Al-Farsi",
      "clickedBy": "Noura Al-Ghamdi",
      "clicks": "13",
    },
    {
      "id": "RFQ2009",
      "issuer": "Ali Al-Sultan",
      "clickedBy": "Hessa Al-Naimi",
      "clicks": "28",
    },
    {
      "id": "RFQ2010",
      "issuer": "Dana Al-Mansour",
      "clickedBy": "Ibrahim Al-Shamrani",
      "clicks": "31",
    },
    {
      "id": "RFQ2011",
      "issuer": "Layla Al-Omair",
      "clickedBy": "Mohammed Al-Bassam",
      "clicks": "22",
    },
    {
      "id": "RFQ2012",
      "issuer": "Ziad Al-Mutlaq",
      "clickedBy": "Abeer Al-Suwaidi",
      "clicks": "17",
    },
    {
      "id": "RFQ2013",
      "issuer": "Hana Al-Shahrani",
      "clickedBy": "Tariq Al-Omari",
      "clicks": "27",
    },
    {
      "id": "RFQ2014",
      "issuer": "Mansour Al-Ruwaili",
      "clickedBy": "Alya Al-Fahim",
      "clicks": "44",
    },
    {
      "id": "RFQ2015",
      "issuer": "Nada Al-Madhi",
      "clickedBy": "Khalifa Al-Dabbagh",
      "clicks": "15",
    },
    {
      "id": "RFQ2016",
      "issuer": "Reema Al-Fahim",
      "clickedBy": "Yazan Al-Tamimi",
      "clicks": "38",
    },
    {
      "id": "RFQ2017",
      "issuer": "Sami Al-Hussain",
      "clickedBy": "Faisal Al-Khudair",
      "clicks": "50",
    },
    {
      "id": "RFQ2018",
      "issuer": "Nawal Al-Buqami",
      "clickedBy": "Yasmine Al-Jahani",
      "clicks": "10",
    },
    {
      "id": "RFQ2019",
      "issuer": "Hassan Al-Sabti",
      "clickedBy": "Salem Al-Ghamdi",
      "clicks": "19",
    },
    {
      "id": "RFQ2020",
      "issuer": "Mariam Al-Otaibi",
      "clickedBy": "Talal Al-Nasser",
      "clicks": "5",
    },
  ];

  final List<Map<String, dynamic>> rfqs = [
    {
      "id": "RFQ1021",
      "issuer": "Ahmed Al-Mutairi",
      "clickedBy": "Ahmed Al-Mutairi",
      "clicks": "44",
    },
    {
      "id": "RFQ1022",
      "issuer": "Sara Al-Dosari",
      "clickedBy": "Mohammed Al-Qahtani",
      "clicks": "32",
    },
    {
      "id": "RFQ1023",
      "issuer": "Fatima Al-Shehri",
      "clickedBy": "Faisal Al-Naimi",
      "clicks": "58",
    },
    {
      "id": "RFQ1024",
      "issuer": "Lama Al-Fahad",
      "clickedBy": "Yasir Al-Sabah",
      "clicks": "21",
    },
    {
      "id": "RFQ1025",
      "issuer": "Mona Al-Harbi",
      "clickedBy": "Ahmed Al-Mutairi",
      "clicks": "37",
    },
    {
      "id": "RFQ1026",
      "issuer": "Hassan Al-Rashid",
      "clickedBy": "Sara Al-Dosari",
      "clicks": "18",
    },
    {
      "id": "RFQ1027",
      "issuer": "Dalal Al-Zahrani",
      "clickedBy": "Mohammed Al-Qahtani",
      "clicks": "63",
    },
    {
      "id": "RFQ1028",
      "issuer": "Nasser Al-Fahim",
      "clickedBy": "Fatima Al-Shehri",
      "clicks": "49",
    },
    {
      "id": "RFQ1029",
      "issuer": "Alya Al-Dabbagh",
      "clickedBy": "Faisal Al-Naimi",
      "clicks": "26",
    },
    {
      "id": "RFQ1030",
      "issuer": "Saleh Al-Tamimi",
      "clickedBy": "Lama Al-Fahad",
      "clicks": "35",
    },
    {
      "id": "RFQ1031",
      "issuer": "Reem Al-Sultan",
      "clickedBy": "Yasir Al-Sabah",
      "clicks": "14",
    },
    {
      "id": "RFQ1032",
      "issuer": "Ziyad Al-Otaibi",
      "clickedBy": "Mona Al-Harbi",
      "clicks": "72",
    },
    {
      "id": "RFQ1033",
      "issuer": "Huda Al-Khalid",
      "clickedBy": "Hassan Al-Rashid",
      "clicks": "40",
    },
    {
      "id": "RFQ1034",
      "issuer": "Tariq Al-Mansour",
      "clickedBy": "Dalal Al-Zahrani",
      "clicks": "17",
    },
    {
      "id": "RFQ1035",
      "issuer": "Rania Al-Juhani",
      "clickedBy": "Nasser Al-Fahim",
      "clicks": "53",
    },
    {
      "id": "RFQ1036",
      "issuer": "Ibrahim Al-Bassam",
      "clickedBy": "Alya Al-Dabbagh",
      "clicks": "29",
    },
    {
      "id": "RFQ1037",
      "issuer": "Fatimah Al-Farsi",
      "clickedBy": "Saleh Al-Tamimi",
      "clicks": "66",
    },
    {
      "id": "RFQ1038",
      "issuer": "Sultan Al-Qahtani",
      "clickedBy": "Reem Al-Sultan",
      "clicks": "38",
    },
    {
      "id": "RFQ1039",
      "issuer": "Noor Al-Mutlaq",
      "clickedBy": "Ziyad Al-Otaibi",
      "clicks": "19",
    },
    {
      "id": "RFQ1040",
      "issuer": "Majed Al-Omari",
      "clickedBy": "Huda Al-Khalid",
      "clicks": "50",
    },
  ];

  var currentPage2 = 1.obs;
  final int itemsPerPage2 = 4;
  final int pagesPerGroup2 = 4;

  int get totalPages2 => (rfqs.length / itemsPerPage2).ceil();

  List get pagedUsers2 {
    int start = (currentPage2.value - 1) * itemsPerPage2;
    int end = start + itemsPerPage2;
    return rfqs.sublist(
      start,
      end > rfqs.length ? rfqs.length : end,
    );
  }

  int get currentGroup2 => ((currentPage2.value - 1) / pagesPerGroup2).floor();

  List<int> get visiblePageNumbers2 {
    int startPage = currentGroup2 * pagesPerGroup2 + 1;
    int endPage = (startPage + pagesPerGroup2 - 1).clamp(1, totalPages2);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage2(int page) {
    if (page >= 1 && page <= totalPages2) currentPage2.value = page;
  }

  void goToNextPage2() {
    if (currentPage2.value < totalPages2) {
      currentPage2.value++;
    }
  }

  void goToPreviousPage2() {
    if (currentPage2.value > 1) {
      currentPage2.value--;
    }
  }

  var currentPage = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 4;

  int get totalPages => (storeRequests.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return storeRequests.sublist(
      start,
      end > storeRequests.length ? storeRequests.length : end,
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
