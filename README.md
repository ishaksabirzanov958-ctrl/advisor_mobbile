# Advisor Mobile (Flutter)

Backend'дин (Spring Boot) үстүнөн курулган мобилдик колдонмо: катталуу,
жеке окуу планы (roadmap) жана HH.ru'дан вакансия издөө.

## 1-баскыч: Flutter орнотуу

Мак'та:

```bash
brew install --cask flutter
flutter doctor
```

`flutter doctor` бардык талап кылынган нерселерди (Xcode, Android Studio,
CocoaPods ж.б.) текшерет жана эмне жетишпей жатканын көрсөтөт — ошолорду
орнотуп бүтүрүү керек.

## 2-баскыч: Долбоорду ачуу жана пакеттерди орнотуу

```bash
cd advisor_mobile
flutter pub get
```

## 3-баскыч: Backend дарегин жаздыруу

`lib/config/api_config.dart` файлын ач жана `baseUrl`'ди туура кой:

- **Локалдык тест үчүн** (эмулятор/телефон компьютер менен бир Wi-Fi'де):
  компьютериңдин локалдык IP-дарегин жаз (мисалы `http://192.168.1.50:8080`).
  IP-дарегиңди билиш үчүн: `ifconfig | grep "inet "` (Mac).
- **Чыныгы серверге чыгарганда**: чыныгы дарек, мисалы `https://api.advisor.kg`.

## 4-баскыч: Иштетип көрүү

Эмулятор же туташкан телефон менен:

```bash
flutter run
```

## 5-баскыч: Play Market'ке чыгаруу (Android)

1. Google Play Console'до аккаунт ач ($25, бир жолку төлөм): https://play.google.com/console
2. Колдонмонун "signing key" ачкычын түз:
   ```bash
   keytool -genkey -v -keystore ~/advisor-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias advisor
   ```
3. `android/key.properties` файлын түз (Flutter документациясындагы үлгү боюнча).
4. Релиз build жаса:
   ```bash
   flutter build appbundle --release
   ```
5. `build/app/outputs/bundle/release/app-release.aab` файлын Play Console'го жүктө.
6. Колдонмонун сүрөттөлүшүн, скриншотторун, Privacy Policy шилтемесин толтур.
7. Текшерүүгө жиберип, жыйынтыгын күт (адатта 1-3 күн).

## 6-баскыч: App Store'го чыгаруу (iOS)

**Мак жана Xcode милдеттүү керек.**

1. Apple Developer Program'га катал ($99/жыл): https://developer.apple.com/programs/
2. Xcode'до долбоорду ач:
   ```bash
   open ios/Runner.xcworkspace
   ```
3. Xcode ичинде "Signing & Capabilities" бөлүмүнөн команданы (Team) тандап,
   Bundle Identifier'ди уникалдуу кыл (мисалы `kg.advisor.mobile`).
4. App Store Connect'те жаңы колдонмо түз: https://appstoreconnect.apple.com
5. Xcode'до Archive жаса (Product → Archive), андан кийин
   "Distribute App" аркылуу App Store Connect'ке жүктө.
6. App Store Connect'те сүрөттөлүшүн, скриншотторду, Privacy Policy'ди толтур.
7. "Submit for Review" бас, текшерүүнү күт (адатта 1-2 күн).

## Милдеттүү нерсе: Privacy Policy

Экөө тең (Google жана Apple) Privacy Policy шилтемесин талап кылат — бул
жөнөкөй веб-баракча болушу мүмкүн, анда колдонмо кайсы маалыматты (email,
резюме тексти) чогултканы жана кантип колдонгону жазылган болушу керек.
Муну GitHub Pages же жөнөкөй статикалык баракча катары акысыз жайгаштырса болот.

## Иштелип чыгуучу түзүлүш

```
lib/
├── main.dart                    # колдонмонун кирүү чекити
├── config/
│   └── api_config.dart          # backend'дин дареги жана Basic Auth маалыматы
├── models/
│   ├── vacancy.dart              # HH.ru вакансиясынын Dart модели
│   └── roadmap_response.dart     # окуу планынын Dart модели
├── services/
│   ├── auth_service.dart         # катталуу үчүн backend'ге сурам
│   ├── roadmap_service.dart      # roadmap түзүү үчүн backend'ге сурам
│   └── job_service.dart          # вакансия издөө үчүн backend'ге сурам
└── screens/
    ├── register_screen.dart      # катталуу экраны
    ├── home_screen.dart          # таб'дар менен башкы экран
    ├── roadmap_screen.dart       # окуу планы экраны
    └── job_search_screen.dart    # вакансия издөө экраны
```
