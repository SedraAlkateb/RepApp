// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanOtherPage extends StatefulWidget {
  final OtherBrandSpPlanModel otherBrandSpPlanModel;
  final int index1;

  const BrandPlanOtherPage({
    super.key,
    required this.otherBrandSpPlanModel,
    required this.index1
  });

  @override
  State<BrandPlanOtherPage> createState() => _BrandPlanOtherPageState();
}

class _BrandPlanOtherPageState extends State<BrandPlanOtherPage>
    with AutomaticKeepAliveClientMixin {
  int summ = 0;
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (var brand in widget.otherBrandSpPlanModel.brands) {
      summ += brand.amount;
      _controllers.add(TextEditingController(
          text: brand.amount == 0 ? "" : brand.amount.toString()));
    }
    BlocProvider.of<BrandPlanBloc>(context).sumS = summ;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: true, // السماح للكيبورد بالارتفاع بسلاسة
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget.otherBrandSpPlanModel.specModel.title)),
      backgroundColor: ColorManager.white,
      body: BlocConsumer<BrandPlanBloc, BrandPlanState>(
        // 🚀 الاستماع لحالة الخطأ المخصصة لعرض الدايالوج هنا بشكل مستقر
        listenWhen: (previous, current) => current is SumErrorState,
        listener: (context, state) {
          if (state is SumErrorState) {
            error(
                context, state.failure.massage, state.failure.code);
            BlocProvider.of<BrandPlanBloc>(context)
                .add(UpdateEvent());
          }
        },
        // ⚡ منع إعادة بناء القائمة كلياً أثناء الكتابة لإنهاء التعليق نهائياً
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: widget.otherBrandSpPlanModel.brands.length,
            itemBuilder: (context, index) {
              final brandItem = widget.otherBrandSpPlanModel.brands[index];
              return Container(
                margin: EdgeInsets.all(AppPaddingH.p8),
                padding: EdgeInsets.all(AppPaddingH.p16),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: ColorManager.secondaryColor.withOpacity(0.05), blurRadius: 4)],
                  color: ColorManager.white,
                  border: Border.all(color: ColorManager.secondaryColor7),
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medication_outlined, color: ColorManager.secondaryColor4),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "العينة : ${brandItem.title}",
                            style: Theme.of(context).textTheme.headlineMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: AppPaddingH.p8, horizontal: AppPaddingW.p14),
                          decoration: BoxDecoration(
                            color: brandItem.brandType.color,
                            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                          ),
                          child: Text(
                            brandItem.brandType.name,
                            style: TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Divider(color: ColorManager.secondaryColor7),
                    Row(
                      children: [
                        Icon(Icons.medical_information_outlined, color: ColorManager.secondaryColor4),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "النوع : ${brandItem.phTitle}",
                            style: Theme.of(context).textTheme.headlineMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: ColorManager.secondaryColor7),
                    Row(
                      children: [
                        Text('العدد ', style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            ),
                            enabled: UserInfo.otherstatus == 0,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final cleanValue = value.trim();
                              final parsedNumber = cleanValue.isEmpty
                                  ? 0
                                  : int.tryParse(convertArabicNumberToEnglish(cleanValue)) ?? 0;

                              BlocProvider.of<BrandPlanBloc>(context).add(
                                ChangeFieldEvent(
                                  parsedNumber,
                                  widget.index1,
                                  index,
                                  widget.otherBrandSpPlanModel.brandm,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}