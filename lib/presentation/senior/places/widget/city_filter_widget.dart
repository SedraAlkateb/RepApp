import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityFilterWidget extends StatelessWidget {
  const CityFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final cityBloc = context.watch<AllCityBloc>();
    final List<CityModel> cities = cityBloc.cities;
    final int? selectedCityId = cityBloc.selectedCityId;

    final String selectedCityName = cityBloc.selectedCityName.isEmpty
        ? 'المحافظة'
        : cityBloc.selectedCityName;

    return PopupMenuButton<CityModel>(
      enabled: cities.isNotEmpty,
      tooltip: 'فلترة حسب المحافظة',
      position: PopupMenuPosition.under,
      onSelected: (city) {
        context.read<AllCityBloc>().add(
          SelectCityEvent(
            city,
          ),
        );
      },
      itemBuilder: (context) {
        return cities.map(
              (city) {
            final int cityId = cityBloc.cityIdOf(city);
            final String cityName = cityBloc.cityNameOf(city);
            final bool isSelected = cityId == selectedCityId;

            return PopupMenuItem<CityModel>(
              value: city,
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.location_city_outlined,
                    size: ui.smallIconSize + 2,
                    color: isSelected
                        ? ColorManager.medicalPrimary
                        : const Color(0xFF64748B),
                  ),
                  SizedBox(width: ui.smallSpacing),
                  Expanded(
                    child: Text(
                      cityName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ui.bodyTextSize,
                        fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList();
      },
      child: Opacity(
        opacity: cities.isEmpty ? 0.5 : 1,
        child: Container(
          height: 48,
          width: ui.isMobile ? 48 : 180,
          padding: EdgeInsets.symmetric(
            horizontal: ui.isMobile ? 0 : ui.mediumSpacing,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              ui.smallRadius + 2,
            ),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.filter_alt_outlined,
                size: ui.smallIconSize + 3,
                color: ColorManager.medicalPrimary,
              ),
              if (!ui.isMobile) ...[
                SizedBox(width: ui.smallSpacing),
                Expanded(
                  child: Text(
                    selectedCityName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ui.bodyTextSize,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 19,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}