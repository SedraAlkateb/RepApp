import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/drawer_model.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class CustomAppDrawer extends StatelessWidget {
  final String roleTitle;
  final List<DrawerMenuItem> menuItems;
  final bool showStats;

  const CustomAppDrawer({
    super.key,
    required this.roleTitle,
    required this.menuItems,
    this.showStats = false,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    double drawerWidth;

    double headerTopPadding;
    double headerBottomPadding;
    double headerHorizontalPadding;

    double avatarSize;
    double avatarRadius;
    double avatarFontSize;

    double nameFontSize;
    double roleFontSize;

    double headerSpacing;
    double smallSpacing;

    double chipHorizontalPadding;
    double chipVerticalPadding;
    double chipRadius;
    double chipIconSize;
    double chipFontSize;
    double chipSpacing;

    double listTopPadding;
    double listIconSize;
    double listFontSize;

    double versionPadding;
    double versionFontSize;

    double statsHorizontalPadding;
    double statsVerticalPadding;
    double statsGap;
    double statVerticalPadding;
    double statRadius;
    double statTitleFontSize;
    double statCountFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        drawerWidth = screenWidth * 0.86;

        if (drawerWidth > 330) {
          drawerWidth = 330;
        }

        headerTopPadding = 42;
        headerBottomPadding = 12;
        headerHorizontalPadding = 16;

        avatarSize = 72;
        avatarRadius = 15;
        avatarFontSize = 32;

        nameFontSize = 19;
        roleFontSize = 13;

        headerSpacing = 12;
        smallSpacing = 4;

        chipHorizontalPadding = 14;
        chipVerticalPadding = 6;
        chipRadius = 20;
        chipIconSize = 16;
        chipFontSize = 12;
        chipSpacing = 6;

        listTopPadding = 10;
        listIconSize = 22;
        listFontSize = 14;

        versionPadding = 20;
        versionFontSize = 12;

        statsHorizontalPadding = 14;
        statsVerticalPadding = 10;
        statsGap = 12;
        statVerticalPadding = 11;
        statRadius = 15;
        statTitleFontSize = 11;
        statCountFontSize = 18;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        drawerWidth = 360;

        headerTopPadding = 48;
        headerBottomPadding = 16;
        headerHorizontalPadding = 20;

        avatarSize = 82;
        avatarRadius = 17;
        avatarFontSize = 36;

        nameFontSize = 21;
        roleFontSize = 14;

        headerSpacing = 14;
        smallSpacing = 5;

        chipHorizontalPadding = 16;
        chipVerticalPadding = 7;
        chipRadius = 22;
        chipIconSize = 18;
        chipFontSize = 13;
        chipSpacing = 7;

        listTopPadding = 12;
        listIconSize = 24;
        listFontSize = 15;

        versionPadding = 22;
        versionFontSize = 13;

        statsHorizontalPadding = 18;
        statsVerticalPadding = 12;
        statsGap = 14;
        statVerticalPadding = 13;
        statRadius = 16;
        statTitleFontSize = 12;
        statCountFontSize = 20;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        drawerWidth = 390;

        headerTopPadding = 42;
        headerBottomPadding = 14;
        headerHorizontalPadding = 22;

        avatarSize = 84;
        avatarRadius = 18;
        avatarFontSize = 37;

        nameFontSize = 21;
        roleFontSize = 14;

        headerSpacing = 14;
        smallSpacing = 5;

        chipHorizontalPadding = 16;
        chipVerticalPadding = 7;
        chipRadius = 22;
        chipIconSize = 18;
        chipFontSize = 13;
        chipSpacing = 7;

        listTopPadding = 12;
        listIconSize = 24;
        listFontSize = 15;

        versionPadding = 22;
        versionFontSize = 13;

        statsHorizontalPadding = 18;
        statsVerticalPadding = 10;
        statsGap = 14;
        statVerticalPadding = 13;
        statRadius = 16;
        statTitleFontSize = 12;
        statCountFontSize = 20;
        break;
    }

    return Drawer(
      width: drawerWidth,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          _buildHeader(
            headerTopPadding: headerTopPadding,
            headerBottomPadding: headerBottomPadding,
            headerHorizontalPadding: headerHorizontalPadding,
            avatarSize: avatarSize,
            avatarRadius: avatarRadius,
            avatarFontSize: avatarFontSize,
            nameFontSize: nameFontSize,
            roleFontSize: roleFontSize,
            headerSpacing: headerSpacing,
            smallSpacing: smallSpacing,
            chipHorizontalPadding: chipHorizontalPadding,
            chipVerticalPadding: chipVerticalPadding,
            chipRadius: chipRadius,
            chipIconSize: chipIconSize,
            chipFontSize: chipFontSize,
            chipSpacing: chipSpacing,
            statsHorizontalPadding: statsHorizontalPadding,
            statsVerticalPadding: statsVerticalPadding,
            statsGap: statsGap,
            statVerticalPadding: statVerticalPadding,
            statRadius: statRadius,
            statTitleFontSize: statTitleFontSize,
            statCountFontSize: statCountFontSize,
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                top: listTopPadding,
              ),
              children: [
                ...menuItems.map(
                      (item) => _buildListTile(
                    context,
                    item,
                    iconSize: listIconSize,
                    fontSize: listFontSize,
                  ),
                ),

                const Divider(
                  color: Colors.black12,
                  thickness: 0.5,
                ),

                // =====================================
                // السلوك بقي كما هو تماماً
                // =====================================
                if (UserInfo.repType.i == 6 ||
                    UserInfo.repType.i == 7)
                  ...getLogoutItem(context).map(
                        (item) => _buildListTile(
                      context,
                      item,
                      iconSize: listIconSize,
                      fontSize: listFontSize,
                    ),
                  )
                else
                  ...getAdminLogoutItem(context).map(
                        (item) => _buildListTile(
                      context,
                      item,
                      iconSize: listIconSize,
                      fontSize: listFontSize,
                    ),
                  ),

                _buildVersionInfo(
                  padding: versionPadding,
                  fontSize: versionFontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Header
  // =====================================================

  Widget _buildHeader({
    required double headerTopPadding,
    required double headerBottomPadding,
    required double headerHorizontalPadding,
    required double avatarSize,
    required double avatarRadius,
    required double avatarFontSize,
    required double nameFontSize,
    required double roleFontSize,
    required double headerSpacing,
    required double smallSpacing,
    required double chipHorizontalPadding,
    required double chipVerticalPadding,
    required double chipRadius,
    required double chipIconSize,
    required double chipFontSize,
    required double chipSpacing,
    required double statsHorizontalPadding,
    required double statsVerticalPadding,
    required double statsGap,
    required double statVerticalPadding,
    required double statRadius,
    required double statTitleFontSize,
    required double statCountFontSize,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: headerTopPadding,
        bottom: headerBottomPadding,
        left: headerHorizontalPadding,
        right: headerHorizontalPadding,
      ),
      decoration: const BoxDecoration(
        color: ColorManager.medicalBg,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildAvatar(
            size: avatarSize,
            radius: avatarRadius,
            fontSize: avatarFontSize,
          ),

          SizedBox(
            height: headerSpacing,
          ),

          Text(
            UserInfo.name ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: nameFontSize,
              fontWeight: FontWeight.bold,
              color: ColorManager.secondaryColor1,
            ),
          ),

          SizedBox(
            height: smallSpacing,
          ),

          Text(
            "$roleTitle _ ${UserInfo.cityTitle}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: roleFontSize,
              color: Colors.grey[700],
            ),
          ),

          SizedBox(
            height: headerSpacing - 2,
          ),

          // ===========================================
          // الوصفات المنجزة
          // نفس البيانات ونفس السلوك
          // ===========================================
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: chipHorizontalPadding,
              vertical: chipVerticalPadding,
            ),
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(
                chipRadius,
              ),
              border: Border.all(
                color: ColorManager.primary1.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assignment_turned_in_outlined,
                  size: chipIconSize,
                  color: ColorManager.primary1,
                ),

                SizedBox(
                  width: chipSpacing,
                ),

                Flexible(
                  child: Text(
                    "الوصفات المنجزة: ${UserInfo.usedReci}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: chipFontSize,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===========================================
          // Stats
          // نفس شرط showStats
          // ===========================================
          if (showStats) ...[
            SizedBox(
              height: headerSpacing,
            ),

            _buildStatsSection(
              horizontalPadding: statsHorizontalPadding,
              verticalPadding: statsVerticalPadding,
              gap: statsGap,
              statVerticalPadding: statVerticalPadding,
              statRadius: statRadius,
              statTitleFontSize: statTitleFontSize,
              statCountFontSize: statCountFontSize,
            ),
          ],
        ],
      ),
    );
  }

  // =====================================================
  // Avatar
  // =====================================================

  Widget _buildAvatar({
    required double size,
    required double radius,
    required double fontSize,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ColorManager.medicalPrimary,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        UserInfo.name?[0] ?? "أ",
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =====================================================
  // Menu item
  // =====================================================

  Widget _buildListTile(
      BuildContext context,
      DrawerMenuItem item, {
        required double iconSize,
        required double fontSize,
      }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            item.icon,
            color: item.color ?? const Color(0xFF546E7A),
            size: iconSize,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: item.color ?? const Color(0xFF37474F),
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),

          // مهم:
          // لم نغيّر item.onTap إطلاقاً
          onTap: item.onTap,
        ),
      ],
    );
  }

  // =====================================================
  // Version
  // =====================================================

  Widget _buildVersionInfo({
    required double padding,
    required double fontSize,
  }) {
    return Padding(
      padding: EdgeInsets.all(
        padding,
      ),
      child: Text(
        'Version 4',
        style: TextStyle(
          color: ColorManager.secondaryColor7,
          fontSize: fontSize,
        ),
      ),
    );
  }

  // =====================================================
  // Stats Section
  // =====================================================

  Widget _buildStatsSection({
    required double horizontalPadding,
    required double verticalPadding,
    required double gap,
    required double statVerticalPadding,
    required double statRadius,
    required double statTitleFontSize,
    required double statCountFontSize,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          _buildStatCard(
            "المشافي",
            UserInfo.numOfHospitalVisit.toString(),
            true,
            verticalPadding: statVerticalPadding,
            radius: statRadius,
            titleFontSize: statTitleFontSize,
            countFontSize: statCountFontSize,
          ),

          SizedBox(
            width: gap,
          ),

          _buildStatCard(
            "الأطباء",
            UserInfo.numOfDoctorVisit.toString(),
            false,
            verticalPadding: statVerticalPadding,
            radius: statRadius,
            titleFontSize: statTitleFontSize,
            countFontSize: statCountFontSize,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Stat Card
  // =====================================================

  Widget _buildStatCard(
      String title,
      String count,
      bool showDot, {
        required double verticalPadding,
        required double radius,
        required double titleFontSize,
        required double countFontSize,
      }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          border: Border.all(
            color: Colors.grey[200]!,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // =====================================
                // نفس الشرط القديم حرفياً
                // =====================================
                if (showDot &&
                    UserInfo.numOfHospitalVisit != 0)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),

                if (showDot)
                  const SizedBox(
                    width: 4,
                  ),

                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 2,
            ),

            Text(
              count,
              style: TextStyle(
                fontSize: countFontSize,
                fontWeight: FontWeight.bold,
                color: ColorManager.secondaryColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}