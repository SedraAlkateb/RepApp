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

class UpdateRecipesHospital extends StatefulWidget {
  const UpdateRecipesHospital({
    super.key,
    required this.HospitalId,
    required this.st,
    required this.recipeId,
  });

  final int HospitalId;
  final int st;
  final int recipeId;

  @override
  State<UpdateRecipesHospital> createState() =>
      _UpdateRecipesHospitalState();
}

class _UpdateRecipesHospitalState
    extends State<UpdateRecipesHospital> {
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
    // =========================================================
    // نفس السلوك والترتيب الأصلي حرفياً
    // =========================================================
    print('widget.HospitalId');
    print(widget.HospitalId);

    BlocProvider.of<RecipesBrandBloc>(context)
        .add(
      RestartEvent(),
    );

    BlocProvider.of<RecipesBrandBloc>(context)
        .empty();

    if (widget.st == 1) {
      print('object');

      // BlocProvider.of<RecipesBrandBloc>(context)
      //     .add(CopyRecipesEvent(widget.HospitalId, 2));

      BlocProvider.of<RecipesBrandBloc>(context)
          .add(
        GetRepReciEvent(
          widget.recipeId,
        ),
      );

      BlocProvider.of<RecipesBrandBloc>(context)
          .isChecked2 = 3;

      BlocProvider.of<RecipesBrandBloc>(context)
          .isChecked1 = 3;
    }

    super.initState();
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
          onPressed: () {
            // نفس السلوك الأصلي
            WidgetsBinding.instance
                .addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          },

          iconSize:
          ui.isMobile ? 26 : 28,

          padding: EdgeInsets.only(
            right: ui.smallSpacing,
          ),

          icon: Icon(
            Icons.arrow_back_sharp,
            color:
            ColorManager.secondaryColor,
          ),
        ),

        title: Text(
          'تفاصيل الوصفة',
          maxLines: 1,
          overflow:
          TextOverflow.ellipsis,
          style: TextStyle(
            fontSize:
            ui.isMobile ? 18 : 21,
            fontWeight:
            FontWeight.w700,
            color:
            ColorManager.medicalPrimary,
          ),
        ),
      ),

      body: BlocBuilder<
          RecipesBrandBloc,
          RecipesBrandState>(
        builder: (context, state) {
          // =====================================================
          // Error
          // نفس الشرط والسلوك الأصلي
          // =====================================================
          if (state is RecipesRecipesErrorState &&
              widget.st == 1) {
            return Center(
              child: emptyFullScreen(
                context,
                message:
                ' لم يتم ادخال وصفات لهذا المشفى من قبل',
              ),
            );
          }

          // =====================================================
          // تعبئة البيانات
          // نفس الحقول الأصلية
          // =====================================================
          if (state is RecipesRecipesState) {
            final recipeObject = context
                .watch<RecipesBrandBloc>()
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
                      // Specialization
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'الإختصاص',
                        required: true,
                      ),

                      BoxTextField(
                        inputFormatters:
                        const [],
                        controller:
                        _doctorSpController,
                        keyboardType:
                        TextInputType.text,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال الإختصاص ';
                          }

                          return null;
                        },

                        obscureText: false,
                        maxLines: 15,
                        minLines: 1,
                        prefixIcon: null,
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 1
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الأول',
                        required: true,
                      ),

                      _buildFirstBrandField(
                        context,
                        ui,
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 2
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الثاني',
                      ),

                      BlocBuilder<
                          RecipesBrandBloc,
                          RecipesBrandState>(
                        builder: (
                            context,
                            state,
                            ) {
                          return _buildOptionalBrandField(
                            context:
                            context,
                            state: state,
                            index: 2,
                          );
                        },
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 3
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الثالث',
                      ),

                      BlocBuilder<
                          RecipesBrandBloc,
                          RecipesBrandState>(
                        builder: (
                            context,
                            state,
                            ) {
                          return _buildOptionalBrandField(
                            context:
                            context,
                            state: state,
                            index: 3,
                          );
                        },
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Brand 4
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'المستحضر الرابع',
                      ),

                      BlocBuilder<
                          RecipesBrandBloc,
                          RecipesBrandState>(
                        builder: (
                            context,
                            state,
                            ) {
                          return _buildOptionalBrandField(
                            context:
                            context,
                            state: state,
                            index: 4,
                          );
                        },
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // First Note
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'الملاحظة الأولى',
                        required: true,
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
                        inputFormatters:
                        const [],
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Second Note
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'الملاحظة الثانية',
                      ),

                      BoxTextField(
                        inputFormatters:
                        const [],
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
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Address
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'العنوان',
                        required: true,
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
                        inputFormatters:
                        const [],
                        prefixIcon: null,
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Contact
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'التواصل',
                        required: true,
                      ),

                      BoxTextField(
                        inputFormatters:
                        const [],
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
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Printed Recipe Count
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'عدد الوصفات المطبوعة',
                        required: true,
                      ),

                      BlocBuilder<
                          RecipesBrandBloc,
                          RecipesBrandState>(
                        builder: (
                            context,
                            state,
                            ) {
                          return _buildRecipeCountField(
                            context,
                            state,
                          );
                        },
                      ),

                      SizedBox(
                        height:
                        ui.sectionSpacing,
                      ),

                      // =================================================
                      // Representative Notes
                      // =================================================
                      _buildFieldLabel(
                        ui,
                        'ملاحظات خاصة للمندوب',
                      ),

                      BoxTextField(
                        prefixIcon: null,
                        inputFormatters:
                        const [],
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
                        height:
                        ui.largeSpacing,
                      ),

                      // =================================================
                      // Images
                      // =================================================
                      BlocBuilder<
                          RecipesBrandBloc,
                          RecipesBrandState>(
                        builder: (
                            context,
                            state,
                            ) {
                          return _buildImagesSection(
                            context,
                            ui,
                          );
                        },
                      ),

                      SizedBox(
                        height:
                        ui.largeSpacing,
                      ),

                      // =================================================
                      // Submit
                      // =================================================
                      _buildUpdateSection(
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
  // Field Label
  // =============================================================

  Widget _buildFieldLabel(
      AppUi ui,
      String label, {
        bool required = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ui.smallSpacing,
        right: 2,
      ),

      child: Align(
        alignment:
        AlignmentDirectional
            .centerStart,

        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: TextStyle(
                  fontSize:
                  ui.isMobile
                      ? 14.5
                      : 16,
                  fontWeight:
                  FontWeight.w600,
                  color:
                  const Color(
                    0xFF334155,
                  ),
                  height: 1.3,
                ),
              ),

              if (required)
                const TextSpan(
                  text: '  *',
                  style: TextStyle(
                    color: Color(
                      0xFFEF4444,
                    ),
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // First Brand
  // =============================================================

  Widget _buildFirstBrandField(
      BuildContext context,
      AppUi ui,
      ) {
    final bloc =
    context.watch<
        RecipesBrandBloc>();

    return FormField<BrandRes>(
      validator: (value) {
        if (value == null) {
          return 'يرجى اختيار المستحضر الأول';
        }

        return null;
      },

      builder:
          (FormFieldState<BrandRes>
      formState) {
        return Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            DropDownRecipesSearch(
              brandRes:
              bloc
                  .insertRecipesObject
                  .brand_1,

              // نفس منطق الكود الأصلي داخل FormField
              hintText: widget.st == 1
                  ? bloc
                  .insertRecipesObject
                  .brand_1
                  .title_en
                  : 'اختر المستحضر',

              items: bloc.brandRecs,

              onChanged: (value) {
                final BrandRes brand =
                    value;

                formState.didChange(
                  brand,
                );

                BlocProvider.of<
                    RecipesBrandBloc>(
                  context,
                ).add(
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
                padding:
                EdgeInsets.only(
                  top:
                  ui.smallSpacing,
                ),

                child: Text(
                  formState
                      .errorText ??
                      '',

                  style: TextStyle(
                    color:
                    Colors.red,
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

  // =============================================================
  // Optional Brands 2 / 3 / 4
  // =============================================================

  Widget _buildOptionalBrandField({
    required BuildContext context,
    required RecipesBrandState state,
    required int index,
  }) {
    final bloc =
    context.watch<
        RecipesBrandBloc>();

    BrandRes? brand;

    switch (index) {
      case 2:
        brand =
            bloc
                .insertRecipesObject
                .brand_2;
        break;

      case 3:
        brand =
            bloc
                .insertRecipesObject
                .brand_3;
        break;

      case 4:
        brand =
            bloc
                .insertRecipesObject
                .brand_4;
        break;
    }

    return DropDownRecipesSearch(
      brandRes: brand,

      hintText:
      (state
      is AllRecipesLoadingState ||
          state
          is AllNumLoadingState)
          ? 'loading'
          : widget.st == 1
          ? brand?.title_en ??
          ''
          : 'اختر المستحضر',

      items: bloc.brandRecs,

      onChanged: (value) {
        final BrandRes
        selectedBrand = value;

        BlocProvider.of<
            RecipesBrandBloc>(
          context,
        ).add(
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
    context.watch<
        RecipesBrandBloc>();

    return DropDownNum(
      hintText:
      (state
      is AllRecipesLoadingState ||
          state
          is AllNumLoadingState)
          ? 'loading'
          : widget.st == 1
          ? bloc
          .insertRecipesObject
          .total
          : 'اختر العدد',

      items: bloc.numRec,

      onChanged: (value) {
        // نفس Event الأصلي
        BlocProvider.of<
            RecipesBrandBloc>(
          context,
        ).add(
          SelectNumRecEvent(
            num:
            value.toString(),
          ),
        );
      },

      validator: (value) {
        if (value == null &&
            context
                .read<
                RecipesBrandBloc>()
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
    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        final bool showSideBySide =
            ui.isTabletLandscape &&
                constraints.maxWidth >=
                    650;

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
                width:
                ui.cardSpacing,
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
              height:
              ui.cardSpacing,
            ),

            secondImage,
          ],
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
    context.watch<
        RecipesBrandBloc>();

    final File? image =
    imageNumber == 1
        ? bloc
        .insertRecipesObject
        .image1
        : bloc
        .insertRecipesObject
        .image2;

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
            imageNumber:
            imageNumber,
            image: image,
            checkedValue:
            checkedValue,
          ),

          SizedBox(
            height:
            ui.smallSpacing,
          ),

          Text(
            'صورة $imageNumber',
            style: TextStyle(
              color:
              const Color(
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
            .read<
            RecipesBrandBloc>()
            .pickImage();

        // نفس PickImageEvent الأصلي
        BlocProvider.of<
            RecipesBrandBloc>(
          context,
        ).add(
          PickImageEvent(
            pickedImage,
            imageNumber,
          ),
        );
      },

      child: Container(
        width: imageSize,
        height: imageSize,

        alignment:
        Alignment.center,

        decoration:
        BoxDecoration(
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
            ? Column(
          mainAxisAlignment:
          MainAxisAlignment
              .center,

          children: [
            Icon(
              Icons.camera_alt,
              size:
              ui.iconSize +
                  14,
              color:
              ColorManager
                  .secondaryColor,
            ),

            SizedBox(
              height: ui
                  .smallSpacing,
            ),
          ],
        )
            : ClipRRect(
          borderRadius:
          BorderRadius
              .circular(
            ui.smallRadius +
                1,
          ),

          child:
          _buildSelectedImage(
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
          if (loadingProgress ==
              null) {
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
          return const Icon(
            Icons.error,
            size: 50,
            color: Colors.red,
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
          autofocus:
          imageNumber == 1,
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
          autofocus: false,
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
    required bool autofocus,
  }) {
    return RadioListTile<int>(
      autofocus: autofocus,

      dense: true,

      contentPadding:
      EdgeInsets.zero,

      activeColor:
      ColorManager
          .secondaryColor2,

      title: Text(
        stateImage[optionIndex]
            .type,

        maxLines: 2,

        overflow:
        TextOverflow.ellipsis,

        style: TextStyle(
          fontSize:
          ui.bodyTextSize,
          color: const Color(
            0xFF334155,
          ),
          fontWeight:
          FontWeight.w500,
        ),
      ),

      value:
      stateImage[optionIndex]
          .id,

      groupValue:
      checkedValue,

      onChanged: disabled
          ? null
          : (int? value) {
        if (imageNumber ==
            1) {
          // نفس Checkbox1Event
          BlocProvider.of<
              RecipesBrandBloc>(
            context,
          ).add(
            Checkbox1Event(
              value ?? 2,
            ),
          );
        } else {
          // نفس Checkbox2Event
          BlocProvider.of<
              RecipesBrandBloc>(
            context,
          ).add(
            Checkbox2Event(
              value ?? 2,
            ),
          );
        }
      },
    );
  }

  // =============================================================
  // Update / Submit
  // =============================================================

  Widget _buildUpdateSection(
      BuildContext context,
      AppUi ui,
      ) {
    return BlocListener<
        RecipesBrandBloc,
        RecipesBrandState>(
      listener:
          (context, state) async {
        // =====================================================
        // نفس Listener الأصلي حرفياً
        // =====================================================
        if (state
        is InsertRecipesLoadingState) {
          loading(
            context,
          );
        } else if (state
        is InsertRecipesState) {
          await dismissDialog(
            context,
          );

          Navigator.of(context)
              .pop();

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            const SnackBar(
              content: Text(
                'تم إرسال البيانات بنجاح',
              ),
            ),
          );

          BlocProvider.of<
              RecipesBrandBloc>(
            context,
          ).add(
            EditeRecNumEvent(
              state.num,
            ),
          );
        } else if (state
        is InsertRecipesErrorState) {
          // مهم: محفوظ كما في الكود الأصلي
          success(
            context,
          );

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
          style:
          ElevatedButton.styleFrom(
            backgroundColor:
            ColorManager
                .medicalPrimary,

            foregroundColor:
            Colors.white,

            elevation: 0,

            padding:
            EdgeInsets.symmetric(
              vertical:
              ui.isMobile
                  ? 14
                  : 16,
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
            // =================================================
            // نفس validation ونفس Event الأصلي تماماً
            // =================================================
            if (_formKey
                .currentState!
                .validate()) {
              BlocProvider.of<
                  RecipesBrandBloc>(
                context,
              ).add(
                UpdateReciSHospitalEvent(
                  widget.HospitalId,
                  _doctorSpController
                      .text,
                  firstNoteController
                      .text,
                  _secondNoteController
                      .text,
                  _addressController
                      .text,
                  _connectController
                      .text,
                  _specialNotesController
                      .text,
                  widget.recipeId,
                ),
              );
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
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
              ui.isMobile
                  ? 15
                  : 17,
              fontWeight:
              FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
