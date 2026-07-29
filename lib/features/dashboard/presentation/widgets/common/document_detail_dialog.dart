import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';

class DocumentDetailDialog {
  static Future<void> show({
    required DocumentEntity document,
  }) {
    return Get.dialog(
      _DocumentDetailDialogBody(initialDocument: document),
      barrierDismissible: true,
    );
  }
}

class _DocumentDetailDialogBody extends StatefulWidget {
  final DocumentEntity initialDocument;

  const _DocumentDetailDialogBody({required this.initialDocument});

  @override
  State<_DocumentDetailDialogBody> createState() =>
      _DocumentDetailDialogBodyState();
}

class _DocumentDetailDialogBodyState extends State<_DocumentDetailDialogBody> {
  late DocumentEntity _document;
  bool _deleting = false;

  DashboardController get _controller => Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
    _document = widget.initialDocument;
  }

  String get _sizeLabel {
    final bytes = _document.sizeBytes;
    if (bytes <= 0) return 'Unknown size';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String get _updatedLabel {
    final raw = _document.updatedAt;
    if (raw == null || raw.isEmpty) return 'Unknown date';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat('MMM d, yyyy · h:mm a').format(parsed.toLocal());
  }

  Future<void> _analyze() async {
    final updated = await _controller.analyzeDocument(_document);
    if (updated != null && mounted) {
      setState(() => _document = updated);
    }
  }

  Future<void> _download() async {
    await _controller.downloadDocument(_document);
  }

  Future<void> _confirmDelete() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.w20,
          vertical: AppSizes.h20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        backgroundColor: AppColors.scaffoldBg,
        title: Text(
          "Delete document?",
          style: AppTextStyles.geistNormalBold.copyWith(
            color: AppColors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "This removes ${_document.filename} from your archive.",
              style: AppTextStyles.geistNormalLight.copyWith(
                color: AppColors.black,
              ),
            ),
            AppGaps.h30,
            Row(
              children: [
                Expanded(
                  child: RElevatedButton(
                    label: "Cancel",
                    onPressed: () => Get.back(result: false),
                  ),
                ),
                AppGaps.w15,
                Expanded(
                  child: RElevatedButton(
                    label: "Delete",
                    onPressed: () => Get.back(result: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;
    setState(() => _deleting = true);
    final deleted = await _controller.deleteDocument(_document.id);
    if (!mounted) return;
    setState(() => _deleting = false);
    if (deleted && (Get.isDialogOpen ?? false)) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = _document.type?.trim();
    final recommendations = _document.recommendationsText?.trim();
    final hasAnalysis = recommendations != null && recommendations.isNotEmpty;

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
        "Document",
        style: AppTextStyles.geistNormalBold.copyWith(
          color: AppColors.black,
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: AppSizes.w360,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (type != null && type.isNotEmpty) ...[
                Text(
                  type.toUpperCase(),
                  style: AppTextStyles.geistNormalBold.copyWith(
                    letterSpacing: 1.4,
                    color: AppColors.primary,
                  ),
                ),
                AppGaps.h8,
              ],
              Text(
                _document.filename,
                style: AppTextStyles.geistLargeBold.copyWith(
                  color: AppColors.black,
                ),
              ),
              AppGaps.h12,
              Text(
                _sizeLabel,
                style: AppTextStyles.geistSmallLight.copyWith(
                  color: AppColors.black3,
                ),
              ),
              AppGaps.h4,
              Text(
                _updatedLabel,
                style: AppTextStyles.geistSmallLight.copyWith(
                  color: AppColors.black3,
                ),
              ),
              if (_document.contentType.isNotEmpty) ...[
                AppGaps.h4,
                Text(
                  _document.contentType,
                  style: AppTextStyles.geistSmallLight.copyWith(
                    color: AppColors.black3,
                  ),
                ),
              ],
              AppGaps.h24,
              Text(
                "AI ANALYSIS",
                style: AppTextStyles.geistSmallBold.copyWith(
                  letterSpacing: 1.2,
                  color: AppColors.primary,
                ),
              ),
              AppGaps.h8,
              if (hasAnalysis)
                Text(
                  recommendations,
                  style: AppTextStyles.geistNormalLight.copyWith(
                    color: AppColors.black,
                    height: 1.4,
                  ),
                )
              else
                Text(
                  "No analysis yet. Run analyze to generate recommendations.",
                  style: AppTextStyles.geistNormalLight.copyWith(
                    color: AppColors.black3,
                  ),
                ),
              if (_document.analysisModel != null &&
                  _document.analysisModel!.isNotEmpty) ...[
                AppGaps.h8,
                Text(
                  "Model: ${_document.analysisModel}",
                  style: AppTextStyles.geistSmallLight.copyWith(
                    color: AppColors.black3,
                  ),
                ),
              ],
              AppGaps.h30,
              Obx(() {
                final analyzing = _controller.state.analyzingDocument.value &&
                    _controller.state.analyzingDocId.value == _document.id;
                final downloading =
                    _controller.state.downloadingDocument.value &&
                        _controller.state.downloadingDocId.value ==
                            _document.id;
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: RElevatedButton(
                        label: hasAnalysis ? "Re-analyze" : "Analyze",
                        isLoading: analyzing,
                        onPressed: analyzing || downloading || _deleting
                            ? null
                            : _analyze,
                      ),
                    ),
                    AppGaps.h15,
                    SizedBox(
                      width: double.infinity,
                      child: RElevatedButton(
                        label: "Download",
                        isLoading: downloading,
                        onPressed: analyzing || downloading || _deleting
                            ? null
                            : _download,
                      ),
                    ),
                    AppGaps.h15,
                    SizedBox(
                      width: double.infinity,
                      child: RElevatedButton(
                        label: "Delete",
                        isLoading: _deleting,
                        onPressed: analyzing || downloading || _deleting
                            ? null
                            : _confirmDelete,
                      ),
                    ),
                    if (analyzing || downloading || _deleting) ...[
                      AppGaps.h16,
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.primary,
                        size: AppSizes.v24,
                      ),
                    ],
                    AppGaps.h15,
                    SizedBox(
                      width: double.infinity,
                      child: RElevatedButton(
                        label: "Close",
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
