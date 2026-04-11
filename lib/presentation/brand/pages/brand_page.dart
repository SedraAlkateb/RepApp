import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandPage extends StatelessWidget {
  BrandPage({super.key});
  final TextEditingController searchbrandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' الأصناف'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h,),
              SearchField(
                  searchController: searchbrandController,
                  onPressed: (value) {
                    BlocProvider.of<BrandBloc>(context)
                        .add(SearchbradEvent(value));
                  }),
              SizedBox(height: 12.h,),
              Expanded(
                child: BlocConsumer<BrandBloc, BrandState>(
                  listener: (context, state) {
                    if (state is AllBrandErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        error(
                            context, state.failure.massage, state.failure.code);
                      });
                    }
                    /*
                  if(state is AllBrandLoadingState){
                    loading(context);
                  }
                  if(state is AllBrandState){
    success(context);}

                   */
                },
  builder: (context, state) {
    if(state is AllBrandState){
      List<BrandModel> brandModel=state.brand;
      return ListView.builder
        (
          padding: EdgeInsets.symmetric(horizontal: 16.w),

          itemBuilder: (context, index)
          {
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.medication_outlined, // أيقونة مشابهة لتصميمك
                      color: const Color(0xFF4CAF50),
                      size: 26.sp,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child:Text(
                      brandModel[index].title,
                      style: TextStyle(
                        color: ColorManager.medicalPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,

                      ),
                    ),
                  ),

                  // التصنيف (كريم) في الجهة اليسرى
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      " ${brandModel[index].phTitle}",
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    ),
                  ),

                  // النصوص الوسطى (الاسم والنوع)



                  // أيقونة الدواء في الجهة اليمنى بخلفية خضراء فاتحة

                ],
              ),
            );
          },
          itemCount: brandModel.length);
    }

                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
