import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/Recipes/pages/update_recipes.dart';
import 'package:domina_app/presentation/Recipes/pages/update_recipes_hospital.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllRecip extends StatelessWidget {
  AllRecip({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      BlocProvider.of<RecipesBrandBloc>(context).add(AllReciEvent());
    });
    return Scaffold(
      appBar:AppBar(
          title: Text("سجل الوصفات", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
      buildWhen: (previous, current) =>
      current is AllReciLoadingState ||
          current is AllReciState ||
          current is AllReciErrorState ||
          current is AllReciEmptyState,
      builder: (context, state) {
        if (state is AllReciLoadingState) return loadingFullScreen(context);
        if (state is AllReciEmptyState) return emptyFullScreen(context);
        if (state is AllReciErrorState) return errorFullScreen(context, mes: state.failure.massage, func: () {});

        if (state is AllReciState) {
          List<ReciModel> recis = state.reci;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 2. عنوان القائمة (قائمة الوصفات) كما في الصورة
              SliverToBoxAdapter(child: _buildTitleSection(context)),

              // 3. البطاقات الذكية مع تأثير الدخول المتتالي
              SliverPadding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                sliver: AnimationLimiter(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final item = recis[index];
                        bool isClinic = item.recipeType == "1";

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 50),
                          child: SlideAnimation(
                            verticalOffset: 30.0,
                            child: FadeInAnimation(
                              child: _buildSmartCard(context, item, isClinic),
                            ),
                          ),
                        );
                      },
                      childCount: recis.length,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }


  Widget _buildTitleSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("قائمة الوصفات",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: ColorManager.medicalText)),
              const SizedBox(height: 4),
              Text("استعراض كافة الوصفات الصادرة لهذا المندوب",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
          // الخط الأزرق الجمالي الموجود في الصورة
          Container(
            height: 5, width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSmartCard(BuildContext context, ReciModel item, bool isClinic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ColorManager.black.withOpacity(0.09), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: () {
            initBrandRecModule();
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => isClinic
                    ? UpdateRecipesPage(recipeId: int.parse(item.id ?? "0"), docId: int.parse(item.docId), st: 1)
                    : UpdateRecipesHospital(recipeId: int.parse(item.id ?? "0"), HospitalId: int.parse(item.docId), st: 1)
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. الوسوم (Badge & Date)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTypeBadge(isClinic),
                    _buildDateSection(item.create_date ?? ""),
                  ],
                ),
                const SizedBox(height: 15),
                // 3. المصدر (طبيب أو مشفى)
                Row(
                  children: [
                    Icon(isClinic ? Icons.person_outline : Icons.apartment_outlined,
                        size: 18, color: Colors.grey.shade400),
                    const SizedBox(width: 8),
                    Text(isClinic ? "د. ${item.docName}" : item.docName ?? "",
                        style: TextStyle(fontSize: 15, color: Colors.blueGrey.shade600, fontWeight: FontWeight.w600)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 1, thickness: 0.3,color: ColorManager.medicalPrimary.withOpacity(0.5),),
                ),

                // 4. السطر السفلي (الملاحظات والكمية)
                Row(
                  children: [
                    Expanded(
                      child: Text("ملاحظات مدونة : ${item.note_emp?? "لا توجد ملاحظات مدونة"}" ,

                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontStyle: FontStyle.italic)),
                    ),
                    const SizedBox(width: 8),
                    const Text("وحدة", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 8),
                    _buildQuantityBubble(item.total ?? "0"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBadge(bool isClinic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isClinic ? const Color(0xFFE3F2FD) : const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isClinic ? "وصفة عيادة" : "وصفة مشفى",
        style: TextStyle(
          color: isClinic ? Colors.blue.shade700 : Colors.green.shade700,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDateSection(String date) {
    return Row(
      children: [
        Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 6),
        Text(date, style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildQuantityBubble(String quantity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: ColorManager.medicalPrimary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: ColorManager.primary.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))
        ],
      ),
      child: Text(quantity,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}