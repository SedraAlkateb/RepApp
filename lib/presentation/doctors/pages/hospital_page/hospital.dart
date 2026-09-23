import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/doctors/widget/hospital_card.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hospital extends StatefulWidget {
  const Hospital({
    super.key,
  });

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  final TextEditingController searchHosController = TextEditingController();

  @override
  void dispose() {
    searchHosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),
      body: BlocBuilder<DoctorsBloc, DoctorsState>(
        // =====================================================
        // نفس buildWhen الأصلي
        // =====================================================
        buildWhen: (previous, current) =>
            current is AllHospitalsState ||
            current is AllHospitalEmptyState ||
            current is AllHospitalErrorState ||
            current is AllHospitalLoadingState,

        builder: (context, state) {
          // =====================================================
          // نفس مصدر البيانات الأصلي
          // =====================================================
          List<HospitalSpAllModel> hospitalModel =
              BlocProvider.of<DoctorsBloc>(context).hospital;

          if (state is AllHospitalsState) {
            hospitalModel = state.hospital;
          }

          final Map<int, List<HospitalSpAllModel>> groupedByHospitalId = {};
          for (final hospital in hospitalModel) {
            groupedByHospitalId
                .putIfAbsent(hospital.hospitalId, () => [])
                .add(hospital);
          }
          final List<List<HospitalSpAllModel>> hospitalGroups =
              groupedByHospitalId.values.toList();

          // ملاحظة: بدون ConstrainedBox خارجي حول الـ CustomScrollView، حتى
          // يضل السكرول بالماوس يشتغل فوق الفراغ الجانبي بالعرض؛ قيد
          // pageMaxWidth يُطبَّق داخلياً على كل sliver لحاله.
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              // =================================================
              // Search Header
              // =================================================
              _buildSearchHeader(
                context,
                ui,
                count: hospitalGroups.length,
              ),

              // =================================================
              // Loading
              // =================================================
              if (state is AllHospitalLoadingState)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: loadingFullScreen(
                      context,
                    ),
                  ),
                )

              // =================================================
              // Error
              // =================================================
              else if (state is AllHospitalErrorState)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: errorFullScreen(
                      context,
                    ),
                  ),
                )

              // =================================================
              // Empty
              // =================================================
              else if (state is AllHospitalEmptyState || hospitalGroups.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: emptyFullScreen(
                      context,
                    ),
                  ),
                )

              // =================================================
              // Hospitals List
              // =================================================
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.searchTopPadding,
                    ui.pagePadding,
                    ui.searchBottomPadding,
                  ),
                  sliver: SliverList.builder(
                    itemCount: hospitalGroups.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: ui.cardSpacing,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: ui.pageMaxWidth,
                            ),
                            child: HospitalCardItem(
                              hospitalGroup: hospitalGroups[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================
  // Search Header
  // ===========================================================

  Widget _buildSearchHeader(
    BuildContext context,
    AppUi ui, {
    int count = 0,
  }) {
    return SliverToBoxAdapter(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ui.pageMaxWidth),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              ui.pagePadding,
              ui.searchTopPadding,
              ui.pagePadding,
              ui.searchBottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =================================================
                // Search
                // =================================================
                SearchField(
                  searchController: searchHosController,
                  onPressed: (value) {
                    // =============================================
                    // نفس Event البحث الأصلي تماماً
                    // =============================================
                    context.read<DoctorsBloc>().add(
                          SearchhosEvent(
                            value,
                          ),
                        );
                  },
                ),

                SizedBox(
                  height: ui.sectionSpacing,
                ),

                // =================================================
                // Header
                // =================================================
                if (count > 0)
                  buildTotalReportsCard(
                    count,
                    'قائمة المشافي المسجلة',
                    'لهذا الشهر',
                  )
                else
                  SizedBox(
                    height: ui.smallSpacing,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Section Header
  // ===========================================================
}
