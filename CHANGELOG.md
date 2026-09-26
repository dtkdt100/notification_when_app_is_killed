## 0.1.0

* feat: add Swift Package Manager support on iOS
* update: `permission_handler` to `^13.0.0`
* feat: migrate Android plugin to built-in Kotlin (Kotlin DSL, AGP 9)
* feat: redesigned example app
* **BREAKING:** requires Flutter 3.44+ and Dart 3.12+
* **BREAKING:** apps must set `compileSdk = 37` (required by `permission_handler_android` 14)
* update: iOS minimum deployment target to 13.0, Android `minSdk` to 24
* docs: fix `androidIcon` documentation (mipmap resource name)

## 0.0.9

* fix: dart format
* fix: more documentation
* fix: Videos don't work in pub.get README.md
* update: update package dependencies

## 0.0.5

* feat: add support for custom icon on Android

## 0.0.4

* fix: in some devices the notification wasn't working

## 0.0.3

* Improve example with switch to enable/disable notification.
* Support ios interrupt mode.
* Support ios default sound.

## 0.0.2

* Added videos of Android and iOS.
* Updated README.md.
* Fix dart format.

## 0.0.1

* First release: Push notification with title and description when the app is killed.