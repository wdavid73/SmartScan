import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void toggleOcr(bool enabled) {
    emit(state.copyWith(ocrEnabled: enabled));
  }

  void setOcrLanguage(String language) {
    emit(state.copyWith(ocrLanguage: language));
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState(
      ocrEnabled: json['ocrEnabled'] as bool? ?? true,
      ocrLanguage: json['ocrLanguage'] as String? ?? 'es',
    );
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    return {
      'ocrEnabled': state.ocrEnabled,
      'ocrLanguage': state.ocrLanguage,
    };
  }
}
