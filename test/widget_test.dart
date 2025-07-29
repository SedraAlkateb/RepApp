// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
// import 'package:domina_app/presentation/ss.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main()async {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Ss(s: "jujhhhhhhhhhhhhhhhhhhhhhhhhhhh",)
//       ),
//     );

//   });

// }


// class AnimatedDropdownButtonFormField extends StatefulWidget {
//   @override
//   _AnimatedDropdownButtonFormFieldState createState() => _AnimatedDropdownButtonFormFieldState();
// }

// class _AnimatedDropdownButtonFormFieldState extends State<AnimatedDropdownButtonFormField> {
//   bool _isLoading = true;
//   List<String> _dropdownItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     // Simulate a network call
//     await Future.delayed(Duration(seconds: 3));
//     setState(() {
//       _dropdownItems = ['Item 1', 'Item 2', 'Item 3'];
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Animated DropdownButtonFormField')),
//       body: Center(
//         child: _isLoading
//             ? SpinKitCircle(color: Colors.blue, size: 50.0)
//             : DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: 'Select Item',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: _dropdownItems.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   // Handle change
//                 },
//               ),
//       ),
//     );
//   }
// }



import 'package:flutter_test/flutter_test.dart';
import 'package:domina_app/presentation/ss.dart'; // عدل الاسم حسب مشروعك

void main() {
  group('Calculator', () {
    test('should add two numbers correctly', () {
      final calc = Calculator();
      expect(calc.add(3, 2), 5);
    });

    test('should subtract two numbers correctly', () {
      final calc = Calculator();
      expect(calc.subtract(10, 4), 6);
    });
  });
}