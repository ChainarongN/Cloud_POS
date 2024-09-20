# Cloud_pos

# Run

- flutter pub get
- flutter run
- flutter run --release
  if you need run flutter run --release. you must config Build appbundle file (for deploy to store) 1 and 2

# Build apk file

- flutter build apk --release
- path of .apk "build\app\outputs\flutter-apk\app-release.apk"

# Build appbundle file (for deploy to store)

1. set file "key.jks" to "android\key.jks"

- If lost, you must create new .jks file --> "https://docs.flutter.dev/deployment/android"

2. create file key.properties in path "android\key.properties"

- add this text to "key.properties"
  storePassword=vtecsystem
  keyPassword=vtecsystem
  keyAlias=key
  storeFile=C:/Github/CloudPos/android/key.jks

- "storeFile is path of .jks file"

3.  go to "android\local.properties"

- change "flutter.versionName" , "flutter.versionCode"
- if "flutter.versionName" = 1.0.0 change to [1.0.1,1.0.2,1.0.3 ... 1.0.9,1.1.1,1.1.2]
- if "flutter.versionCode" = 1 change to [2,3,4,5 ... 100,101,102]

4. flutter build appbundle --release

5. deploy file .aab to store and wait review 3-5 day

- path of .aab "build\app\outputs\bundle\release\app-release.aab"

# Easy_localization

1. set json string in this file:

- assets\translations\en.json
- assets\translations\th.json

2. code genarage :

- flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
- flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_key.g.dart" -f keys

3. how to use :

- print(LocaleKeys.title.tr()); // for test print
- Text(LocaleKeys.title).tr(); // for widget

4. how to set locale language :

- await context.setLocale(Locale('en')); // 'en' or 'th'

# Library

1. cupertino_icons: ^1.0.2 (is default lib flutter)
2. provider: ^6.1.1

- State management
- reference : "https://docs.flutter.dev/data-and-backend/state-mgmt/simple"
- reference : "https://pub.dev/packages/provider"
- import 'package:provider/provider.dart';

3. dropdown_button2: ^2.3.9

- for dropdown
- reference : "https://pub.dev/packages/dropdown_button2"
- import 'package:dropdown_button2/dropdown_button2.dart';

4. flutter_slidable: ^3.0.1

- slidable for ui manage menu
- reference : "https://pub.dev/packages/flutter_slidable/install"
- import 'package:flutter_slidable/flutter_slidable.dart';

5. dio: ^5.4.1

- connect and call api
- reference : "https://pub.dev/packages/dio"
- import 'package:dio/dio.dart';

6. shared_preferences: ^2.2.2

- for set variable
- reference : "https://pub.dev/packages/shared_preferences"
- reference : "https://medium.com/@ndubuisiaso/shared-preferences-in-flutter-a-guide-with-a-demonstrative-app-e03582ccce9a"
- import 'package:shared_preferences/shared_preferences.dart';

7. material_dialogs: ^1.1.4

- for dialog animation
- reference : "https://pub.dev/packages/material_dialogs"
- import 'package:material_dialogs/material_dialogs.dart';

8. path_provider: ^2.1.2

- Get and Set Directory file path
- reference : "https://pub.dev/packages/path_provider"
- reference : "https://medium.com/@flutternewshub/unlocking-file-system-access-with-path-provider-a-comprehensive-guide-for-flutter-developers-356644908d5a"
- import 'package:path_provider/path_provider.dart';

9. url_launcher: ^6.3.0

- for test launch Url
- reference : "https://pub.dev/packages/url_launcher"
- import 'package:url_launcher/url_launcher.dart';

10. loading_animation_widget: ^1.2.0+4

- Loading animetion dialog
- reference : "https://pub.dev/packages/loading_animation_widget"
- import 'package:loading_animation_widget/loading_animation_widget.dart';

11. uuid: ^4.3.3

- Generator UUID
- reference : "https://pub.dev/packages/uuid"
- import 'package:uuid/uuid.dart';

12. easy_localization: ^3.0.3

- manage language
- reference : "https://pub.dev/packages/easy_localization"
- reference : "https://medium.com/@rysesoft/easy-localization-with-flutter-d8ad10c5e4da"
- import 'package:easy_localization/easy_localization.dart';

13. cloud_firestore: ^4.15.3

- firebase
- reference : "https://pub.dev/packages/cloud_firestore"
- import 'package:cloud_firestore/cloud_firestore.dart';

14. package_info_plus:

- get all platform version
- reference : "https://pub.dev/packages/package_info_plus"
- import 'package:package_info_plus/package_info_plus.dart';

15. firebase_core: ^2.25.4

- firebase
- reference : "https://pub.dev/packages/firebase_core"
- import 'package:firebase_core/firebase_core.dart';

16. lottie: ^2.7.0

- json animation
- reference : "https://pub.dev/packages/lottie"
- import 'package:lottie/lottie.dart';

17. screenshot: ^2.1.0

- screenshot display
- reference : "https://pub.dev/packages/screenshot"
- import 'package:screenshot/screenshot.dart';

18. flutter_widget_from_html_core: ^0.14.11

- convert html to widget
- reference : "https://pub.dev/packages/flutter_widget_from_html_core"
- import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

19. qr_flutter: ^4.1.0

- convert text to qrcode
- reference : "https://pub.dev/packages/qr_flutter"
- import 'package:qr_flutter/qr_flutter.dart';

20. flutter_multi_formatter: ^2.12.4

- manage format
- reference : "https://pub.dev/packages/flutter_multi_formatter"
- import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

21. cached_network_image: ^3.3.1

- show cached network ui
- reference : "https://pub.dev/packages/cached_network_image"
- import 'package:cached_network_image/cached_network_image.dart';

22. reorderable_grid: ^1.0.10

- change position list animation
- reference : "https://pub.dev/packages/reorderable_grid"
- import 'package:reorderable_grid/reorderable_grid.dart';

23. flutter_timer_countdown: ^1.0.7

- countdown payment
- reference : "https://pub.dev/packages/flutter_timer_countdown/example"
- import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

24. qr_code_scanner: ^1.0.1

- scanner
- reference : "https://pub.dev/packages/qr_code_scanner"
- import 'package:qr_code_scanner/qr_code_scanner.dart';

25. flutter_pos_printer_platform_image_3:

- printer usb
- reference : "https://pub.dev/packages/flutter_pos_printer_platform_image_3"
- reference : "https://github.com/idekorslet/Flutter_and_Thermal_Printer_with_USB_connection"
- reference : "https://www.youtube.com/watch?v=vPEPK_9KSYs"
- import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';

26. esc_pos_printer:

- printer network
- reference : "https://pub.dev/packages/esc_pos_printer"
- import 'package:esc_pos_printer/esc_pos_printer.dart';

27. esc_pos_utils:

- manage config printer
- reference : "https://pub.dev/packages/esc_pos_utils"
- import 'package:esc_pos_utils/esc_pos_utils.dart';

28. image:

- convert file or string to image
- reference : "https://pub.dev/packages/image"
- import 'package:image/image.dart';

29. sunmi_printer_plus:

- printer sunmi
- reference : "https://pub.dev/packages/sunmi_printer_plus"
- import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
