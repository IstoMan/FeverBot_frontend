import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manifesto/common/resources/app_resources/app_gaps.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:manifesto/common/widgets/elevated_button.dart';
import 'package:manifesto/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/document_detail_dialog.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/document_item.dart';
import 'package:manifesto/features/dashboard/presentation/widgets/common/upload_document_dialog.dart';

import '../../../../../common/resources/app_resources/app_colors.dart';
import '../../../../../common/resources/app_resources/app_text_styles.dart';
import '../../../../onboarding/presentation/widgets/description_container.dart';

class DocumentTab extends GetView<DashboardController> {
  const DocumentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => controller.getDocuments(force: true),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppGaps.h20,
                Text(
                  "DOCUMENT",
                  style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.black,
                    height: 1.0,
                  ),
                ),
                Text(
                  "ARCHIVE",
                  style: AppTextStyles.geistExtraExtraLargeRegular.copyWith(
                    fontSize: AppSizes.f48,
                    color: AppColors.primary,
                    height: 1.0,
                  ),
                ),
                AppGaps.h20,
                const DescriptionContainer(
                  data:
                      "Store lab results, prescriptions, and visit notes in one place. Upload a file to analyze or keep it for later.",
                ),
                AppGaps.h30,
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => RElevatedButton(
                      isLoading: controller.state.uploadingDocument.value,
                      onPressed: () => UploadDocumentDialog.show(
                        onUpload: ({
                          required String filePath,
                          required String filename,
                          String? type,
                          bool analyze = false,
                        }) =>
                            controller.uploadDocument(
                          filePath: filePath,
                          filename: filename,
                          type: type,
                          analyze: analyze,
                        ),
                      ),
                      label: 'Upload',
                    ),
                  ),
                ),
                AppGaps.h30,
                Obx(() {
                  final loading = controller.state.loadingDocuments.value;
                  final documents = controller.state.documents;

                  if (loading && documents.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.h40),
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.primary,
                          size: AppSizes.v40,
                        ),
                      ),
                    );
                  }

                  if (documents.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.folder_open_outlined,
                            size: AppSizes.v60,
                            color: AppColors.black.withValues(alpha: 0.35),
                          ),
                          AppGaps.h16,
                          Text(
                            "No documents yet",
                            style: AppTextStyles.geistLargeBold.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          AppGaps.h8,
                          Text(
                            "Upload a lab report, prescription, or scan to get started.",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.geistNormalLight.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      for (var i = 0; i < documents.length; i++) ...[
                        if (i > 0) AppGaps.h20,
                        DocumentListItem(
                          document: documents[i],
                          onTap: () => DocumentDetailDialog.show(
                            document: documents[i],
                          ),
                        ),
                      ],
                    ],
                  );
                }),
                AppGaps.h30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
