import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manifesto/common/resources/app_resources/app_colors.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/resources/app_resources/app_text_styles.dart';
import 'package:manifesto/common/widgets/shadow_container.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';

class DocumentListItem extends StatelessWidget {
  final DocumentEntity document;
  final VoidCallback? onTap;

  const DocumentListItem({
    super.key,
    required this.document,
    this.onTap,
  });

  String get _sizeLabel {
    final bytes = document.sizeBytes;
    if (bytes <= 0) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String get _updatedLabel {
    final raw = document.updatedAt;
    if (raw == null || raw.isEmpty) return '';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat('MMM d, yyyy').format(parsed.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    final type = document.type?.trim();
    final metaParts = <String>[
      if (_sizeLabel.isNotEmpty) _sizeLabel,
      if (_updatedLabel.isNotEmpty) _updatedLabel,
    ];

    return Semantics(
      button: true,
      label: document.filename,
      child: GestureDetector(
        onTap: onTap,
        child: RShadowContainer(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w20,
              vertical: AppSizes.h20,
            ),
            color: AppColors.white,
            child: Column(
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
                  AppGaps.h4,
                ],
                Text(
                  document.filename,
                  style: AppTextStyles.geistExtraExtraLargeExtraBold.copyWith(
                    height: 1.1,
                    letterSpacing: -0.5,
                    fontSize: AppSizes.f24,
                    color: AppColors.black,
                  ),
                ),
                if (metaParts.isNotEmpty) ...[
                  AppGaps.h12,
                  Text(
                    metaParts.join(' · '),
                    style: AppTextStyles.geistSmallLight.copyWith(
                      color: AppColors.black3,
                    ),
                  ),
                ],
                if (document.recommendationsText != null &&
                    document.recommendationsText!.trim().isNotEmpty) ...[
                  AppGaps.h12,
                  Text(
                    "AI ANALYSIS READY",
                    style: AppTextStyles.geistSmallBold.copyWith(
                      letterSpacing: 1.2,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
