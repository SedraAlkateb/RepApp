import 'package:flutter/material.dart';

class AuditingPlan extends StatelessWidget {
  const AuditingPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تدقيق خطة المندوب"),
      ),
      body:Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Text("data"),),
        ],
      ) ,
    );
  }
}
