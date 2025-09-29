class WebUrls extends _BaseUrl {
  WebUrls._();
  static const String kSignInUrl = "${_BaseUrl._kBaseUrl}/login";
  static const String kResetRequestUrl =
      "${_BaseUrl._kBaseUrl}/forgot-password/request";
  static const String kVerifyOtpUrl =
      "${_BaseUrl._kBaseUrl}/forgot-password/verify";
  static const String kResendOtpUrl =
      "${_BaseUrl._kBaseUrl}/forgot-password/resend";
  static const String kCreatePasswordUrl =
      "${_BaseUrl._kBaseUrl}/forgot-password/reset";
  static const String kGetProfileUrl = "${_BaseUrl._kBaseUrl}/me";
  static const String kUpdateProfileUrl = "${_BaseUrl._kBaseUrl}/me";
  static const String kGetAllStoresUrl = "${_BaseUrl._kBaseUrl}/stores";
  static const String kUpdateStoreUrl = "${_BaseUrl._kBaseUrl}/store";
  static const String kUpdateStoreStatusUrl = "${_BaseUrl._kBaseUrl}/store";
  static const String kGetStoreDetailsUrl = "${_BaseUrl._kBaseUrl}/store";
  static const String kAddStoreUrl = "${_BaseUrl._kBaseUrl}/store";
  static const String kDeleteStoreUrl = "${_BaseUrl._kBaseUrl}/store";
  static const String kGetAllRFQSUrl = "${_BaseUrl._kBaseUrl}/rfqs";
  static const String kUpdateRFQUrl = "${_BaseUrl._kBaseUrl}/rfq";
  static const String kUpdateRFQStatusUrl = "${_BaseUrl._kBaseUrl}/rfq";
  static const String kGetRFQDetailsUrl = "${_BaseUrl._kBaseUrl}/rfq";
  static const String kDeleteRFQUrl = "${_BaseUrl._kBaseUrl}/rfq";
  static const String kGetAllUsersUrl = "${_BaseUrl._kBaseUrl}/users";
  static const String kGetAllUsersAnalyticsUrl =
      "${_BaseUrl._kBaseUrl}/users/analytics";
  static const String kUpdateUserStatusUrl = "${_BaseUrl._kBaseUrl}/user";
  static const String kUpdateUserUrl = "${_BaseUrl._kBaseUrl}/user";
  static const String kAddUserUrl = "${_BaseUrl._kBaseUrl}/user";
  static const String kGetUsersBasicUrl = "${_BaseUrl._kBaseUrl}/users/basic";
  static const String kDeleteUserUrl = "${_BaseUrl._kBaseUrl}/user";
  static const String kGetStoreClickUrl = "${_BaseUrl._kBaseUrl}/store-clicks";
  static const String kGetRFQClickUrl = "${_BaseUrl._kBaseUrl}/rfq-clicks";
  static const String kCreateProductUrl = "${_BaseUrl._kBaseUrl}/product";
  static const String kDeleteProductUrl = "${_BaseUrl._kBaseUrl}/product";
}

abstract class _BaseUrl {
  static const String _kBaseUrl = 'https://backend.mtloobapp.com/api/admin';
}
