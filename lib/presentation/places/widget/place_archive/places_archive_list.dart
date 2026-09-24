import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/place_visit/widget/animation_press.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesArchiveList extends StatelessWidget {
  final double horizontalPadding;
  final double maxWidth;

  const PlacesArchiveList({
    super.key,
    required this.horizontalPadding,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceBloc, PlaceState>(
      listener: _listener,
      builder: (context, state) {
        List<PlaceModel> places = context.watch<PlaceBloc>().placeSearchModel;

        if (state is AllPlaceState) {
          places = state.places;
        }

        if (state is SearchPlaceState) {
          places = state.places;
        }

        if (places.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: emptyFullScreen(context),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: ListView.separated(
              shrinkWrap: true, // ضروري لكي تتكيف القائمة مع الـ SingleChildScrollView الخارجي
              physics: const NeverScrollableScrollPhysics(), // التمرير يتم عبر السكرول الخارجي للشاشة
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              itemCount: places.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemBuilder: (context, index) {
                final place = places[index];

                return AnimatedPlaceCard(
                  isRep:UserInfo.repType==7?true:false ,
                  place: place,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.doctorAndHospitalArchive,
                      arguments: place.placeId,
                    );

                    context.read<PlaceBloc>().add(
                      DoctorArchiveByPlace(
                        place.placeId,
                        0,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _listener(
      BuildContext context,
      PlaceState state,
      ) {
    if (state is AllPlaceErrorState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;

        error(
          context,
          state.failure.massage,
          state.failure.code,
        );
      });
    }

    if (state is CheckRepState && state.isCheck == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.logout,
              (route) => false,
            arguments: true, // بدون رفع: المندوب غير موجود بالسيرفر
        );
      });
    }
  }
}