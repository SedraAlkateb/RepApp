import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';

class Prescriptions extends StatelessWidget {
  Prescriptions({super.key});


  final TextEditingController _doctornameController = TextEditingController();
  final TextEditingController _doctorSpController = TextEditingController();
  final TextEditingController _brandoneController = TextEditingController();
  final TextEditingController _brandtwoController = TextEditingController();
  final TextEditingController _brandthreeController = TextEditingController();
  final TextEditingController _noteoneController = TextEditingController();
  final TextEditingController _notetwoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _connectController = TextEditingController();
  final TextEditingController _numberofPrintedController = TextEditingController();
  final TextEditingController _specialNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.menu,
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('تفاصيل الوصفة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
             
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('الدكتور'),
                      leading: Radio(
                        value: 'الدكتور',
                        groupValue: 'selectedDoctor',
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('الدكتورة'),
                      leading: Radio(
                        value: 'الدكتورة',
                        groupValue: 'selectedDoctor',
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
          
            
            
          
          
              Text('اختصاص الطبيب'),
              TextField(
                controller: _doctorSpController,
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('المستحضر الأول'),
              TextField(
                controller: _brandoneController, 
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('المستحضر الثاني'),
              TextField(
                controller: _brandtwoController, 
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('المستحضر الثالث'),
              TextField(
                controller: _brandthreeController, 
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('الملاحظة الأولى'),
              TextField(
                controller: _noteoneController,
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('الملاحظة الثانية'),
              TextField(
                controller: _notetwoController, 
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('العنوان'),
              TextField(
                controller: _addressController, 
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('التواصل'),
              TextField(
                controller: _connectController, 
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('عدد الوصفات المطبوعة'),
              TextField(
                controller: _numberofPrintedController,
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
          
              SizedBox(height: 10),
          
              Text('ملاحظات خاصة للمندوب'),
              TextField(
                controller: _specialNotesController,
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
