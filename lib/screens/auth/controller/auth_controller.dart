import 'package:get/get.dart';

class AuthController extends GetxController {
  var isPasswordHidden = true.obs;
  var isPasswordHidden1 = true.obs;
  var isPasswordHidden2 = true.obs;
  var isCheck = false.obs;
  RxBool isNotificationsOn = false.obs;
  var selectedCountry = ''.obs;
  var selectedTab = 0.obs;

  var selectedChips = <String>[].obs;

  void toggleChip(String label) {
    if (selectedChips.contains(label)) {
      selectedChips.remove(label);
    } else {
      selectedChips.add(label);
    }
  }

  List<List<String>> medicalProd = [
    ["Medical consumables", "Dental clinics", "Dental laboratories", "Dermatology and cosmetics", "Laboratories and Analysis"],
    ["Dental chairs and accessories", "Equipment, devices and photography", "Anesthesia","Dental Burs", "Sterilization & Disinfection"]
  ];

  List<List<String>> medServices = [
    ["Medical consumables", "Dental clinics", "Dental laboratories", "Dermatology and cosmetics", "Laboratories and Analysis"],
    ["Dental chairs and accessories", "Equipment, devices and photography", "Anesthesia","Dental Burs", "Sterilization & Disinfection"]
  ];

  List<List<String>> labEqu = [
    ["Medical consumables", "Dental clinics", "Dental laboratories", "Dermatology and cosmetics", "Laboratories and Analysis"],
    ["Dental chairs and accessories", "Equipment, devices and photography", "Anesthesia","Dental Burs", "Sterilization & Disinfection"]
  ];

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void togglePasswordVisibility1() {
    isPasswordHidden1.value = !isPasswordHidden1.value;
  }

  void togglePasswordVisibility2() {
    isPasswordHidden2.value = !isPasswordHidden2.value;
  }

}