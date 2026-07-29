import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDocumentUseCase
    extends UseCaseWithParams<DocumentEntity, GetDocumentUseCaseParams> {
  final DashboardRepository repository;

  GetDocumentUseCase({required this.repository});

  @override
  ResultFuture<DocumentEntity> call(GetDocumentUseCaseParams params) async {
    return await repository.getDocument(params.docId);
  }
}

class GetDocumentUseCaseParams {
  final String docId;

  GetDocumentUseCaseParams({required this.docId});
}
