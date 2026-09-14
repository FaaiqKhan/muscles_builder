# Fix release crash on startup:
#   java.lang.RuntimeException: Failed to create an instance of androidx.work.impl.WorkDatabase
# WorkManager (pulled in transitively by google_mobile_ads) creates its Room
# database implementation (androidx.work.impl.WorkDatabase_Impl) via
# reflection. Room's own consumer proguard rule only keeps the abstract
# RoomDatabase subclass, not its generated *_Impl constructor, so R8 was
# stripping the no-arg constructor as seemingly unused and instantiation
# failed at runtime with InstantiationException. Keep WorkManager's Room
# classes and their constructors intact.
-keep class * extends androidx.room.RoomDatabase {
    public <init>();
}
-keep class androidx.work.impl.** { *; }
-dontwarn androidx.work.**
