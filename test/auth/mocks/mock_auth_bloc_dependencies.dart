import 'package:smart_scan/domain/usecases/auth_usecase.dart';
import 'package:smart_scan/ui/shared/service/service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class MockKeyValueStorageService extends Mock
    implements KeyValueStorageService {}
