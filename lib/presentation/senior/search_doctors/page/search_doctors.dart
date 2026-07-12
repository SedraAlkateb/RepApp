import 'package:domina_app/presentation/doctors/widget/doctor_widget.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_details.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/search_do_hos_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({
    super.key,
  });

  @override
  State<SearchDoctors> createState() => _SearchDoctorsState();
}

class _SearchDoctorsState extends State<SearchDoctors>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // القسم العلوي الثابت للبحث
          buildHeaderSection(searchController, context),

          // تمديد المساحة المتبقية لتأخذها القائمة الذكية
          Expanded(
            child: BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
              buildWhen: (previous, current) =>
              current is FutureSearchDoctorsErrorState ||
                  current is FutureSearchDoctorsLoadingState ||
                  current is FutureSearchDoctorsState ||
                  current is FutureSearchDoctorsEmptyState,
              builder: (context, state) {

                // 1. حالة الخطأ: تم تغليفها بـ SliverToBoxAdapter لتتوافق مع CustomScrollView
                if (state is FutureSearchDoctorsErrorState) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: errorFullScreen(context, func: () {
                          BlocProvider.of<SearchDoctorsBloc>(context)
                              .add(FutureSearchDocEvent(searchController.text));
                        }, mes: state.failure.massage),
                      ),
                    ],
                  );
                }

                // 2. حالة التحميل: تم تغليفها بـ SliverToBoxAdapter
                if (state is FutureSearchDoctorsLoadingState) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: loadingShimmer(
                          context,
                          20,
                          100,
                          100,
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                      ),
                    ],
                  );
                }

                // 3. حالة البيانات الفارغة: تم تغليفها بـ SliverToBoxAdapter
                if (state is FutureSearchDoctorsEmptyState) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: emptyFullScreen(context),
                      ),
                    ],
                  );
                }

                // 4. حالة نجاح جلب البيانات وعرضها تدريجياً بكفاءة عالية
                if (state is FutureSearchDoctorsState) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(), // تمرير مرن وسلس
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              // يتم رندرة الطبيب فقط عندما يقترب من الظهور على الشاشة
                              return doctorWidget(
                                text: "عرض التقارير",
                                spTitle: state.representative[index].spTitle,
                                title: state.representative[index].name,
                                placeTitle: state.representative[index].placeTitle,
                                id: state.representative[index].id,
                                context: context,
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorDetails(
                                        doctorModel: state.representative[index],
                                      ),
                                    ),
                                  );
                                  BlocProvider.of<SearchDoctorsBloc>(context)
                                      .add(FutureDocDoctorsEvent(state.representative[index].id));
                                },
                              );
                            },
                            // تحديد العدد الإجمالي لعناصر الداتا الكبيرة
                            childCount: state.representative.length,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // الحالة الافتراضية
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: emptyFullScreen(context),
                    ),
                  ],
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