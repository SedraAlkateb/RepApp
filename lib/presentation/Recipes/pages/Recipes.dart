import 'dart:io';

import 'package:domina_app/app/constants.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/Recipes/widget/drop_down_num.dart';
import 'package:domina_app/presentation/Recipes/widget/drop_down_recipes.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({
    super.key,
    required this.docId,
    required this.st,
  });

  final int docId;
  final int st;

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final TextEditingController _doctorSpController =
  TextEditingController();

  final TextEditingController firstNoteController =
  TextEditingController(
    text: 'يرجى عدم تبديل الدواء',
  );

  final TextEditingController _secondNoteController =
  TextEditingController();

  final TextEditingController _addressController =
  TextEditingController();

  final TextEditingController _connectController =
  TextEditingController();

  final TextEditingController _specialNotesController =
  TextEditingController();

  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // =========================================================
    // نفس التسلسل والمنطق الأصلي
    // =========================================================
    context
        .read<RecipesBrandBloc>()
        .add(
      RestartEvent(),
    );

    context
        .read<RecipesBrandBloc>()
        .empty();

    if (widget.st == 1) {
      context
          .read<RecipesBrandBloc>()
          .add(
        CopyRecipesEvent(
          widget.docId,
          1,
        ),
      );

      context
          .read<RecipesBrandBloc>()
          .isChecked2 = 3;

      context
          .read<RecipesBrandBloc>()
          .isChecked1 = 3;
    }
  }

  @override
  void dispose() {
    _doctorSpController.dispose();
    firstNoteController.dispose();
    _secondNoteController.dispose();
    _addressController.dispose();
    _connectController.dispose();
    _specialNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,

        leading: IconButton(
          tooltip: 'رجوع',
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorManager.medicalPrimary,
          ),
        ),

        title: Text(
          'تفاصيل الوصفة',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ColorManager.medicalPrimary,
            fontSize: ui.isMobile ? 18 : 21,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: BlocBuilder<
          RecipesBrandBloc,
          RecipesBrandState>(
        builder: (context, state) {
          // =====================================================
          // Loading
          // =====================================================
          if (state
          is RecipesRecipesLoadingState) {
            return loadingFullScreen(
              context,
            );
          }

          // =====================================================
          // Copy recipe error
          // نفس السلوك الأصلي
          // =====================================================
          if (state
          is RecipesRecipesErrorState &&
              widget.st == 1) {
            return Center(
              child: emptyFullScreen(
                context,
                message:
                'لم يتم ادخال وصفات لهذا الطبيب من قبل',
              ),
            );
          }

          // =====================================================
          // Populate copied recipe
          // نفس البيانات الأصلية
          // =====================================================
          if (state
          is RecipesRecipesState) {
            final recipeObject = context
                .read<RecipesBrandBloc>()
                .insertRecipesObject;

            _doctorSpController.text =
                recipeObject.spName;

            firstNoteController.text =
                recipeObject.note1 ?? '';

            _secondNoteController.text =
                recipeObject.note2 ?? '';

            _addressController.text =
                recipeObject.address;

            _connectController.text =
                recipeObject.phone;

            _specialNotesController.text =
                recipeObject.note_emp ?? '';
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: contentMaxWidth,
              ),

              child: SingleChildScrollView(
                physics:
                const BouncingScrollPhysics(),

                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                padding: EdgeInsets.fromLTRB(
                  ui.pagePadding,
                  ui.pageTopPadding,
                  ui.pagePadding,
                  ui.pageBottomPadding,
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                    children: [
                      // =================================================
                      // Doctor title type
                      // =================================================
                      _buildDoctorTypeSection(
                        context,
                        ui,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Doctor specialization
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'اختصاص الطبيب',
                      ),

                      BoxTextField(
                        inputFormatters: const [],
                        controller:
                        _doctorSpController,
                        keyboardType:
                        TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال اختصاص الطبيب';
                          }

                          return null;
                        },
                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                        prefixIcon: null,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 1
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الأول',
                      ),

                      _buildFirstBrandField(
                        context,
                        state,
                        ui,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 2
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الثاني',
                      ),

                      _buildOptionalBrandField(
                        context: context,
                        state: state,
                        index: 2,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 3
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الثالث',
                      ),

                      _buildOptionalBrandField(
                        context: context,
                        state: state,
                        index: 3,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 4
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الرابع',
                      ),

                      _buildOptionalBrandField(
                        context: context,
                        state: state,
                        index: 4,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Notes
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'الملاحظة الأولى',
                      ),

                      BoxTextField(
                        prefixIcon: null,
                        controller:
                        firstNoteController,
                        keyboardType:
                        TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال الملاحظة الأولى';
                          }

                          return null;
                        },
                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                        inputFormatters: const [],
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      _buildFieldLabel(
                        ui,
                        'الملاحظة الثانية',
                      ),

                      BoxTextField(
                        inputFormatters: const [],
                        controller:
                        _secondNoteController,
                        keyboardType:
                        TextInputType.text,
                        validator: (value) {
                          return null;
                        },
                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                        prefixIcon: null,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Address
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'العنوان',
                      ),

                      BoxTextField(
                        controller:
                        _addressController,
                        keyboardType:
                        TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال العنوان';
                          }

                          return null;
                        },
                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                        inputFormatters: const [],
                        prefixIcon: null,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Contact
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'التواصل',
                      ),

                      BoxTextField(
                        inputFormatters: const [],
                        prefixIcon: null,
                        controller:
                        _connectController,
                        keyboardType:
                        TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال رقم التواصل';
                          }

                          return null;
                        },
                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Printed recipe count
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'عدد الوصفات المطبوعة',
                      ),

                      _buildRecipeCountField(
                        context,
                        state,
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Employee notes
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'ملاحظات خاصة للمندوب',
                      ),

                      BoxTextField(
                        prefixIcon: null,
                        inputFormatters: const [],
                        controller:
                        _specialNotesController,
                        keyboardType:
                        TextInputType.text,
                        validator: (value) {
                          return null;
                        },
                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                      ),

                      SizedBox(
                        height: ui.largeSpacing,
                      ),

                      // =================================================
                      // Images
                      // =================================================
                      _buildImagesSection(
                        context,
                        ui,
                      ),

                      SizedBox(
                        height: ui.largeSpacing,
                      ),

                      // =================================================
                      // Submit
                      // =================================================
                      _buildSubmitSection(
                        context,
                        ui,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =============================================================
  // Doctor Type
  // =============================================================

  Widget _buildDoctorTypeSection(
      BuildContext context,
      AppUi ui,
      ) {
    final selectedType = context
        .watch<RecipesBrandBloc>()
        .insertRecipesObject
        .type;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment:
      WrapCrossAlignment.center,
      spacing: ui.mediumSpacing,
      runSpacing: ui.smallSpacing,

      children: [
        _buildTypeOption(
          context: context,
          ui: ui,
          value: '0',
          label: 'الدكتور',
          groupValue: selectedType,
        ),
        _buildTypeOption(
          context: context,
          ui: ui,
          value: '1',
          label: 'الدكتورة',
          groupValue: selectedType,
        ),

      ],
    );
  }

  Widget _buildTypeOption({
    required BuildContext context,
    required AppUi ui,
    required String value,
    required String label,
    required String groupValue,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          activeColor:
          ColorManager.secondaryColor2,
          value: value,
          groupValue: groupValue,
          onChanged: (newValue) {
            context
                .read<RecipesBrandBloc>()
                .add(
              SelectTypeEvent(
                newValue ?? '0',
              ),
            );
          },
        ),

        Text(
          label,
          style: TextStyle(
            fontSize: ui.isMobile ? 14 : 16,
            color: const Color(
              0xFF334155,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // =============================================================
  // Field Label
  // =============================================================

  Widget _buildFieldLabel(
      AppUi ui,
      String label,
      ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ui.smallSpacing,
        right: 2,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: ui.isMobile ? 14.5 : 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
            height: 1.3,
          ),
        ),
      ),
    );
  }

  // =============================================================
  // Brand Fields
  // =============================================================

  Widget _buildFirstBrandField(
      BuildContext context,
      RecipesBrandState parentState,
      AppUi ui,
      ) {
    return FormField<BrandRes>(
      validator: (value) {
        if (value == null) {
          return 'يرجى اختيار المستحضر الأول';
        }

        return null;
      },

      builder:
          (FormFieldState<BrandRes> formState) {
        final bloc =
        context.watch<RecipesBrandBloc>();

        return Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            DropDownRecipesSearch(
              brandRes:
              bloc.insertRecipesObject.brand_1,

              hintText: (parentState
              is AllRecipesLoadingState ||
                  parentState
                  is AllNumLoadingState)
                  ? 'loading'
                  : widget.st == 1
                  ? bloc
                  .insertRecipesObject
                  .brand_1
                  .title_en
                  : 'اختر المستحضر',

              items: bloc.brandRecs,

              onChanged: (value) {
                final BrandRes brand = value;

                formState.didChange(
                  brand,
                );

                context
                    .read<RecipesBrandBloc>()
                    .add(
                  SelectBrandEvent(
                    brandRecipeModel:
                    brand,
                    index: 1,
                  ),
                );
              },

              validator: (value) {
                return null;
              },
            ),

            if (formState.hasError)
              Padding(
                padding: EdgeInsets.only(
                  top: ui.smallSpacing,
                ),
                child: Text(
                  formState.errorText ?? '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize:
                    ui.smallTextSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildOptionalBrandField({
    required BuildContext context,
    required RecipesBrandState state,
    required int index,
  }) {
    final bloc =
    context.watch<RecipesBrandBloc>();

    BrandRes? brand;

    switch (index) {
      case 2:
        brand =
            bloc.insertRecipesObject.brand_2;
        break;
      case 3:
        brand =
            bloc.insertRecipesObject.brand_3;
        break;
      case 4:
        brand =
            bloc.insertRecipesObject.brand_4;
        break;
    }

    final String copiedTitle =
        brand?.title_en ?? '';

    return DropDownRecipesSearch(
      brandRes: brand,

      hintText:
      (state is AllRecipesLoadingState ||
          state is AllNumLoadingState)
          ? 'loading'
          : widget.st == 1
          ? copiedTitle
          : 'اختر المستحضر',

      items: bloc.brandRecs,

      onChanged: (value) {
        final BrandRes selectedBrand =
            value;

        context
            .read<RecipesBrandBloc>()
            .add(
          SelectBrandEvent(
            brandRecipeModel:
            selectedBrand,
            index: index,
          ),
        );
      },

      validator: (value) {
        return null;
      },
    );
  }

  // =============================================================
  // Recipe Count
  // =============================================================

  Widget _buildRecipeCountField(
      BuildContext context,
      RecipesBrandState state,
      ) {
    final bloc =
    context.watch<RecipesBrandBloc>();

    final bool isLoading =
        state is AllRecipesLoadingState ||
            state is AllNumLoadingState;

    return DropDownNum(
      hintText: isLoading
          ? 'جاري التحميل...'
          : widget.st == 1
          ? bloc.insertRecipesObject.total
          : 'اختر العدد',

      items: bloc.numRec,

      onChanged: (value) {
        context
            .read<RecipesBrandBloc>()
            .add(
          SelectNumRecEvent(
            num: value.toString(),
          ),
        );
      },

      validator: (value) {
        if (value == null &&
            context
                .read<RecipesBrandBloc>()
                .insertRecipesObject
                .total ==
                '') {
          return 'يرجى اختيار العدد';
        }

        return null;
      },

      prefixIcon: null,
    );
  }
  // =============================================================
  // Images
  // =============================================================

  Widget _buildImagesSection(
      BuildContext context,
      AppUi ui,
      ) {
    return BlocBuilder<
        RecipesBrandBloc,
        RecipesBrandState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (
              context,
              constraints,
              ) {
            final bool showSideBySide =
                ui.isTabletLandscape &&
                    constraints.maxWidth >= 650;

            final firstImage =
            _buildSingleImageSection(
              context: context,
              ui: ui,
              imageNumber: 1,
            );

            final secondImage =
            _buildSingleImageSection(
              context: context,
              ui: ui,
              imageNumber: 2,
            );

            if (showSideBySide) {
              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: firstImage,
                  ),

                  SizedBox(
                    width: ui.cardSpacing,
                  ),

                  Expanded(
                    child: secondImage,
                  ),
                ],
              );
            }

            return Column(
              children: [
                firstImage,

                SizedBox(
                  height: ui.cardSpacing,
                ),

                secondImage,
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSingleImageSection({
    required BuildContext context,
    required AppUi ui,
    required int imageNumber,
  }) {
    final bloc =
    context.watch<RecipesBrandBloc>();

    final File? image =
    imageNumber == 1
        ? bloc.insertRecipesObject.image1
        : bloc.insertRecipesObject.image2;

    final int checkedValue =
    imageNumber == 1
        ? bloc.isChecked1
        : bloc.isChecked2;

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(
          ui.cardRadius,
        ),
        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child: Column(
        children: [
          _buildImagePicker(
            context: context,
            ui: ui,
            imageNumber: imageNumber,
            image: image,
            checkedValue: checkedValue,
          ),

          SizedBox(
            height: ui.smallSpacing,
          ),

          Text(
            'صورة $imageNumber',
            style: TextStyle(
              color: const Color(
                0xFF64748B,
              ),
              fontSize:
              ui.bodyTextSize,
              fontWeight:
              FontWeight.w600,
            ),
          ),

          if (widget.st == 1) ...[
            SizedBox(
              height:
              ui.mediumSpacing,
            ),

            _buildImageOptions(
              context: context,
              ui: ui,
              imageNumber:
              imageNumber,
              checkedValue:
              checkedValue,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImagePicker({
    required BuildContext context,
    required AppUi ui,
    required int imageNumber,
    required File? image,
    required int checkedValue,
  }) {
    final double imageSize =
    ui.isMobile ? 135 : 155;

    return InkWell(
      borderRadius:
      BorderRadius.circular(
        ui.smallRadius + 2,
      ),

      onTap: () async {
        final File? pickedImage =
        await context
            .read<RecipesBrandBloc>()
            .pickImage();

        if (!context.mounted) {
          return;
        }

        context
            .read<RecipesBrandBloc>()
            .add(
          PickImageEvent(
            pickedImage,
            imageNumber,
          ),
        );
      },

      child: Container(
        width: imageSize,
        height: imageSize,

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: const Color(
            0xFFF8FAFC,
          ),
          borderRadius:
          BorderRadius.circular(
            ui.smallRadius + 2,
          ),
          border: Border.all(
            color: const Color(
              0xFFE2E8F0,
            ),
          ),
        ),

        child: image == null
            ? Icon(
          Icons.camera_alt_outlined,
          size: ui.iconSize + 14,
          color: ColorManager
              .secondaryColor,
        )
            : ClipRRect(
          borderRadius:
          BorderRadius.circular(
            ui.smallRadius + 1,
          ),
          child:
          _buildSelectedImage(
            context: context,
            image: image,
            checkedValue:
            checkedValue,
            imageSize:
            imageSize,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImage({
    required BuildContext context,
    required File image,
    required int checkedValue,
    required double imageSize,
  }) {
    // =========================================================
    // نفس منطق الصور الأصلي
    // =========================================================
    if (widget.st != 1) {
      return Image.file(
        image,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      );
    }

    if (checkedValue != 2) {
      return Image.network(
        '${Constants.imageUrl}${image.path}',
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,

        loadingBuilder: (
            context,
            child,
            loadingProgress,
            ) {
          if (loadingProgress == null) {
            return child;
          }

          return Center(
            child:
            CircularProgressIndicator(
              value: loadingProgress
                  .expectedTotalBytes !=
                  null
                  ? loadingProgress
                  .cumulativeBytesLoaded /
                  (loadingProgress
                      .expectedTotalBytes ??
                      1)
                  : null,
            ),
          );
        },

        errorBuilder: (
            context,
            error,
            stackTrace,
            ) {
          return const Center(
            child: Icon(
              Icons.error_outline_rounded,
              size: 42,
              color: Colors.red,
            ),
          );
        },
      );
    }

    return Image.file(
      image,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
    );
  }

  Widget _buildImageOptions({
    required BuildContext context,
    required AppUi ui,
    required int imageNumber,
    required int checkedValue,
  }) {
    final bool disabled =
        checkedValue == 2;

    return Column(
      children: [
        _buildImageRadio(
          context: context,
          ui: ui,
          imageNumber:
          imageNumber,
          checkedValue:
          checkedValue,
          optionIndex: 0,
          disabled: disabled,
        ),

        _buildImageRadio(
          context: context,
          ui: ui,
          imageNumber:
          imageNumber,
          checkedValue:
          checkedValue,
          optionIndex: 1,
          disabled: disabled,
        ),
      ],
    );
  }

  Widget _buildImageRadio({
    required BuildContext context,
    required AppUi ui,
    required int imageNumber,
    required int checkedValue,
    required int optionIndex,
    required bool disabled,
  }) {
    return RadioListTile<int>(
      dense: true,
      contentPadding:
      EdgeInsets.zero,

      activeColor:
      ColorManager.secondaryColor2,

      title: Text(
        stateImage[optionIndex].type,
        maxLines: 2,
        overflow:
        TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ui.bodyTextSize,
          color: const Color(
            0xFF334155,
          ),
          fontWeight:
          FontWeight.w500,
        ),
      ),

      value:
      stateImage[optionIndex].id,

      groupValue:
      checkedValue,

      onChanged: disabled
          ? null
          : (int? value) {
        if (imageNumber == 1) {
          context
              .read<RecipesBrandBloc>()
              .add(
            Checkbox1Event(
              value ?? 2,
            ),
          );
        } else {
          context
              .read<RecipesBrandBloc>()
              .add(
            Checkbox2Event(
              value ?? 2,
            ),
          );
        }
      },
    );
  }

  // =============================================================
  // Submit
  // =============================================================

  Widget _buildSubmitSection(
      BuildContext context,
      AppUi ui,
      ) {
    return BlocListener<
        RecipesBrandBloc,
        RecipesBrandState>(
      listener: (context, state) async {
        if (state
        is InsertRecipesLoadingState) {
          loading(
            context,
          );
        } else if (state
        is InsertRecipesState) {
          final bloc =
          context.read<RecipesBrandBloc>();

          await dismissDialog(
            context,
          );

          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .clearSnackBars();

            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'تم إرسال البيانات بنجاح',
                ),
              ),
            );

            Navigator.of(context)
                .pop();
          }

          // نفس ترتيب الحدث الأصلي بعد نجاح الإرسال
          bloc.add(
            EditeRecNumEvent(
              state.num,
            ),
          );
        } else if (state
        is InsertRecipesErrorState) {
          error(
            context,
            state.failure.massage,
            state.failure.code,
          );
        }
      },

      child: SizedBox(
        width: double.infinity,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            ColorManager.medicalPrimary,
            foregroundColor:
            Colors.white,
            elevation: 0,

            padding:
            EdgeInsets.symmetric(
              vertical:
              ui.isMobile ? 14 : 16,
            ),

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                ui.cardRadius - 4,
              ),
            ),
          ),

          onPressed: () {
            FocusScope.of(context)
                .unfocus();

            if (_formKey.currentState!
                .validate()) {
              // ===============================================
              // نفس InsertReciEvent ونفس ترتيب Arguments الأصلي
              // ===============================================
              context
                  .read<RecipesBrandBloc>()
                  .add(
                InsertReciEvent(
                  _doctorSpController.text,
                  firstNoteController.text,
                  _secondNoteController.text,
                  _addressController.text,
                  _connectController.text,
                  _specialNotesController.text,
                  widget.docId,
                  _connectController.text,
                ),
              );
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: const Text(
                    'يرجى تعبئة جميع الحقول المطلوبة',
                  ),
                  backgroundColor:
                  ColorManager
                      .secondaryColor,
                ),
              );
            }
          },

          child: Text(
            'إرسال',
            style: TextStyle(
              fontSize:
              ui.isMobile ? 15 : 17,
              fontWeight:
              FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
