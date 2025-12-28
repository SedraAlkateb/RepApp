import 'package:domina_app/app/constants.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewRecipePage extends StatelessWidget {
  const ViewRecipePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          },
          iconSize: 30,
          padding: const EdgeInsets.only(right: 15),
          icon: Icon(Icons.arrow_back_sharp, color: ColorManager.white),
        ),
        title:  Text('تفاصيل الوصفة',style: TextStyle(
          color: ColorManager.white
        ),),
        backgroundColor: ColorManager.secondaryColor7, // Background color matching branding
      ),
      body: BlocBuilder<SeniorProfBloc, SeniorProfState>(
        builder: (context, state) {
          if (state is ViewRecipeLoadingState) {
            return loadingFullScreen(context);
          }

          if (state is ViewRecipeErrorState) {
            return Center(child: errorFullScreen(context));
          }

          if (state is ViewRecipeState) {
            final bool isDoctor = state.isDoctor;
            final recipe = state.copyRecipeRequest;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    _buildCardContent( state.name),

                    const SizedBox(height: 20),
                    _buildRecipeDetail(isDoctor ? 'اختصاص الطبيب' : 'الإختصاص'
                        , recipe.spName),
                    _buildRecipeDetail('المستحضر الأول', recipe.brand_1.title_en),
                    _buildRecipeDetail('المستحضر الثاني', recipe.brand_2?.title_en),
                    _buildRecipeDetail('المستحضر الثالث', recipe.brand_3?.title_en),
                    _buildRecipeDetail('المستحضر الرابع', recipe.brand_4?.title_en),

                    const SizedBox(height: 15),
                    _buildRecipeDetail('الملاحظة الأولى', recipe.note1 ?? "يرجى عدم تبديل الدواء"),
                    _buildRecipeDetail('الملاحظة الثانية', recipe.note2 ?? ""),
                    _buildRecipeDetail('العنوان', recipe.address),
                    _buildRecipeDetail('التواصل', recipe.phone),
                    _buildRecipeDetail('عدد الوصفات المطبوعة', recipe.total),
                    _buildRecipeDetail('ملاحظات خاصة للمندوب', recipe.note_emp ?? ""),

                    Divider(color: ColorManager.secondaryColor,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (recipe.image1 != null && recipe.image1!.isNotEmpty)
                            _buildRecipeImage("صورة الوصفة 1 ", recipe.image1),

                          if (recipe.image2 != null && recipe.image2!.isNotEmpty)
                            _buildRecipeImage("صورة الوصفة 2", recipe.image2),
                        ],),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            );
          }

          return Container(); // Default return case
        },
      ),
    );
  }


  Widget _buildCardContent(String? content) {
    return Card(

      color: ColorManager.secondaryColor1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Increased border radius for a softer look
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content ?? 'غير متوفر', // Default text when content is null
          style: TextStyle(
            fontSize: 18, // Slightly increased font size for better readability
            fontWeight: FontWeight.w600, // Make text a bit bolder for emphasis
            color: ColorManager.white, // Text color remains white
          ),
          textAlign: TextAlign.center, // Align text to the center for a cleaner look
        ),
      ),
    );
  }

  Widget _buildRecipeDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12), // زيادة المسافة بين العناصر
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // العنوان مع بعض التنسيق
          Text(
            label,

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600, // زيادة الوزن لزيادة وضوح العنوان
              color: ColorManager.secondaryColor1,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2), // إزاحة الظل
                  ),
                ],
              ),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    value ?? 'غير متوفر',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorManager.secondaryColor,
                      fontWeight: FontWeight.w500, // جعل النص أقل وزنًا
                    ),
                    overflow: TextOverflow.ellipsis, // إذا كان النص طويلًا
                    maxLines: 2, // تحديد عدد الأسطر
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildRecipeImage(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12), // زيادة المسافة بين العناصر
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // العنوان مع بعض التنسيق
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.network("${Constants.imageUrl}${value}", height: 200, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Text(
            label,

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600, // زيادة الوزن لزيادة وضوح العنوان
              color: ColorManager.secondaryColor1,
            ),
          ),
        ],
      ),
    );
  }

}
