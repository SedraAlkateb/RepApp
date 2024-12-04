import 'dart:io';
import 'package:image/image.dart' as img;

Future<File> convertToPng(File inputFile) async {
  try {
    final image = img.decodeImage(await inputFile.readAsBytes());
    if (image == null) {
      throw Exception("الملف ليس صورة صالحة أو غير مدعوم.");
    }
    final pngBytes = img.encodePng(image);
    final outputFile = File('${inputFile.parent.path}/${inputFile.uri.pathSegments.last.split('.').first}.png');
    await outputFile.writeAsBytes(pngBytes);

    return outputFile;
  } catch (e) {
    print("خطأ أثناء التحويل إلى PNG: $e");
    rethrow;
  }
}
