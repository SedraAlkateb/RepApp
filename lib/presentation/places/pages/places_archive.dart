import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/widget/place_archive/places_archive_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesArchive extends StatefulWidget {
  const PlacesArchive({super.key});

  @override
  State<PlacesArchive> createState() => _PlacesArchiveState();
}

class _PlacesArchiveState extends State<PlacesArchive> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<PlaceBloc>().add(
      NumEvent(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          'ارشيف المناطق',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: PlacesArchiveResponsiveLayout(
        searchController: searchController,
      ),
    );
  }
}