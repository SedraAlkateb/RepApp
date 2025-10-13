import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  // طلب إذن قراءة الصور
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  // طلب إذن الكاميرا
  if (await Permission.camera.isDenied) {
    await Permission.camera.request();
  }

  // طلب إذن الإشعارات (Android 13+)
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
