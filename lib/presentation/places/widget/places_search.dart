import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesSearch extends StatelessWidget {
  final TextEditingController controller;

  const PlacesSearch({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SearchField(
      searchController: controller,
      onPressed: (value) {
        context.read<PlaceBloc>().add(
          SearchPlaceEvent(
            value: value,
          ),
        );
      },
    );
  }
}