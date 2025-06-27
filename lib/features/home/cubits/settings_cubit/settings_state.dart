part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool ocrEnabled;
  final String ocrLanguage;

  const SettingsState({
    required this.ocrEnabled,
    required this.ocrLanguage,
  });

  factory SettingsState.initial() => const SettingsState(
        ocrEnabled: true,
        ocrLanguage: 'es',
      );

  SettingsState copyWith({
    bool? ocrEnabled,
    String? ocrLanguage,
  }) {
    return SettingsState(
      ocrEnabled: ocrEnabled ?? this.ocrEnabled,
      ocrLanguage: ocrLanguage ?? this.ocrLanguage,
    );
  }

  @override
  List<Object> get props => [ocrEnabled, ocrLanguage];
}
