import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

showSuccessToast(BuildContext context, String title, String? description) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    title: Text(title),
    description: description != null ? Text(description) : null,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    foregroundColor: const Color(0xFF000000),
    borderRadius: BorderRadius.circular(12.0),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    closeOnClick: false,
    dragToClose: true,
    applyBlurEffect: true,
  );
}

showErrorToast(BuildContext context, String title, String? description) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flat,
    title: Text(title),
    description: description != null ? Text(description) : null,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    foregroundColor: const Color(0xFF000000),
    borderRadius: BorderRadius.circular(12.0),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    closeOnClick: false,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
