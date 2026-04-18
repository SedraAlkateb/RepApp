import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomButtonFuture extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool? isactive;

  const CustomButtonFuture({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isactive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Container(
              width: 45,
              height: 50,
              decoration: BoxDecoration(
                color: isactive == false
                    ? ColorManager.secondaryColor1.withOpacity(0.5)
                    : ColorManager.secondaryColor1,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16, // حجم النص
                  fontWeight: FontWeight.w500, // وزن النص
                  color: Colors.black, // لون النص
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
