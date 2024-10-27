import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/CustomDropDownSearch.dart';
import 'package:domina_app/presentation/uniti/box_text_field.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/dialog_wid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalOrder extends StatelessWidget {
  const PersonalOrder({super.key, required this.noteeController});
  final TextEditingController noteeController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "طلبات شخصية:",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(
          height: AppSize.s8,
        ),
        CustomDropDown(
          hintText: "نوع الطلب",
          items: type,
          prefixIcon: null,
          onChanged: (value) {
            noteeController.text = "";
            BlocProvider.of<VisitPlaceBloc>(context)
                .add(TypeAdditionEvent(value));
          },
          validator: (value) {
            // if (value == null ) {
            //   return "اختر نوع الطلب";
            // }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p12),
          child: BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
            buildWhen: (previous, current) {
              return current is BoxState || current is DropDownState;
            },
            builder: (context, state) {
              if (state is BoxState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اكتب ملاحظاتك:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    BoxTextField(
                      keyboardType: TextInputType.text,
                      prefixIcon: null,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الحقل مطلوب";
                        }
                        return null;
                      },
                      controller: noteeController,
                      obscureText: false,
                      minLines: 3,
                      inputFormatters: [],
                    ),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor2,
                                  value: context
                                              .read<VisitPlaceBloc>()
                                              .isScience ==
                                          0
                                      ? true
                                      : false,
                                  splashRadius: 30,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(0));
                                  },
                                ),
                                Text('مكتب علمي'),
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor2,
                                  value: context
                                              .read<VisitPlaceBloc>()
                                              .isScience ==
                                          1
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(1));
                                  },
                                ),
                                Text('مع الخطة'),
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor2,
                                  value: context
                                              .read<VisitPlaceBloc>()
                                              .isScience ==
                                          2
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(2));
                                  },
                                ),
                                Text('مع الموزع'),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }
              if (state is DropDownState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اختر عينات: ",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    CustomDropDownSearch(
                      hintText: "العينات",
                      items: context.watch<VisitPlaceBloc>().bandFlag,
                      onChanged: (value) {
                        BrandModel brand = value;
                        BlocProvider.of<VisitPlaceBloc>(context).add(
                            SelectBrandAddEvent(
                                "${noteeController.text}  ${brand.title} ${brand.phTitle}"));
                      },
                      validator: (value) {
                        if (value == null) {
                          return "اختر العينات";
                        }
                        return null;
                      },
                      errorText: 'لايوجد نتيجة',
                    ),
                    BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
                      buildWhen: (previous, current) {
                        return current is SelectBrandAddState ||
                            current is SelectBrandAddNumState;
                      },
                      listener: (context, state) {
                        if (state is SelectBrandAddState) {
                          noteeController.text = state.brands;
                          showDialog(
                              context: context,
                              builder: (context) => DialogFilter(
                                    text: "اختر عدد العينات",
                                    noteText: noteeController.text,
                                  ));
                        }
                      },
                      builder: (context, state) {
                        if (state is SelectBrandAddNumState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            noteeController.text = state.brands;                          });
                        }
                        if (state is SelectBrandAddState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            noteeController.text = state.brands;
                          });
                        }
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: AppPadding.p12),
                          child: BoxTextField(
                            keyboardType: TextInputType.text,
                            prefixIcon: null,
                            maxLines: 5,
                            enabled: true,
                            minLines: 3,
                            validator: (value) {
                              if (value == null) {
                                return "اختر العينات";
                              }
                              return null;
                            },
                            controller: noteeController,
                            obscureText: false,
                            inputFormatters: [],
                          ),
                        );
                      },
                    ),
                    BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor2,
                                  value: context
                                              .read<VisitPlaceBloc>()
                                              .isScience ==
                                          0
                                      ? true
                                      : false,
                                  splashRadius: 30,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(0));
                                  },
                                ),
                                Text('مكتب علمي'),
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor2,
                                  value: context
                                              .read<VisitPlaceBloc>()
                                              .isScience ==
                                          1
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(1));
                                  },
                                ),
                                Text('مع الخطة'),
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  focusColor: ColorManager.secondaryColor,
                                  activeColor: ColorManager.secondaryColor2,
                                  value: context
                                              .read<VisitPlaceBloc>()
                                              .isScience ==
                                          2
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    BlocProvider.of<VisitPlaceBloc>(context)
                                        .add(IsScienceEvent(2));
                                  },
                                ),
                                Text('مع الموزع'),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
