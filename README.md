# Rick and Morty App

Flutter-приложение для просмотра персонажей из мультсериала "Рик и Морти" с пагинацией, избранным, темами и кешированием.

## Возможности
- Просмотр персонажей Rick and Morty (с пагинацией)
- Добавление персонажей в избранное (сохраняется локально)
- Светлая / Тёмная тема с сохранением выбора
- Кеширование изображений персонажей для повышения производительности
- Навигация через GoRouter с табами

## Начало работы

### Требования
- Flutter SDK (версия указана ниже)
- Настроенная среда разработки Flutter для Windows/macOS/Linux

### Сборка и запуск
1. Установите зависимости:

```pwsh
flutter pub get
```

2. Запустите на доступном устройстве или эмуляторе:

```pwsh
flutter run
```

3. Для сборки release APK (Android):

```pwsh
flutter build apk --release
```

## Версии проекта
- Flutter SDK: ^3.8.1 (см. `pubspec.yaml`)

### Основные зависимости (из `pubspec.yaml`):
- cached_network_image: ^3.4.1
- dartz: ^0.10.1
- dio: ^5.9.0
- equatable: ^2.0.7
- flutter_bloc: ^9.1.1
- go_router: ^16.3.0
- hive: ^2.2.3
- hive_flutter: ^1.1.0
- json_annotation: ^4.9.0
- retrofit: ^4.8.0
- shared_preferences: ^2.3.3

## Примечания
- Проект следует принципам Clean Architecture (разделение на domain / data / presentation слои).
- Сохранение темы использует `SharedPreferences`; кеширование изображений — `cached_network_image`.
