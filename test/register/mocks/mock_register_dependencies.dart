import 'package:smart_scan/features/auth/auth.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthState extends Fake implements AuthState {}
