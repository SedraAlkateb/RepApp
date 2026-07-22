# Flutter Engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.autofill.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep line numbers and attributes for clear Crashlytics StackTraces
-keepattributes SourceFile,LineNumberTable,*Annotation*

# Prevent ProGuard from stripping Firebase Crashlytics classes
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# Prevent ProGuard from stripping Firebase Analytics classes
-keep class com.google.firebase.analytics.** { *; }
-dontwarn com.google.firebase.analytics.**
# Ignore missing Play Store SplitInstall classes referenced by Flutter Engine
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Firebase & Crashlytics
-dontwarn com.google.firebase.**