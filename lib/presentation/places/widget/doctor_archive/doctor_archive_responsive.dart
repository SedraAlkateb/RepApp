import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/uniti/basic/doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorArchiveResponsive extends StatelessWidget {
  const DoctorArchiveResponsive({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double maxWidth;
    double horizontalPadding;
    double topPadding;
    double searchBottomSpacing;
    double cardSpacing;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        maxWidth = 600;
        horizontalPadding = 12;
        topPadding = 12;
        searchBottomSpacing = 16;
        cardSpacing = 10;
        break;

      case AppDeviceType.tabletPortrait:
        maxWidth = 720;
        horizontalPadding = 20;
        topPadding = 18;
        searchBottomSpacing = 20;
        cardSpacing = 14;
        break;

      case AppDeviceType.tabletLandscape:
        maxWidth = 780;
        horizontalPadding = 24;
        topPadding = 14;
        searchBottomSpacing = 18;
        cardSpacing = 14;
        break;
    }

    return ColoredBox(
      color: const Color(0xFFF8FAFC),
      child: BlocBuilder<PlaceBloc, PlaceState>(
        buildWhen: (previous, current) {
          return current is AllDoctorArchiveByPlaceState ||
              current is AllDoctorArchiveByPlaceErrorState ||
              current is EmptyArchiveState;
        },
        builder: (context, state) {
          if (state is AllDoctorArchiveByPlaceState) {
            return _DoctorArchiveSuccess(
              state: state,
              searchController: searchController,
              maxWidth: maxWidth,
              horizontalPadding: horizontalPadding,
              topPadding: topPadding,
              searchBottomSpacing: searchBottomSpacing,
              cardSpacing: cardSpacing,
            );
          }

          if (state is AllDoctorArchiveByPlaceErrorState) {
            return _DoctorArchiveError(
              message: state.failure.massage,
              maxWidth: maxWidth,
            );
          }

          if (state is EmptyArchiveState) {
            return _DoctorArchiveEmpty(
              maxWidth: maxWidth,
            );
          }

          return const _DoctorArchiveLoading();
        },
      ),
    );
  }
}

class _DoctorArchiveSuccess extends StatelessWidget {
  const _DoctorArchiveSuccess({
    required this.state,
    required this.searchController,
    required this.maxWidth,
    required this.horizontalPadding,
    required this.topPadding,
    required this.searchBottomSpacing,
    required this.cardSpacing,
  });

  final AllDoctorArchiveByPlaceState state;

  final TextEditingController searchController;

  final double maxWidth;
  final double horizontalPadding;
  final double topPadding;
  final double searchBottomSpacing;
  final double cardSpacing;

  @override
  Widget build(BuildContext context) {
    final List<DoctorModel> doctors = state.searchData;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  topPadding,
                  horizontalPadding,
                  searchBottomSpacing,
                ),
                child: SearchField(
                  searchController: searchController,
                  onPressed: (value) {
                    context.read<PlaceBloc>().add(
                      SearchDoctorArchive(
                        value,
                        state.BaseData,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            0,
            horizontalPadding,
            32,
          ),
          sliver: SliverList.separated(
            itemCount: doctors.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: cardSpacing,
              );
            },
            itemBuilder: (context, index) {
              final doctor = doctors[index];

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                  ),
                  child: DoctorCardItem(
                    doctor: doctor,
                  ),
                ),
              );
            },
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
      ],
    );
  }
}

class _DoctorArchiveError extends StatelessWidget {
  const _DoctorArchiveError({
    required this.message,
    required this.maxWidth,
  });

  final String message;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: errorFullScreen(
          context,
          mes: message,
          func: () {},
        ),
      ),
    );
  }
}

class _DoctorArchiveEmpty extends StatelessWidget {
  const _DoctorArchiveEmpty({
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: emptyFullScreen(context),
      ),
    );
  }
}

class _DoctorArchiveLoading extends StatelessWidget {
  const _DoctorArchiveLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}