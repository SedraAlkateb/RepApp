import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Recipes extends StatefulWidget {
  Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  final TextEditingController _doctorSpController = TextEditingController();

  final TextEditingController _noteoneController =
  TextEditingController(text: "يرجى عدم تبديل الدواء");

  final TextEditingController _notetwoController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _connectController = TextEditingController();

  final TextEditingController _specialNotesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _imageFile1;

  File? _imageFile2;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int imageNumber) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (imageNumber == 1) {
          _imageFile1 = File(pickedFile.path);
        } else if (imageNumber == 2) {
          _imageFile2 = File(pickedFile.path);
        }
      });
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                        dense: true,
                        title: const Text('الدكتور'),
                        leading: Radio(
                          value: 'الدكتور',
                          groupValue: 'الدكتور',
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          'الدكتورة',
                          style: TextStyle(color: Colors.blue),
                        ),
                        leading: Radio(
                          value: 'الدكتورة',
                          groupValue: 'selectedDoctor',
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('اختصاص الطبيب'),
                BoxTextField(inputFormatters: [],
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
                CustomDropDown(
                  hintText: 'اختر المستحضر',
                  items: [],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى اختيار المستحضر الأول";
                    }
                    return null;
                  }, prefixIcon: null,
                ),
                SizedBox(height: 5),
                Text('المستحضر الثاني'),
                CustomDropDown(prefixIcon: null,
                  hintText: 'اختر المستحضر',
                  items: [],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى اختيار المستحضر الثاني";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Text('المستحضر الثالث'),
                CustomDropDown(prefixIcon: null,
                  hintText: 'اختر المستحضر',
                  items: [],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى اختيار المستحضر الثالث";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Text('المستحضر الرابع'),
                CustomDropDown(prefixIcon: null,
                  hintText: 'اختر المستحضر',
                  items: [],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى اختيار المستحضر الرابع";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Text('الملاحظة الأولى'),
                BoxTextField(prefixIcon: null,
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
                  minLines: 1, inputFormatters: [],
                ),
                SizedBox(height: 5),
                Text('الملاحظة الثانية'),
                BoxTextField(inputFormatters: [],
                  controller: _notetwoController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يرجى إدخال الملاحظة الثانية";
                    }
                    return null;
                  },
                  obscureText: false,
                  maxLines: 4,
                  minLines: 1, prefixIcon: null,
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
                  minLines: 1, inputFormatters: [], prefixIcon: null,
                ),
                SizedBox(height: 10),
                Text('التواصل'),
                BoxTextField(inputFormatters: [],prefixIcon: null,
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
                  }, prefixIcon: null,
                ),
                SizedBox(height: 10),
                Text('ملاحظات خاصة للمندوب'),
                BoxTextField(prefixIcon:null ,inputFormatters: [],
                  controller: _specialNotesController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يرجى إدخال ملاحظات خاصة";
                    }
                    return null;
                  },
                  obscureText: false,
                  maxLines: 4,
                  minLines: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // الصورة الأولى داخل Card
                    Column(
                      children: [
                        InkWell(
                          onTap: () => _pickImage(1),
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
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: _imageFile1 != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _imageFile1!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 50, color: ColorManager.secondaryColor),
                                  SizedBox(height: 5),

                                ],
                              ),
                            ),
                          ),
                        ),Text(
                          "صورة 1",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),


                    Column(
                      children: [
                        InkWell(
                          onTap: () => _pickImage(2),
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
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: _imageFile2 != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _imageFile2!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt, size: 50, color: ColorManager.secondaryColor),
                                  SizedBox(height: 5),

                                ],
                              ),
                            ),
                          ),
                        ),  Text(
                          "صورة 2",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم إرسال البيانات بنجاح')),
                      );
                    } else {

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('يرجى تعبئة جميع الحقول المطلوبة'),backgroundColor: ColorManager.secondaryColor,),
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
