import 'package:manifesto/common/core/utils/type_def/type_def.dart';
import 'package:manifesto/common/core/utils/use_cases/user_cases.dart';
import 'package:manifesto/features/dashboard/domain/entities/document_entity.dart';
import 'package:manifesto/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDocumentsUseCase extends UseCaseWithoutParams<List<DocumentEntity>> {
  final DashboardRepository repository;

  GetDocumentsUseCase({required this.repository});

  @override
  ResultFuture<List<DocumentEntity>> call() async {
    return await repository.getDocuments();
  }
}
