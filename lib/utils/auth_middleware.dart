import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';

/// Middleware to protect routes that require authentication
class AuthMiddleware extends GetMiddleware {
  final SessionManagement _appPreferences = SessionManagement();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // Check if user has a valid token
    // final token = await _appPreferences.getSessionToken(tokenKey: SessionTokenKeys.kUserTokenKey);

    _appPreferences.getSessionToken(tokenKey: SessionTokenKeys.kUserTokenKey).then((authToken) {
      final token = authToken;
      // If no token or token is null/empty, redirect to login
      if (token == null || token.isEmpty) {
        // Clear any existing navigation stack and go to login
        return const RouteSettings(name: kAuthScreenRoute);
      }

      // If token exists, allow access to the requested route
      return null;
      print(token);
    });
  }

  /// Check if route requires authentication
  static bool isProtectedRoute(String? route) {
    const publicRoutes = [
      kNotFoundRoute, // Add this - 404 page should be accessible
      kAuthScreenRoute,
    ];

    return !publicRoutes.contains(route);
  }
}
