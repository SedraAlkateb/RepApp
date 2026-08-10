import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/widget/place/places_list.dart';
import 'package:domina_app/presentation/places/widget/places_search.dart';
import 'package:domina_app/presentation/places/widget/places_sync_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesContent extends StatelessWidget {
  final TextEditingController searchController;

  final double horizontalPadding;
  final double searchMaxWidth;
  final double listMaxWidth;

  const PlacesContent({
    super.key,
    required this.searchController,
    required this.horizontalPadding,
    required this.searchMaxWidth,
    required this.listMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final placeBloc = context.watch<PlaceBloc>();

    final showSyncWarning =
        UserInfo.endDate == placeBloc.data;

    return Column(
      children: [
        const SizedBox(height: 12),

        if (showSyncWarning)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: listMaxWidth,
                ),
                child: const PlacesSyncWarning(),
              ),
            ),
          ),

        if (showSyncWarning)
          const SizedBox(height: 12),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: searchMaxWidth,
              ),
              child: PlacesSearch(
                controller: searchController,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: PlacesList(
            horizontalPadding: horizontalPadding,
            maxWidth: listMaxWidth,
          ),
        ),
      ],
    );
  }
}