import 'package:smart_scan/features/auth/domain/usecases/auth_usecase.dart';
import 'package:smart_scan/core/services/service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class MockKeyValueStorageService extends Mock
    implements KeyValueStorageService {}
