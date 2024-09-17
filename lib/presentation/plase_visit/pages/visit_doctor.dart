import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
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
                  Text(
                    doctorModel.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "عنوان الصيدلية : ${doctorModel.address }",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      // Rebuild the ListView when selectBrand is updated
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: context.watch<VisitPlaceBloc>().selectBrand.length,
                        itemBuilder: (context, index) {
                          return Text(
                            context.watch<VisitPlaceBloc>().selectBrand[index].title,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          );
                        },
                      );
                    },
                  ),
                  BoxTextField(
                    keyboardType:
                    TextInputType.text,
                    prefixIcon: null,
                    maxLines: 10,
                    validator: (value) {
                      return null;
                    },
                    controller:
                    _noteController,
                    obscureText: false,
                    minLines: 5,
                    inputFormatters: [],
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
