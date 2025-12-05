import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_button.dart';
import 'package:matloob_admin/utils/app_strings.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kWhiteColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(constraints: BoxConstraints(minHeight: constraints.maxHeight), child: _buildNotFoundContent(constraints)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotFoundContent(BoxConstraints constraints) {
    return LayoutBuilder(
      builder: (context, layoutConstraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth <= 600;
        final isTablet = screenWidth > 600 && screenWidth <= 900;
        final isDesktop = screenWidth > 900;

        // Responsive values following your project's pattern
        double horizontalPadding;
        double verticalPadding;
        double logoHeight;
        double iconSize;
        double titleFontSize;
        double subtitleFontSize;
        double bodyFontSize;
        double buttonHeight;
        double spacing;
        double containerPadding;

        if (isMobile) {
          horizontalPadding = 16.0;
          verticalPadding = 20.0;
          logoHeight = 50.0;
          iconSize = 120.0;
          titleFontSize = 28.0;
          subtitleFontSize = 18.0;
          bodyFontSize = 14.0;
          buttonHeight = 48.0;
          spacing = 16.0;
          containerPadding = 20.0;
        } else if (isTablet) {
          horizontalPadding = 24.0;
          verticalPadding = 24.0;
          logoHeight = 60.0;
          iconSize = 140.0;
          titleFontSize = 32.0;
          subtitleFontSize = 20.0;
          bodyFontSize = 15.0;
          buttonHeight = 50.0;
          spacing = 20.0;
          containerPadding = 24.0;
        } else {
          horizontalPadding = 32.0;
          verticalPadding = 32.0;
          logoHeight = 70.0;
          iconSize = 160.0;
          titleFontSize = 36.0;
          subtitleFontSize = 22.0;
          bodyFontSize = 16.0;
          buttonHeight = 52.0;
          spacing = 24.0;
          containerPadding = 32.0;
        }

        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isDesktop ? 800.0 : double.infinity),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Main Error Container
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(containerPadding),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: kGreyColor.withValues(alpha: 0.1), width: 1.0),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      // 404 Error Icon
                      Container(
                        padding: EdgeInsets.all(containerPadding * 0.8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: kPrimaryColor.withValues(alpha: 0.15), width: 2.0),
                        ),
                        child: SvgPicture.asset(kLogoImage, height: 72, width: 150),
                      ),

                      SizedBox(height: spacing * 1.5),

                      // 404 Text
                      Text(
                        '404',
                        style: TextStyle(
                          fontSize: titleFontSize * 2,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          letterSpacing: 4.0,
                          height: 1.0,
                        ),
                      ),

                      SizedBox(height: spacing),

                      // Page Not Found Title
                      Text(
                        'Page Not Found',
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600, color: kBlackColor, letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: spacing * 0.75),

                      // Description
                      Container(
                        constraints: BoxConstraints(maxWidth: isDesktop ? 500.0 : double.infinity),
                        child: Text(
                          'Sorry, the page you are looking for doesn\'t exist or has been moved. Please check the URL or go back to the dashboard.',
                          style: TextStyle(fontSize: bodyFontSize, color: kGreyColor, height: 1.6, letterSpacing: 0.2),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: spacing * 2),

                      // Action Buttons
                      _buildActionButtons(isMobile, isTablet, buttonHeight, bodyFontSize, spacing),
                    ],
                  ),
                ),

                SizedBox(height: spacing * 1.5),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(bool isMobile, bool isTablet, double buttonHeight, double fontSize, double spacing) {
    if (isMobile) {
      // Mobile: Stack buttons vertically
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              title: "GO BACK",
              onTap: () {
                Get.toNamed(kAuthScreenRoute);
              },
              height: buttonHeight,
              borderColor: kPrimaryColor,
              textColor: kWhiteColor,
            ),
          ),
        ],
      );
    } else {
      // Tablet/Desktop: Buttons side by side
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              title: "GO BACK",
              onTap: () {
                Get.toNamed(kAuthScreenRoute);
              },
              height: buttonHeight,
              borderColor: kPrimaryColor,
              textColor: kWhiteColor,
            ),
          ),
        ],
      );
    }
  }
}
