import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class InfoVisitDoctor extends StatefulWidget {
  InfoVisitDoctor({super.key, required this.doctorModel});

  final VisitDoctorAndDoctor doctorModel;

  @override
  State<InfoVisitDoctor> createState() => _InfoVisitPharmacyState();
}

class _InfoVisitPharmacyState extends State<InfoVisitDoctor> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _noteeController = TextEditingController();
  @override
  void initState() {
    _noteController.text = widget.doctorModel.visitDoctorModel.science;
    _issueController.text = widget.doctorModel.visitDoctorModel.kaswn;
    _noteeController.text = widget.doctorModel.visitDoctorModel.additaion;
 //   String dateString = widget.doctorModel.visitDoctorModel.data;
//    DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString);
 //   widget.doctorModel.visitDoctorModel.data = DateFormat('EEEE, dd-MM-yyyy – HH:mm', 'ar').format(parsedDate);
    BlocProvider.of<VisitBloc>(context)
        .add(BrandDoctorVisitEvent(widget.doctorModel.visitDoctorModel.id));
    super.initState();
  }

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
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: AppPadding.p18),
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
                    Text(
                      textAlign: TextAlign.center,
                      widget.doctorModel.doctorModel.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "عنوان الطبيب : ${widget.doctorModel.doctorModel.address}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "تاريخ الزيارة : \n${widget.doctorModel.visitDoctorModel.data}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "لتعديل  الملاحظات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {
                      return null;
                    },
                    controller: _noteController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    "ملاحظات لمستودع قاسيون  :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {
                      return null;
                    },
                    controller: _issueController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    "طلبات شخصية:",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  BoxTextField(
                    enabled: true,
                    keyboardType: TextInputType.text,
                    prefixIcon: null,
                    maxLines: 4,
                    validator: (value) {
                      return null;
                    },
                    controller: _noteeController,
                    obscureText: false,
                    minLines: 3,
                    inputFormatters: [],
                  ),
                  Text(
                    " العينات :",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<VisitBloc, VisitState>(
                    builder: (context, state) {
                      List<PharmacyBrandModel> selectBrand =
                          context.watch<VisitBloc>().brands;
                      if (state is BrandPharmacyVisitState) {
                        selectBrand = state.brands;
                      }
                      return selectBrand.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('العينات',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('نوع العينة',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text('الكمية',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...selectBrand.asMap().entries.map((entry) {
                                  //    final index = entry.key;
                                      final brand = entry.value;
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              brand.title,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(brand.phTitle,
                                                textAlign: TextAlign.center),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              brand.amount.toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                  ]))
                          : SizedBox();
                    },
                  ),
                 /*
                  BlocListener<VisitBloc, VisitState>(
                    listener: (context, state) {
                      if(state is UpdateVisitDoctorState){
                        Navigator.pop(context);
                      }
                    },
                    child:
                        ElevatedButton( onPressed: () {
                          BlocProvider.of<VisitBloc>(context).add(
                              UpdateVisitDoctorEvent
                                (kas: _issueController.text,sc: _noteController.text, id: widget.doctorModel .visitDoctorModel.id));
                        }, child: Text("تعديل")),
                  )
                  */
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
