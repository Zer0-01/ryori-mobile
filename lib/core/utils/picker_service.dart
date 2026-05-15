import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:ryori/core/logger/app_logger.dart';

@lazySingleton
class PickerService {
  PickerService() : _imagePicker = ImagePicker();

  final ImagePicker _imagePicker;
  final AppLogger _logger = AppLogger(tag: 'PickerService');

  Future<XFile?> pickImageFromGallery() async {
    try {
      return await _imagePicker.pickImage(source: ImageSource.gallery);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to pick image from gallery.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      return await _imagePicker.pickImage(source: ImageSource.camera);
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to pick image from camera.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<XFile>> pickFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    try {
      final result = await FilePicker.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );

      if (result == null) {
        return const [];
      }

      return result.xFiles;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to pick file entries.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
