import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';
import 'package:manifesto/common/widgets/toast_message.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

class UploadDocumentDialog {
  static Future<void> show({
    required Future<bool> Function({
      required String filePath,
      required String filename,
      String? type,
      bool analyze,
    }) onUpload,
  }) {
    return Get.dialog(
      _UploadDocumentDialogBody(onUpload: onUpload),
      barrierDismissible: false,
    );
  }
}

class _UploadDocumentDialogBody extends StatefulWidget {
  final Future<bool> Function({
    required String filePath,
    required String filename,
    String? type,
    bool analyze,
  }) onUpload;

  const _UploadDocumentDialogBody({required this.onUpload});

  @override
  State<_UploadDocumentDialogBody> createState() =>
      _UploadDocumentDialogBodyState();
}

class _UploadDocumentDialogBodyState extends State<_UploadDocumentDialogBody> {
  String? _filePath;
  String? _filename;
  String _type = DocumentTypes.labReport;
  bool _analyze = false;
  bool _picking = false;
  bool _submitting = false;

  Future<void> _pickFile() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: const [
          'pdf',
          'png',
          'jpg',
          'jpeg',
          'webp',
          'heic',
          'doc',
          'docx',
        ],
      );
      if (file == null) return;

      String? path = file.path;
      if (path == null || path.isEmpty) {
        final bytes = await file.readAsBytes();
        final tempDir = await getTemporaryDirectory();
        final safeName =
            file.name.isEmpty ? 'upload.bin' : file.name.replaceAll('/', '_');
        final tempFile = File('${tempDir.path}/$safeName');
        await tempFile.writeAsBytes(bytes, flush: true);
        path = tempFile.path;
      }

      setState(() {
        _filePath = path;
        _filename = file.name.isEmpty ? path!.split('/').last : file.name;
      });
    } catch (e) {
      showToastNotification(
        title: "Error",
        body: e.toString(),
        messageType: ToastificationType.error,
      );
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _submit() async {
    if (_submitting) return;
    final path = _filePath;
    final name = _filename;
    if (path == null || name == null || name.isEmpty) {
      showToastNotification(
        title: "Oops",
        body: "Please pick a file first",
        messageType: ToastificationType.info,
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      final success = await widget.onUpload(
        filePath: path,
        filename: name,
        type: _type,
        analyze: _analyze,
      );
      if (success && (Get.isDialogOpen ?? false)) {
        Get.back();
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.w20,
        vertical: AppSizes.h20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: AppColors.scaffoldBg,
      title: Text(
        "Upload document",
        style: AppTextStyles.geistNormalBold.copyWith(
          color: AppColors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: RElevatedButton(
                label: _picking ? "Opening..." : "Pick file",
                isLoading: _picking,
                onPressed: _pickFile,
              ),
            ),
            AppGaps.h16,
            Text(
              _filename ?? "No file selected",
              style: AppTextStyles.geistNormalLight.copyWith(
                color: AppColors.black,
              ),
            ),
            AppGaps.h20,
            Text(
              "Type",
              style: AppTextStyles.geistSmallBold.copyWith(
                color: AppColors.black,
                letterSpacing: 1.1,
              ),
            ),
            AppGaps.h8,
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w12,
                  vertical: AppSizes.h10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: AppColors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _type,
                  isExpanded: true,
                  items: DocumentTypes.all
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: AppTextStyles.geistNormalLight.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: _submitting
                      ? null
                      : (value) {
                          if (value == null) return;
                          setState(() => _type = value);
                        },
                ),
              ),
            ),
            AppGaps.h12,
            Material(
              color: AppColors.white,
              child: InkWell(
                onTap: _submitting
                    ? null
                    : () => setState(() => _analyze = !_analyze),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.w12,
                    vertical: AppSizes.h12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.black),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Analyze with AI",
                              style: AppTextStyles.geistNormalBold.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            AppGaps.h4,
                            Text(
                              "Run Gemini on this file after upload",
                              style: AppTextStyles.geistSmallLight.copyWith(
                                color: AppColors.black4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Checkbox(
                        value: _analyze,
                        activeColor: AppColors.primary,
                        checkColor: AppColors.white,
                        side: const BorderSide(
                          color: AppColors.black,
                          width: 1.5,
                        ),
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.primary;
                          }
                          return AppColors.white;
                        }),
                        onChanged: _submitting
                            ? null
                            : (value) =>
                                setState(() => _analyze = value ?? false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppGaps.h20,
            Row(
              children: [
                Expanded(
                  child: RElevatedButton(
                    label: "Cancel",
                    onPressed: _submitting ? null : () => Get.back(),
                  ),
                ),
                AppGaps.w15,
                Expanded(
                  child: RElevatedButton(
                    label: "Upload",
                    isLoading: _submitting,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
