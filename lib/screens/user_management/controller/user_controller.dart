import 'package:get/get.dart';

class UserController extends GetxController {
  final List<Map<String, dynamic>> allUsers = [
    {
      "id": "User-1021",
      "subBy": "Ahmed Al-Mutairi",
      "number": "05546545641",
      "compName": "MediCorp Distributors",
      "email": "ahmed.mutairi@example.com",
      "status": "Active",
    },
    {
      "id": "User-1022",
      "subBy": "Sara Al-Dosari",
      "number": "05511223344",
      "compName": "HealthFirst Supplies",
      "email": "sara.dosari@example.com",
      "status": "Pending",
    },
    {
      "id": "User-1023",
      "subBy": "Mohammed Al-Qahtani",
      "number": "05599887766",
      "compName": "LifeLine Traders",
      "email": "m.qahtani@example.com",
      "status": "Restricted",
    },
    {
      "id": "User-1024",
      "subBy": "Fatima Al-Shehri",
      "number": "05577889900",
      "compName": "Gulf MedCare",
      "email": "fatima.shehri@example.com",
      "status": "Active",
    },
    {
      "id": "User-1025",
      "subBy": "Faisal Al-Naimi",
      "number": "05566778899",
      "compName": "Wellness Solutions",
      "email": "faisal.naimi@example.com",
      "status": "Pending",
    },
    {
      "id": "User-1026",
      "subBy": "Lama Al-Fahad",
      "number": "05522334455",
      "compName": "Nova Medical",
      "email": "lama.fahad@example.com",
      "status": "Active",
    },
    {
      "id": "User-1027",
      "subBy": "Yasir Al-Sabah",
      "number": "05533445566",
      "compName": "CarePoint Traders",
      "email": "yasir.sabah@example.com",
      "status": "Restricted",
    },
    {
      "id": "User-1028",
      "subBy": "Mona Al-Harbi",
      "number": "05544556677",
      "compName": "GigaPharm",
      "email": "mona.harbi@example.com",
      "status": "Active",
    },
    {
      "id": "User-1029",
      "subBy": "Hassan Al-Rashid",
      "number": "05555667788",
      "compName": "BetterHealth",
      "email": "hassan.rashid@example.com",
      "status": "Pending",
    },
    {
      "id": "User-1030",
      "subBy": "Dalal Al-Zahrani",
      "number": "05566778800",
      "compName": "Medico Supplies",
      "email": "dalal.zahrani@example.com",
      "status": "Active",
    },
    {
      "id": "User-1031",
      "subBy": "Nasser Al-Fahim",
      "number": "05577880011",
      "compName": "Global MedEquip",
      "email": "nasser.fahim@example.com",
      "status": "Restricted",
    },
    {
      "id": "User-1032",
      "subBy": "Alya Al-Dabbagh",
      "number": "05588990022",
      "compName": "TotalHealth Co.",
      "email": "alya.dabbagh@example.com",
      "status": "Active",
    },
    {
      "id": "User-1033",
      "subBy": "Saleh Al-Tamimi",
      "number": "05599001122",
      "compName": "Elite Medics",
      "email": "saleh.tamimi@example.com",
      "status": "Pending",
    },
    {
      "id": "User-1034",
      "subBy": "Reem Al-Sultan",
      "number": "05600112233",
      "compName": "PrimeCare",
      "email": "reem.sultan@example.com",
      "status": "Active",
    },
    {
      "id": "User-1035",
      "subBy": "Ziyad Al-Otaibi",
      "number": "05611223344",
      "compName": "FirstAid Plus",
      "email": "ziyad.otaibi@example.com",
      "status": "Pending",
    },
    {
      "id": "User-1036",
      "subBy": "Huda Al-Khalid",
      "number": "05622334455",
      "compName": "BioMedica",
      "email": "huda.khalid@example.com",
      "status": "Restricted",
    },
    {
      "id": "User-1037",
      "subBy": "Tariq Al-Mansour",
      "number": "05633445566",
      "compName": "MedicTrust",
      "email": "tariq.mansour@example.com",
      "status": "Active",
    },
    {
      "id": "User-1038",
      "subBy": "Rania Al-Juhani",
      "number": "05644556677",
      "compName": "ShieldMed Co.",
      "email": "rania.juhani@example.com",
      "status": "Pending",
    },
    {
      "id": "User-1039",
      "subBy": "Ibrahim Al-Bassam",
      "number": "05655667788",
      "compName": "SafeHands Supplies",
      "email": "ibrahim.bassam@example.com",
      "status": "Restricted",
    },
    {
      "id": "User-1040",
      "subBy": "Fatimah Al-Farsi",
      "number": "05666778899",
      "compName": "Phoenix Med",
      "email": "fatimah.farsi@example.com",
      "status": "Active",
    },
  ];

  var currentPage2 = 1.obs;
  final int itemsPerPage = 7;
  final int pagesPerGroup = 5;

  int get totalPages => (allUsers.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage2.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return allUsers.sublist(
      start,
      end > allUsers.length ? allUsers.length : end,
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
