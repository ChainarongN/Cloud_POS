# Cloud_pos

# Easy_localization

code genarage :

- flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
- flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_key.g.dart" -f keys

how to use :

- print(LocaleKeys.title.tr()); //String
- Text(LocaleKeys.title).tr(); //Widget

how to setLocale :

- await context.setLocale(Locale('en'));

# Run

- flutter pub get
- flutter run
