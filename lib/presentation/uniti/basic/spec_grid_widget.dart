import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecGridWidget extends StatelessWidget {
  final List<SpecDModel> items;
  final int crossAxisCount;
  final Function(SpecDModel model)? onTap;

  const SpecGridWidget({
    super.key,
    required this.items,
    required this.crossAxisCount,
    this.onTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    // 🌟 تصفية القائمة لعرض العناصر التي تحتوي على flag == 1 فقط
    final filteredItems = items.where((item) => item.flag == 1).toList();

    final deviceType = AppResponsive.deviceType(context);

    double crossAxisSpacing;
    double mainAxisSpacing;
    double childAspectRatio;
    double cardPadding;
    double cardRadius;
    double iconContainerSize;
    double iconSize;
    double iconSpacing;
    double titleFontSize;
    double statFontSize;
    double statSpacing;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        crossAxisSpacing = 10;
        mainAxisSpacing = 10;
        childAspectRatio = 0.82;
        cardPadding = 12;
        cardRadius = 16;
        iconContainerSize = 54;
        iconSize = 30;
        iconSpacing = 10;
        titleFontSize = 14;
        statFontSize = 10.5;
        statSpacing = 3;
        break;

      case AppDeviceType.tabletPortrait:
        crossAxisSpacing = 14;
        mainAxisSpacing = 14;
        childAspectRatio = 0.88;
        cardPadding = 16;
        cardRadius = 18;
        iconContainerSize = 66;
        iconSize = 38;
        iconSpacing = 12;
        titleFontSize = 17;
        statFontSize = 12;
        statSpacing = 4;
        break;

      case AppDeviceType.tabletLandscape:
        crossAxisSpacing = 14;
        mainAxisSpacing = 14;
        childAspectRatio = 1.0;
        cardPadding = 14;
        cardRadius = 17;
        iconContainerSize = 60;
        iconSize = 34;
        iconSpacing = 10;
        titleFontSize = 16;
        statFontSize = 11.5;
        statSpacing = 3;
        break;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: filteredItems.length, // 🌟 القائمة المفلترة
      itemBuilder: (context, index) {
        final item = filteredItems[index]; // 🌟 جلب العنصر من المفلترة

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap != null
                ? () {
              onTap!(item);
            }
                : () {
              Navigator.pushNamed(
                context,
                Routes.docHos,
                arguments: {
                  'spId': item.id,
                },
              );
              BlocProvider.of<SeniorProfBloc>(context).add(
                DocHosEvent(
                  UserInfo.repId,
                  spId: item.id,
                  cityId: BlocProvider.of<AllCityBloc>(context).selectedCityId,
                ),
              );
            },
            borderRadius: BorderRadius.circular(cardRadius),
            child: Container(
              padding: EdgeInsets.all(cardPadding),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(cardRadius),
                border: Border.all(
                  color: ColorManager.inputBorder.withOpacity(0.45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.025),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: iconContainerSize,
                    height: iconContainerSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorManager.medicalSecondary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(
                        iconContainerSize * 0.30,
                      ),
                    ),
                    child: Image.asset(
                      ImageAssetsSpec().getImage(item.id),
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.contain,
                      color: ColorManager.medicalSecondary.withOpacity(0.85),
                      colorBlendMode: BlendMode.modulate,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.medical_services_outlined,
                          color: ColorManager.medicalSecondary,
                          size: iconSize,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: iconSpacing),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorManager.medicalText,
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize,
                      height: 1.25,
                    ),
                  ),
                  if (item.sumDoctor != 0 || item.sumHospital != 0) ...[
                    SizedBox(height: statSpacing + 2),
                    if (item.sumDoctor != 0)
                      _buildStatText(
                        text: "زيارات الأطباء: ${item.sumDoctor}",
                        fontSize: statFontSize,
                      ),
                    if (item.sumDoctor != 0 && item.sumHospital != 0)
                      SizedBox(height: statSpacing),
                    if (item.sumHospital != 0)
                      _buildStatText(
                        text: "زيارات المشافي: ${item.sumHospital}",
                        fontSize: statFontSize,
                      ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // =====================================================
  // Statistics Text
  // =====================================================

  Widget _buildStatText({
    required String text,
    required double fontSize,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: const Color(
          0xFF64748B,
        ),
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        height: 1.25,
      ),
    );
  }
}
