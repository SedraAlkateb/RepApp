import 'package:domina_app/app/constants.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/Recipes/widget/drop_down_num.dart';
import 'package:domina_app/presentation/Recipes/widget/drop_down_recipes.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class UpdateRecipesHospital extends StatefulWidget {
  final int HospitalId;
  final int st;
  final int recipeId;

  UpdateRecipesHospital(
      {super.key,
      required this.HospitalId,
      required this.st,
      required this.recipeId});
  @override
  State<UpdateRecipesHospital> createState() => _UpdateRecipesHospitalState();
}

class _UpdateRecipesHospitalState extends State<UpdateRecipesHospital> {
  final TextEditingController _doctorSpController = TextEditingController();
  final TextEditingController firstNoteController =
      TextEditingController(text: "يرجى عدم تبديل الدواء");
  final TextEditingController _secondNoteController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _connectController = TextEditingController();
  final TextEditingController _specialNotesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    print("widget.HospitalId");
    print(widget.HospitalId);
    BlocProvider.of<RecipesBrandBloc>(context).add(RestartEvent());
    BlocProvider.of<RecipesBrandBloc>(context).empty();
    if (widget.st == 1) {
      print("object");
      // BlocProvider.of<RecipesBrandBloc>(context)
      //     .add(CopyRecipesEvent(widget.HospitalId, 2));
      BlocProvider.of<RecipesBrandBloc>(context)
          .add(GetRepReciEvent(widget.recipeId));
      BlocProvider.of<RecipesBrandBloc>(context).isChecked2 = 3;
      BlocProvider.of<RecipesBrandBloc>(context).isChecked1 = 3;
    }

