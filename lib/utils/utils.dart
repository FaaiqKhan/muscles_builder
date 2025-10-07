import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Utils {
  Utils._();

  static void licenseRegistrySetup() {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }
}
