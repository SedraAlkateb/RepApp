import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/widget/place_archive/places_archive_responsive_layout.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
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
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        break;
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        break;
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;
        break;
    }

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: pageMaxWidth,
                  ),
                  child: SafeArea(
                    top: false,
                    child: PlacesArchiveResponsiveLayout(
                      searchController: searchController,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}