    super.initState();
  }

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
            padding: EdgeInsets.only(right: 15),
            icon: Icon(Icons.arrow_back_sharp,
                color: ColorManager.secondaryColor)),
        title: Text('تفاصيل الوصفة'),
      ),
      body: BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
        builder: (context, state) {
          if ((state is RecipesRecipesErrorState) && (widget.st == 1)) {
            return Center(
                child: emptyFullScreen(context,
                    message: " لم يتم ادخال وصفات لهذا المشفى من قبل"));
          }
          if (state is RecipesRecipesState) {
            _doctorSpController.text =
                context.watch<RecipesBrandBloc>().insertRecipesObject.spName;
            firstNoteController.text =
                context.watch<RecipesBrandBloc>().insertRecipesObject.note1 ??
                    "";
            _secondNoteController.text =
                context.watch<RecipesBrandBloc>().insertRecipesObject.note2 ??
                    "";
            _addressController.text =
                context.watch<RecipesBrandBloc>().insertRecipesObject.address;
            _connectController.text =
                context.watch<RecipesBrandBloc>().insertRecipesObject.phone;
            _specialNotesController.text = context
                    .watch<RecipesBrandBloc>()
                    .insertRecipesObject
                    .note_emp ??
                "";
          }
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('الإختصاص'),
                    BoxTextField(
                      inputFormatters: [],
                      controller: _doctorSpController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يرجى إدخال الإختصاص ";
                        }
                        return null;
                      },
                      obscureText: false,
                      maxLines: 15,
                      minLines: 1,
                      prefixIcon: null,
                    ),
                    Text('المستحضر الأول'),
                    FormField<BrandRes>(
                      validator: (value) {
                        if (value == null) {
                          return "يرجى اختيار المستحضر الأول";
                        }
                        return null;
                      },
                      builder: (FormFieldState<BrandRes?> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropDownRecipesSearch(
                              brandRes: context
                                  .watch<RecipesBrandBloc>()
                                  .insertRecipesObject
                                  .brand_1,
                              hintText: (state is AllRecipesLoadingState ||
                                      state is AllNumLoadingState)
                                  ? 'loading'
                                  : widget.st == 1
                                      ? context
                                          .watch<RecipesBrandBloc>()
                                          .insertRecipesObject
                                          .brand_1
                                          .title_en
                                      : 'اختر المستحضر',
                              items:
                                  context.watch<RecipesBrandBloc>().brandRecs,
                              onChanged: (value) {
                                BrandRes brand = value;
                                state.didChange(brand);
                                BlocProvider.of<RecipesBrandBloc>(context).add(
                                    SelectBrandEvent(
                                        brandRecipeModel: brand, index: 1));
                              },
                              validator: (value) {
                                return null;
                              },
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  state.errorText ?? '',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Text('المستحضر الثاني'),
                    BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                      builder: (context, state) {
                        return DropDownRecipesSearch(
                          brandRes: context
                              .watch<RecipesBrandBloc>()
                              .insertRecipesObject
                              .brand_2,
                          hintText: (state is AllRecipesLoadingState ||
                                  state is AllNumLoadingState)
                              ? 'loading'
                              : widget.st == 1
                                  ? context
                                          .watch<RecipesBrandBloc>()
                                          .insertRecipesObject
                                          .brand_2
                                          ?.title_en ??
                                      ""
                                  : 'اختر المستحضر',
                          items: context.watch<RecipesBrandBloc>().brandRecs,
                          onChanged: (value) {
                            BrandRes brand = value;
                            BlocProvider.of<RecipesBrandBloc>(context).add(
                                SelectBrandEvent(
                                    brandRecipeModel: brand, index: 2));
                          },
                          validator: (value) {
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Text('المستحضر الثالث'),
                    BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                      builder: (context, state) {
                        return DropDownRecipesSearch(
                          brandRes: context
                              .watch<RecipesBrandBloc>()
                              .insertRecipesObject
                              .brand_3,
                          hintText: (state is AllRecipesLoadingState ||
                                  state is AllNumLoadingState)
                              ? 'loading'
                              : widget.st == 1
                                  ? context
                                          .watch<RecipesBrandBloc>()
                                          .insertRecipesObject
                                          .brand_3
                                          ?.title_en ??
                                      ""
                                  : 'اختر المستحضر',
                          items: context.watch<RecipesBrandBloc>().brandRecs,
                          onChanged: (value) {
                            BrandRes brand = value;
                            BlocProvider.of<RecipesBrandBloc>(context).add(
                                SelectBrandEvent(
                                    brandRecipeModel: brand, index: 3));
                          },
                          validator: (value) {
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Text('المستحضر الرابع'),
                    BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                      builder: (context, state) {
                        return DropDownRecipesSearch(
                          brandRes: context
                              .watch<RecipesBrandBloc>()
                              .insertRecipesObject
                              .brand_4,
                          hintText: (state is AllRecipesLoadingState ||
                                  state is AllNumLoadingState)
                              ? 'loading'
                              : widget.st == 1
                                  ? context
                                          .watch<RecipesBrandBloc>()
                                          .insertRecipesObject
                                          .brand_4
                                          ?.title_en ??
                                      ""
                                  : 'اختر المستحضر',
                          items: context.watch<RecipesBrandBloc>().brandRecs,
                          onChanged: (value) {
                            BrandRes brand = value;
                            BlocProvider.of<RecipesBrandBloc>(context).add(
                                SelectBrandEvent(
                                    brandRecipeModel: brand, index: 4));
                          },
                          validator: (value) {
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Text('الملاحظة الأولى'),
                    BoxTextField(
                      prefixIcon: null,
                      controller: firstNoteController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يرجى إدخال الملاحظة الأولى";
                        }
                        return null;
                      },
                      obscureText: false,
                      maxLines: 15,
                      minLines: 1,
                      inputFormatters: [],
                    ),
                    SizedBox(height: 5),
                    Text('الملاحظة الثانية'),
                    BoxTextField(
                      inputFormatters: [],
                      controller: _secondNoteController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                      obscureText: false,
                      maxLines: 15,
                      minLines: 1,
                      prefixIcon: null,
                    ),
                    SizedBox(height: 5),
                    Text('العنوان'),
                    BoxTextField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يرجى إدخال العنوان";
                        }
                        return null;
                      },
                      obscureText: false,
                      maxLines: 15,
                      minLines: 1,
                      inputFormatters: [],
                      prefixIcon: null,
                    ),
                    SizedBox(height: 10),
                    Text('التواصل'),
                    BoxTextField(
                      inputFormatters: [],
                      prefixIcon: null,
                      controller: _connectController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يرجى إدخال رقم التواصل";
                        }
                        return null;
                      },
                      obscureText: false,
                      maxLines: 15,
                      minLines: 1,
                    ),
                    SizedBox(height: 10),
                    Text('عدد الوصفات المطبوعة'),
                    BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                      builder: (context, state) {
                        return DropDownNum(
                          hintText: (state is AllRecipesLoadingState ||
                                  state is AllNumLoadingState)
                              ? "loading"
                              : widget.st == 1
                                  ? context
                                      .watch<RecipesBrandBloc>()
                                      .insertRecipesObject
                                      .total
                                  : 'اختر العدد',
                          items: context.watch<RecipesBrandBloc>().numRec,
                          onChanged: (value) {
                            BlocProvider.of<RecipesBrandBloc>(context)
                                .add(SelectNumRecEvent(num: value.toString()));
                          },
                          validator: (value) {
                            if ((value == null) &&
                                (context
                                        .read<RecipesBrandBloc>()
                                        .insertRecipesObject
                                        .total ==
                                    "")) {
                              return "يرجى اختيار العدد";
                            }
                            return null;
                          },
                          prefixIcon: null,
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text('ملاحظات خاصة للمندوب'),
                    BoxTextField(
                      prefixIcon: null,
                      inputFormatters: [],
                      controller: _specialNotesController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return null;
                      },
                      obscureText: false,
                      maxLines: 15,
                      minLines: 1,
                    ),
                    BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        File? f1 = await context
                                            .read<RecipesBrandBloc>()
                                            .pickImage();
                                        print("object");
                                        print(f1?.path);
                                        BlocProvider.of<RecipesBrandBloc>(
                                                context)
                                            .add(PickImageEvent(f1, 1));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                          ),
                                          child: context
                                                      .watch<RecipesBrandBloc>()
                                                      .insertRecipesObject
                                                      .image1 !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: widget.st != 1
                                                      ? Image.file(
                                                          context
                                                              .watch<
                                                                  RecipesBrandBloc>()
                                                              .insertRecipesObject
                                                              .image1!,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : (context
                                                                  .watch<
                                                                      RecipesBrandBloc>()
                                                                  .isChecked1 !=
                                                              2)
                                                          ? Image.network(
                                                              "${Constants.imageUrl}${context.watch<RecipesBrandBloc>().insertRecipesObject.image1!.path}",
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              fit: BoxFit.cover,
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null) {
                                                                  return child;
                                                                } else {
                                                                  return Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes !=
                                                                              null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              (loadingProgress.expectedTotalBytes ?? 1)
                                                                          : null,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Icon(
                                                                    Icons.error,
                                                                    size: 50,
                                                                    color: Colors
                                                                        .red);
                                                              },
                                                            )
                                                          : Image.file(
                                                              context
                                                                  .watch<
                                                                      RecipesBrandBloc>()
                                                                  .insertRecipesObject
                                                                  .image1!,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              fit: BoxFit.cover,
                                                            ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.camera_alt,
                                                        size: 50,
                                                        color: ColorManager
                                                            .secondaryColor),
                                                    SizedBox(height: 5),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "صورة 1",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                if (widget.st == 1)
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RadioListTile(
                                          autofocus: true,
                                          activeColor:
                                              ColorManager.secondaryColor2,
                                          title: Text(
                                            stateImage[0].type,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          value: stateImage[0].id,
                                          groupValue: context
                                              .watch<RecipesBrandBloc>()
                                              .isChecked1,
                                          onChanged: context
                                                      .watch<RecipesBrandBloc>()
                                                      .isChecked1 ==
                                                  2
                                              ? null
                                              : (int? value) {
                                                  print("object11");
                                                  print(value);
                                                  BlocProvider.of<
                                                              RecipesBrandBloc>(
                                                          context)
                                                      .add(Checkbox1Event(
                                                          value ?? 2));
                                                },
                                        ),
                                        RadioListTile(
                                          autofocus: false,
                                          activeColor:
                                              ColorManager.secondaryColor2,
                                          title: Text(
                                            stateImage[1].type,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          value: stateImage[1].id,
                                          groupValue: context
                                              .watch<RecipesBrandBloc>()
                                              .isChecked1,
                                          onChanged: context
                                                      .watch<RecipesBrandBloc>()
                                                      .isChecked1 ==
                                                  2
                                              ? null
                                              : (int? value) {
                                                  print("object12");
                                                  print(value);
                                                  BlocProvider.of<
                                                              RecipesBrandBloc>(
                                                          context)
                                                      .add(Checkbox1Event(
                                                          value ?? 2));
                                                },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        File? f2 = await context
                                            .read<RecipesBrandBloc>()
                                            .pickImage();
                                        BlocProvider.of<RecipesBrandBloc>(
                                                context)
                                            .add(PickImageEvent(f2, 2));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                          ),
                                          child: context
                                                      .watch<RecipesBrandBloc>()
                                                      .insertRecipesObject
                                                      .image2 !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: widget.st != 1
                                                      ? Image.file(
                                                          context
                                                              .watch<
                                                                  RecipesBrandBloc>()
                                                              .insertRecipesObject
                                                              .image2!,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : context
                                                                  .watch<
                                                                      RecipesBrandBloc>()
                                                                  .isChecked2 !=
                                                              2
                                                          ? Image.network(
                                                              "${Constants.imageUrl}${context.watch<RecipesBrandBloc>().insertRecipesObject.image2!.path}",
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              fit: BoxFit.cover,
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null) {
                                                                  return child;
                                                                } else {
                                                                  return Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes !=
                                                                              null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              (loadingProgress.expectedTotalBytes ?? 1)
                                                                          : null,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Icon(
                                                                    Icons.error,
                                                                    size: 50,
                                                                    color: Colors
                                                                        .red);
                                                              },
                                                            )
                                                          : Image.file(
                                                              context
                                                                  .watch<
                                                                      RecipesBrandBloc>()
                                                                  .insertRecipesObject
                                                                  .image2!,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.2,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.2,
                                                              fit: BoxFit.cover,
                                                            ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.camera_alt,
                                                        size: 50,
                                                        color: ColorManager
                                                            .secondaryColor),
                                                    SizedBox(height: 5),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "صورة 2",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                if (widget.st == 1)
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RadioListTile(
                                          activeColor:
                                              ColorManager.secondaryColor2,
                                          title: Text(
                                            stateImage[0].type,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          value: stateImage[0].id,
                                          groupValue: context
                                              .watch<RecipesBrandBloc>()
                                              .isChecked2,
                                          onChanged: context
                                                      .watch<RecipesBrandBloc>()
                                                      .isChecked2 ==
                                                  2
                                              ? null
                                              : (int? value) {
                                                  print("object21");
                                                  print(value);
                                                  BlocProvider.of<
                                                              RecipesBrandBloc>(
                                                          context)
                                                      .add(Checkbox2Event(
                                                          value ?? 2));
                                                },
                                        ),
                                        RadioListTile(
                                          title: Text(
                                            stateImage[1].type,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          activeColor:
                                              ColorManager.secondaryColor2,
                                          value: stateImage[1].id,
                                          groupValue: context
                                              .watch<RecipesBrandBloc>()
                                              .isChecked2,
                                          onChanged: context
                                                      .watch<RecipesBrandBloc>()
                                                      .isChecked2 ==
                                                  2
                                              ? null
                                              : (int? value) {
                                                  print("object22");
                                                  print(value);
                                                  BlocProvider.of<
                                                              RecipesBrandBloc>(
                                                          context)
                                                      .add(Checkbox2Event(
                                                          value ?? 2));
                                                },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    BlocListener<RecipesBrandBloc, RecipesBrandState>(
                      listener: (context, state) async{
                        if (state is InsertRecipesLoadingState) {
                          loading(context);
                        } else if (state is InsertRecipesState) {
                          await dismissDialog(context);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم إرسال البيانات بنجاح')),
                          );
                        } else if (state is InsertRecipesErrorState) {
                          success(context);
                          error(context, state.failure.massage,
                              state.failure.code);
                        }
                      },
                      child:   ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<RecipesBrandBloc>(context).add(
                                UpdateReciSHospitalEvent(
                                    widget.HospitalId,
                                    _doctorSpController.text,
                                    firstNoteController.text,
                                    _secondNoteController.text,
                                    _addressController.text,
                                    _connectController.text,
                                    _specialNotesController.text,
                                    widget.recipeId));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                Text('يرجى تعبئة جميع الحقول المطلوبة'),
                                backgroundColor:
                                ColorManager.secondaryColor,
                              ),
                            );
                          }
                        },
                        child: Text(
                          "إرسال",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
