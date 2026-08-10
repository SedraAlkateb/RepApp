import 'package:domina_app/presentation/places/pages/doctor_archive.dart';
import 'package:domina_app/presentation/places/pages/hospital_archive.dart';
import 'package:domina_app/presentation/places/widget/place_visit_archive/place_archive_tab_bar.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class PlaceVisitArchiveResponsiveLayout extends StatelessWidget {
  const PlaceVisitArchiveResponsiveLayout({
    super.key,
    required this.placeId,
  });

  final int placeId;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double maxWidth;
    double horizontalPadding;
    double topPadding;
    double tabHeight;
    double titleSize;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        maxWidth = 600;
        horizontalPadding = 16;
        topPadding = 12;
        tabHeight = 58;
        titleSize = 18;
        break;

      case AppDeviceType.tabletPortrait:
        maxWidth = 850;
        horizontalPadding = 28;
        topPadding = 18;
        tabHeight = 64;
        titleSize = 21;
        break;

      case AppDeviceType.tabletLandscape:
        maxWidth = 1000;
        horizontalPadding = 36;
        topPadding = 14;
        tabHeight = 62;
        titleSize = 20;
        break;
    }

    return NestedScrollView(
      headerSliverBuilder: (
          context,
          innerBoxIsScrolled,
          ) {
        return [
          SliverAppBar(
            elevation: 0,
            floating: true,
            snap: true,
            pinned: false,
            backgroundColor: const Color(0xFFF8FAFC),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF0D47A1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'ارشيف المنطقة',
              style: TextStyle(
                color: const Color(0xFF0D47A1),
                fontWeight: FontWeight.bold,
                fontSize: titleSize,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                14,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                  ),
                  child: PlaceArchiveTabBar(
                    placeId: placeId,
                    height: tabHeight,
                  ),
                ),
              ),
            ),
          ),
        ];
      },

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child:  TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              DoctorArchive(),
              HospitalArchive(),
            ],
          ),
        ),
      ),
    );
  }
}