import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/Recipes/widget/drop_down_recipes.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class RecipesPage extends StatelessWidget {
final   int docId;
  RecipesPage({super.key,required this.docId});

  final TextEditingController _doctorSpController = TextEditingController();

  final TextEditingController _noteoneController =
      TextEditingController(text: "يرجى عدم تبديل الدواء");

  final TextEditingController _notetwoController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _connectController = TextEditingController();

  final TextEditingController _specialNotesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: ColorManager.secondaryColor2,
                                value: '0',
                                groupValue: context
                                    .watch<RecipesBrandBloc>()
                                    .insertRecipesObject
                                    .type,
                                onChanged: (value) {
                                  BlocProvider.of<RecipesBrandBloc>(context)
                                      .add(SelectTypeEvent(value ?? "0"));
                                },
                              ),
                              const Text('الدكتور'),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: ColorManager.secondaryColor2,
                                value: '1',
                                groupValue: context
                                    .watch<RecipesBrandBloc>()
                                    .insertRecipesObject
                                    .type,
                                onChanged: (value) {
                                  BlocProvider.of<RecipesBrandBloc>(context)
                                      .add(SelectTypeEvent(value ?? "0"));
                                },
                              ),
                              const Text('الدكتورة'),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: ColorManager.secondaryColor2,
                                value: '2',
                                groupValue: context
                                    .watch<RecipesBrandBloc>()
                                    .insertRecipesObject
                                    .type,
                                onChanged: (value) {
                                  BlocProvider.of<RecipesBrandBloc>(context)
                                      .add(SelectTypeEvent(value ?? "0"));
                                },
                              ),
                              const Text('لاشيء'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                Text('اختصاص الطبيب'),
                BoxTextField(
                  inputFormatters: [],
                  controller: _doctorSpController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يرجى إدخال اختصاص الطبيب";
                    }
                    return null;
                  },
                  obscureText: false,
                  maxLines: 1,
                  minLines: 1,
                  prefixIcon: null,
                ),
                Text('المستحضر الأول'),
                BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                  builder: (context, state) {
                    return DropDownRecipesSearch(
                      hintText: state is AllRecipesLoadingState
                          ? 'loading'
                          : 'اختر المستحضر',
                      items: context.watch<RecipesBrandBloc>().brandRecs,
                      onChanged: (value) {
                        BrandRes brand = value;
                        BlocProvider.of<RecipesBrandBloc>(context)
                            .add(SelectBrandEvent(id: brand.id, index: 1));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "يرجى اختيار المستحضر الأول";
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 5),
                Text('المستحضر الثاني'),
                BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                  builder: (context, state) {
                    return DropDownRecipesSearch(
                      hintText: state is AllRecipesLoadingState
                          ? 'loading'
                          : 'اختر المستحضر',
                      items: context.watch<RecipesBrandBloc>().brandRecs,
                      onChanged: (value) {
                        BrandRes brand = value;
                        BlocProvider.of<RecipesBrandBloc>(context)
                            .add(SelectBrandEvent(id: brand.id, index: 2));
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
                      hintText: state is AllRecipesLoadingState
                          ? 'loading'
                          : 'اختر المستحضر',
                      items: context.watch<RecipesBrandBloc>().brandRecs,
                      onChanged: (value) {
                        BrandRes brand = value;
                        BlocProvider.of<RecipesBrandBloc>(context)
                            .add(SelectBrandEvent(id: brand.id, index: 3));
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
                      hintText: state is AllRecipesLoadingState
                          ? 'loading'
                          : 'اختر المستحضر',
                      items: context.watch<RecipesBrandBloc>().brandRecs,
                      onChanged: (value) {
                        BrandRes brand = value;
                        BlocProvider.of<RecipesBrandBloc>(context)
                            .add(SelectBrandEvent(id: brand.id, index: 4));
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
                  controller: _noteoneController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يرجى إدخال الملاحظة الأولى";
                    }
                    return null;
                  },
                  obscureText: false,
                  maxLines: 4,
                  minLines: 1,
                  inputFormatters: [],
                ),
                SizedBox(height: 5),
                Text('الملاحظة الثانية'),
                BoxTextField(
                  inputFormatters: [],
                  controller: _notetwoController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return null;
                  },
                  obscureText: false,
                  maxLines: 4,
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
                  maxLines: 1,
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
                  maxLines: 1,
                  minLines: 1,
                ),
                SizedBox(height: 10),
                Text('عدد الوصفات المطبوعة'),
                CustomDropDown(
                  hintText: 'اختر العدد',
                  items: [],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى اختيار العدد";
                    }
                    return null;
                  },
                  prefixIcon: null,
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
                  maxLines: 4,
                  minLines: 1,
                ),
                BlocBuilder<RecipesBrandBloc, RecipesBrandState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                File? f1 = await context
                                    .read<RecipesBrandBloc>()
                                    .pickImage();
                                BlocProvider.of<RecipesBrandBloc>(context)
                                    .add(PickImageEvent(f1, 1));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: context
                                              .watch<RecipesBrandBloc>()
                                              .imageFile1 !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            context
                                                .watch<RecipesBrandBloc>()
                                                .imageFile1!,
                                            height: 100,
                                            width: 100,
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
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                File? f2 = await context
                                    .read<RecipesBrandBloc>()
                                    .pickImage();
                                BlocProvider.of<RecipesBrandBloc>(context)
                                    .add(PickImageEvent(f2, 2));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: context
                                              .watch<RecipesBrandBloc>()
                                              .imageFile2 !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            context
                                                .watch<RecipesBrandBloc>()
                                                .imageFile2!,
                                            height: 100,
                                            width: 100,
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
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //      BlocProvider.of<RecipesBrandBloc>(context).add(InsertReciEvent(ReciRequest(UserInfo.repId.toString(), type, docId, spName, brand_1, address, phone, total)))
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('تم إرسال البيانات بنجاح')),
                      // );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('يرجى تعبئة جميع الحقول المطلوبة'),
                          backgroundColor: ColorManager.secondaryColor,
                        ),
                      );
                    }
                  },
                  child: Text(
                    "إرسال",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
