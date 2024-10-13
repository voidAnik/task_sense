import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_sense/app/app.dart';
import 'package:task_sense/core/injection/injection_container.dart' as di;
import 'package:task_sense/core/language/app_language.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();

  // register google fonts fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Sigmar-OFL.txt');
    final license2 =
        await rootBundle.loadString('assets/fonts/Poppins-OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    yield LicenseEntryWithLineBreaks(['google_fonts'], license2);
  });
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(EasyLocalization(
      supportedLocales: AppLanguage.all,
      path: AppLanguage.path,
      fallbackLocale: AppLanguage.english,
      startLocale: AppLanguage.english,
      child: const App()));
}
