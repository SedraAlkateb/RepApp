import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/models.dart';

class VisitDoctor extends StatelessWidget {
   VisitDoctor({super.key,required this.doctorModel});
  final DoctorModel doctorModel;
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                color: ColorManager.secondaryColor1,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 30,
                          padding: EdgeInsets.only(right: 15),
                          icon: Icon(Icons.arrow_back_sharp,
                              color: ColorManager.white))),
                  Center(
                    child: Text(
                      doctorModel?.title ?? " ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "العنوان: ${doctorModel?.address ?? " "}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(
                    "أضف ملاحظاتك :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {},
                    controller: _noteController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    "اختر العينات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BlocListener<VisitPlaceBloc, VisitPlaceState>(
                    listener: (context, state) {
                      if(state is BrandFlagErrorState) {
                        print("object");
                        error(context, state.failure.massage, state.failure.code);
                      }
                      },
                   child: CustomDropDown(
                     hintText: "العينات",
                     items: context.watch<VisitPlaceBloc>().bandFlag,
                     prefixIcon: null,
                     onChanged: (value) {

                       BrandModel brand=value;
                       BlocProvider.of<VisitPlaceBloc>(context).add(SelectBrandEvent(brand));
                     },
                     validator: (value) {
                       return null;
                     },),
                  ),
                                   BlocBuilder<VisitPlaceBloc, VisitPlaceState>(
                    builder: (context, state) {
                      // الوصول إلى selectBrand من VisitPlaceBloc
                      final selectBrand =
                          context.watch<VisitPlaceBloc>().selectBrand;

                      return context
                              .watch<VisitPlaceBloc>()
                              .selectBrand
                              .isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Table(
                                border: TableBorder.all(), // إضافة حدود للجدول
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(1),
                                  3: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text('العينات',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text('نوع العينة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text('الكمية',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text('',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ...selectBrand.map((brand) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            brand.title,
                                            textAlign: TextAlign.center,
                                          ), // عرض البيانات من BrandModel
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(brand.phTitle,
                                              textAlign: TextAlign.center),
                                        ),
                                        IntrinsicHeight(
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: ' ',
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                              errorText: null,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: AppSize.s1_5,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: AppSize.s1_5,
                                                ),
                                                // borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: AppSize.s1_5,
                                                ),
                                                // borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
                                              ),
                                              fillColor: ColorManager.white,
                                              filled:
                                                  true, // لجعل الخلفية بيضاء
                                            ),
                                            cursorColor: Colors
                                                .black, // تعيين لون المؤشر (الخط الوامض)
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text('',
                                              textAlign: TextAlign.center),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                 
                  ElevatedButton(onPressed: (){
                    if(_noteController.text.isNotEmpty||context.read<VisitPlaceBloc>().selectBrand.isNotEmpty){
                      DateTime now = DateTime.now();
                      VisitDoctorModel visitDoctorModel= VisitDoctorModel(0,
                          now.toString()
                          , _noteController.text, _noteController.text, _noteController.text,doctorModel.id);
                      BlocProvider.of<VisitPlaceBloc>(context).add(InsertVisitDoctorEvent(visitDoctorModel));

                    }
                  }, child: Text("ارسال"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
