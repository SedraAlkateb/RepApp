# 💊 Domina App

**تطبيق Flutter لإدارة المندوبين الطبيين ميدانياً.**

![Flutter](https://img.shields.io/badge/Flutter-Dart%203-02569B?logo=flutter)
![State](https://img.shields.io/badge/State-BLoC-1E3A5F)
![Architecture](https://img.shields.io/badge/Architecture-Clean-2E7D32)
![Firebase](https://img.shields.io/badge/Firebase-Crashlytics%20%7C%20Analytics-FFCA28?logo=firebase)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS-lightgrey)

## ✨ ماذا يفعل؟

يساعد المندوب على تنظيم زياراته للأطباء والمستشفيات والصيدليات ومتابعة خطته، ويمنح المشرفين أدوات للمتابعة والتقارير.

| 👨‍⚕️ المندوب | 📊 الإشراف والإدارة |
|---|---|
| أدلّة الأطباء والمستشفيات والصيدليات | تقارير الزيارات |
| تسجيل الزيارات | إدارة ومراجعة الخطط |
| متابعة خطة المنتجات | تقرير المخزون |
| الوصفات | البحث وملفات المندوبين |
| إشعارات وتنبيهات | لوحة إدارة |

## 🌟 أبرز النقاط

- **Offline-First:** يعمل ميدانياً حتى مع ضعف الاتصال.
- **بيانات محلية مشفّرة.**
- **Clean Architecture** مع اختبارات آلية تحافظ على حدود الطبقات.
- **مراقبة الأخطاء والاستخدام** عبر Firebase.
- **ثنائي اللغة:** عربي (RTL) وإنجليزي.

## 🏗️ المعمارية

![Architecture](docs/architecture.svg)

```
Page ──event──▶ BLoC ──▶ UseCase ──▶ Repository ──▶ Remote / Local
Page ◀──state── BLoC ◀── Either<Failure, T>
```

## 🧰 التقنيات

| الفئة | الأدوات |
|---|---|
| الحالة والـ DI | `flutter_bloc`, `get_it`, `dartz`, `freezed` |
| الشبكة | `dio`, `retrofit` |
| التخزين | SQLite مشفّرة، `flutter_secure_storage` |
| الواجهة | `flutter_screenutil`, `easy_localization`, `lottie`, `shimmer` |
| الخدمات | Firebase، إشعارات محلية |
| CI/CD | Codemagic |

## 🚀 التشغيل

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## 📸 لقطات الشاشة

| قائمة قائد الفريق | قائمة المندوب |
|:---:|:---:|
| <img src="docs/screenshots/01_team_leader_menu.png" width="260"> | <img src="docs/screenshots/02_rep_menu.png" width="260"> |

| قائمة المندوبين | ملف المندوب | لقطة إضافية |
|:---:|:---:|:---:|
| <img src="docs/screenshots/03_reps_list.png" width="260"> | <img src="docs/screenshots/04_rep_profile_full.png" width="260"> | <img src="docs/screenshots/05_screenshot.jpg" width="260"> |
