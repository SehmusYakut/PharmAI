# Isar specific rules to prevent obfuscation crashes
-keep class com.isar.** { *; }
-keep class * implements io.isar.IsarLink { *; }
-keep class * extends io.isar.IsarCollection { *; }

# Keep models and schemas for serialization
-keep class com.kiraathanelabs.pharmai.data.models.** { *; }

# Flutter/Dart specific ProGuard rules are handled by the Flutter Gradle plugin,
# but we add these for extra safety during extreme obfuscation.
-keep class io.flutter.embedding.engine.FlutterJNI { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.plugin.** { *; }
