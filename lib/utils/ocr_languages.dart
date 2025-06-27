import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:smart_scan/app/dependency_injection.dart';
import 'package:smart_scan/features/home/cubits/cubits.dart';

final supportedOcrLanguages = <String, String>{
  'en': 'English',
  'es': 'Spanish',
  'fr': 'French',
  'de': 'German',
  'pt': 'Portuguese',
  'it': 'Italian',
  'ko': 'Korean',
  /* 'zh': 'Chinese', */
  /* 'ja': 'Japanese', */
  /* 'hi': 'Hindi', */
};

final availableScripts = <TextRecognitionScript>{
  // Add here only the ones you have in `build.gradle`.
  TextRecognitionScript.latin,
  TextRecognitionScript.korean,
};

TextRecognitionScript? getScriptForLanguage() {
  final cubit = getIt.get<SettingsCubit>();
  final langCode = cubit.state.ocrLanguage;
  final script = switch (langCode.toLowerCase()) {
    'zh' => TextRecognitionScript.chinese,
    'ja' => TextRecognitionScript.japanese,
    'ko' => TextRecognitionScript.korean,
    'hi' => TextRecognitionScript.devanagiri,
    _ => TextRecognitionScript.latin,
  };

  return availableScripts.contains(script) ? script : null;
}
