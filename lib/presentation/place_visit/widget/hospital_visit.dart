// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/widget/hospital_recipe.dart';
import 'package:domina_app/presentation/place_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/place_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalVisit extends StatefulWidget {
  const HospitalVisit({
    super.key,
    required this.placeId,
  });

  // HospitalSpAllModel ما بيحمل placeId أصلاً (الاستعلام ما بيرجعه)، فـ
  // HospitalModel.toDomain() كانت دايماً تحط -1 مكانه. هيك صفحة الزيارة
  // كانت ترجّع تحديث بعد الحفظ لمكان غلط (placeId = -1) فما كان التعديل
  // يظهر أبداً بقائمة الزيارات. منمرّره هون من نفس مصدره الصحيح (الصفحة
  // الأم) ونصحّح فيه الموديل قبل ما ننتقل لصفحة الزيارة.
  final int placeId;

  @override
  State<HospitalVisit> createState() => _HospitalVisitState();
}

class _HospitalVisitState extends State<HospitalVisit>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),
      body: Column(
        children: [
          // =====================================================
          // Search
          // دائماً ظاهر حتى لو ما في نتائج
          // =====================================================
          Padding(
            padding: EdgeInsets.fromLTRB(
              ui.pagePadding,
              ui.searchTopPadding,
              ui.pagePadding,
              ui.searchBottomPadding,
            ),
            child: SearchField(
              searchController: searchController,
              onPressed: (value) {
                // =================================================
                // نفس سلوك البحث الأصلي
                // =================================================
                context.read<VisitPlaceBloc>().add(
                      SearchHospitalVisitEvent(
                        value: value,
                      ),
                    );
              },
            ),
          ),

          // =====================================================
          // Content
          // =====================================================
          Expanded(
            child: BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
              // =================================================
              // نفس Listener الأصلي
              // =================================================
              listener: (
                context,
                state,
              ) {
                if (state is AllHospitalByPlaceErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      error(
                        context,
                        state.failure.massage,
                        state.failure.code,
                      );
                    },
                  );
                }
              },

              // =================================================
              // نفس الحالات الأصلية
              // =================================================
              buildWhen: (
                previous,
                current,
              ) =>
                  current is EmptyState ||
                  current is SearchVisitHospitalState ||
                  current is AllHospitalByPlaceState,

              builder: (
                context,
                state,
              ) {
                List<HospitalSpAllModel> hospitals =
                    context.watch<VisitPlaceBloc>().hospitals;

                // ===============================================
                // Search Result
                // ===============================================
                if (state is SearchVisitHospitalState) {
                  hospitals = state.hospitalVisit;
                }

                // ===============================================
                // All Hospitals
                // ===============================================
                if (state is AllHospitalByPlaceState) {
                  hospitals = state.data;
                }

                // ===============================================
                // Empty
                //
                // السيرش بيضل ظاهر لأنه خارج الـ Expanded
                // ===============================================
                if (state is EmptyState || hospitals.isEmpty) {
                  return emptyFullScreen(
                    context,
                  );
                }

                // ===============================================
                // Hospitals List
                //
                // hospitals قائمة أزواج (مشفى + اختصاص)، فنجمّعها هون
                // حسب hospitalId فقط للعرض حتى ما يتكرر اسم المشفى
                // ===============================================
                final groupedHospitals = _groupByHospital(hospitals);

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.listTopPadding,
                    ui.pagePadding,
                    ui.listBottomPadding,
                  ),
                  itemCount: groupedHospitals.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final group = groupedHospitals[index];

                    return _HospitalVisitCard(
                      group: group,
                      ui: ui,
                      onVisit: (hospital) {
                        // =========================================
                        // نفس Navigation الأصلي + تصحيح placeId
                        // (كانت -1 دايماً، فتحديث القائمة بعد الزيارة
                        // كان يروح لمكان غلط ولا يظهر أثره)
                        // =========================================
                        final hospitalModel = hospital.toDomain()
                          ..placeId = widget.placeId;

                        Navigator.pushNamed(
                          context,
                          Routes.visitHospital,
                          arguments: hospitalModel,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ============================================================================
// Grouping helper
//
// hospitals قائمة أزواج (مشفى + اختصاص) قادمة من الـ BLoC كما هي، ولا نغيّرها؛
// هون بس نجمّعها حسب hospitalId للعرض فقط، فيضل ترتيب أول ظهور لكل مشفى.
// ============================================================================
List<List<HospitalSpAllModel>> _groupByHospital(
  List<HospitalSpAllModel> hospitals,
) {
  final Map<int, List<HospitalSpAllModel>> byId = {};
  final List<int> order = [];

  for (final h in hospitals) {
    if (!byId.containsKey(h.hospitalId)) {
      byId[h.hospitalId] = [];
      order.add(h.hospitalId);
    }
    byId[h.hospitalId]!.add(h);
  }

  return order.map((id) => byId[id]!).toList();
}

// ============================================================================
// Hospital Visit Card
// ============================================================================

class _HospitalVisitCard extends StatelessWidget {
  const _HospitalVisitCard({
    required this.group,
    required this.ui,
    required this.onVisit,
  });

  final List<HospitalSpAllModel> group;
  final AppUi ui;
  final ValueChanged<HospitalSpAllModel> onVisit;

  // نفس المشفى بكل صفوفه، نأخذ البيانات المشتركة (الاسم/العنوان) من أول صف
  HospitalSpAllModel get hospital => group.first;

  int get _totalVisited =>
      group.fold(0, (sum, h) => sum + (h.visited ?? 0));

  int get _totalVisit => group.fold(0, (sum, h) => sum + h.visit);

  // اختيار الاختصاص فعلياً بيصير داخل صفحة "إجراء زيارة" نفسها
  // (فيها dropdown خاص يجيب كل اختصاصات المشفى عبر hospitalId)، فما في
  // داعي نسأل هون قبل الانتقال. أي عنصر من المجموعة يكفي لأنه كل الحقول
  // المشتركة (hospitalId, title, address...) نفسها بكل صفوف نفس المشفى.
  void _handleVisitTap(BuildContext context) {
    onVisit(group.first);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ui.cardSpacing,
      ),
      padding: EdgeInsets.all(
        ui.cardPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),
        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // Hospital Header
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ui.iconBoxSize,
                height: ui.iconBoxSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.medicalPrimary.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                ),
                child: Icon(
                  Icons.local_hospital_outlined,
                  size: ui.iconSize,
                  color: ColorManager.medicalPrimary,
                ),
              ),
              SizedBox(
                width: ui.mediumSpacing,
              ),
              Expanded(
                child: Text(
                  hospital.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ui.cardTitleSize,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.medicalPrimary,
                    height: 1.3,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ui.mediumSpacing,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.medicalPrimary.withOpacity(
                    0.08,
                  ),
                  borderRadius: BorderRadius.circular(
                    ui.smallRadius,
                  ),
                ),
                child: Text(
                  // اختصاص واحد: نعرضه بالاسم كما كان سابقاً
                  // أكثر من اختصاص: نعرض العدد فقط، والاختيار يصير عند الضغط على "بدء زيارة"
                  group.length == 1
                      ? (hospital.titleSp ?? '')
                      : '${group.length} اختصاصات',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorManager.medicalPrimary,
                    fontSize: ui.smallTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Visit Counter Badge (الشكل الجديد التجاوبي)
          // =====================================================
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ui.mediumSpacing,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(ui.smallRadius),
              border: Border.all(
                color: const Color(0xFFCBD5E1),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assignment_turned_in_outlined,
                  size: ui.smallIconSize,
                  color: ColorManager.medicalPrimary,
                ),
                SizedBox(width: ui.smallSpacing),
                Text(
                  'عدد الزيارات: ',
                  style: TextStyle(
                    fontSize: ui.bodyTextSize,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF475569),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$_totalVisited',
                        style: TextStyle(
                          fontSize: ui.bodyTextSize,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.medicalPrimary,
                        ),
                      ),
                      TextSpan(
                        text: ' / $_totalVisit',
                        style: TextStyle(
                          fontSize: ui.bodyTextSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Address
          // =====================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: ui.mediumSpacing,
              vertical: ui.isMobile ? 10 : 11,
            ),
            decoration: BoxDecoration(
              color: const Color(
                0xFFF8FAFC,
              ),
              borderRadius: BorderRadius.circular(
                ui.smallRadius + 1,
              ),
              border: Border.all(
                color: const Color(
                  0xFFE2E8F0,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: ui.smallIconSize + 1,
                  color: const Color(
                    0xFF94A3B8,
                  ),
                ),
                SizedBox(
                  width: ui.smallSpacing,
                ),
                Expanded(
                  child: Text(
                    _addressText(
                      hospital.address,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(
                        0xFF64748B,
                      ),
                      fontSize: ui.bodyTextSize,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          const Divider(
            height: 1,
            thickness: 0.6,
            color: Color(
              0xFFE2E8F0,
            ),
          ),

          SizedBox(
            height: ui.sectionSpacing,
          ),

          // =====================================================
          // Actions
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // =================================================
              // Prescription
              // =================================================
              PrescriptionHospitalMenuWidget(
                hospitalId: hospital.id ?? hospital.hospitalId,
              ),

              SizedBox(
                width: ui.mediumSpacing,
              ),

              const Spacer(),

              // =================================================
              // Start Visit
              // =================================================
              AppInkWell(
                borderRadius: BorderRadius.circular(
                  ui.smallRadius,
                ),
                onTap: () => _handleVisitTap(context),
                child: buildCardButton(
                  context,
                  'بدء زيارة',
                  ColorManager.medicalPrimary,
                  Colors.white,
                  Icons.directions_run,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _addressText(
      String? address,
      ) {
    if (address == null || address.trim().isEmpty) {
      return 'العنوان غير محدد';
    }

    return address;
  }
}
