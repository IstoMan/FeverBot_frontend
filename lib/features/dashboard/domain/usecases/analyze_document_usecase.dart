import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class AnalyzeDocumentUseCase
    extends UseCaseWithParams<DocumentEntity, AnalyzeDocumentUseCaseParams> {
  final DashboardRepository repository;

  AnalyzeDocumentUseCase({required this.repository});

  @override
  ResultFuture<DocumentEntity> call(AnalyzeDocumentUseCaseParams params) async {
    return await repository.analyzeDocument(params.document);
  }
}

class AnalyzeDocumentUseCaseParams {
  final DocumentEntity document;

  AnalyzeDocumentUseCaseParams({required this.document});
}
