import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/places/widget/place/places_first_entry_dialog.dart';
import 'package:domina_app/presentation/places/widget/place/places_responsive_layout.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<PlaceBloc>().add(NumEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showFirstEntryDialog();
    });
  }

  Future<void> _showFirstEntryDialog() async {
    if (!mounted) return;

    final placeBloc = context.read<PlaceBloc>();

    if (placeBloc.k != 0) {
      return;
    }

    // لمنع ظهور الإشعار مرة أخرى بسبب rebuild.
    placeBloc.k = 1;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const PlacesFirstEntryDialog();
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorManager.medicalBg,
        drawer: DrawerPage(),
        appBar: _buildAppBar(),
        body: PlacesResponsiveLayout(
          searchController: searchController,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.medicalBg,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: ColorManager.medicalBorder,
          height: 1,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
              color: ColorManager.secondaryColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: const Text(
        'المناطق',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}