import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceArchiveTabBar extends StatelessWidget {
  const PlaceArchiveTabBar({
    super.key,
    required this.placeId,
    required this.height,
  });

  final int placeId;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.zero,

        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,

        labelStyle: const TextStyle(

          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),

        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),

        indicator: BoxDecoration(
          color: ColorManager.medicalPrimary,
          borderRadius: BorderRadius.circular(12),
        ),

        onTap: (index) {
          if (index == 0) {
            context.read<PlaceBloc>().add(
              DoctorArchiveByPlace(
                placeId,
                0,
              ),
            );
          } else {
            context.read<PlaceBloc>().add(
              HospitalArchiveByPlace(
                placeId,
                1,
              ),
            );
          }
        },

        tabs: const [
          Tab(
            child: _ArchiveTabItem(
              icon: Icons.groups_outlined,
              title: 'الأطباء',
            ),
          ),
          Tab(
            child: _ArchiveTabItem(
              icon: Icons.local_hospital_outlined,
              title: 'المشافي',
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchiveTabItem extends StatelessWidget {
  const _ArchiveTabItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 21,
        ),

        const SizedBox(width: 8),

        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}