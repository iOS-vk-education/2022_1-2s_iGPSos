// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Сохранить
  internal static let add = L10n.tr("ru", "add", fallback: "Сохранить")
  /// Добавить фото
  internal static let addPhoto = L10n.tr("ru", "addPhoto", fallback: "Добавить фото")
  /// Уже есть аккаунт?
  internal static let alreadyHaveAccount = L10n.tr("ru", "alreadyHaveAccount", fallback: "Уже есть аккаунт?")
  /// GPSStyle
  internal static let appName = L10n.tr("ru", "appName", fallback: "GPSStyle")
  /// Брэнд
  internal static let brand = L10n.tr("ru", "brand", fallback: "Брэнд")
  /// %@ %@ года
  internal static func calendarTitle(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("ru", "calendarTitle", String(describing: p1), String(describing: p2), fallback: "%@ %@ года")
  }
  /// Назад
  internal static let cancel = L10n.tr("ru", "cancel", fallback: "Назад")
  /// Категория
  internal static let category = L10n.tr("ru", "category", fallback: "Категория")
  /// Изменить фото
  internal static let changePhoto = L10n.tr("ru", "changePhoto", fallback: "Изменить фото")
  ///    Отслеживать погоду
  internal static let checkTheWeather = L10n.tr("ru", "checkTheWeather", fallback: "   Отслеживать погоду")
  /// Выбрать фото
  internal static let choosePhoto = L10n.tr("ru", "choosePhoto", fallback: "Выбрать фото")
  /// Одежда
  internal static let cloth = L10n.tr("ru", "cloth", fallback: "Одежда")
  /// Название
  internal static let clothesName = L10n.tr("ru", "clothesName", fallback: "Название")
  /// Фото одежды
  internal static let clothesPhoto = L10n.tr("ru", "clothesPhoto", fallback: "Фото одежды")
  /// Цвет
  internal static let color = L10n.tr("ru", "color", fallback: "Цвет")
  /// Создать аккаунт
  internal static let createAccount = L10n.tr("ru", "createAccount", fallback: "Создать аккаунт")
  /// Создать
  internal static let createClothes = L10n.tr("ru", "createClothes", fallback: "Создать")
  /// Создать встречу
  internal static let createMeeting = L10n.tr("ru", "createMeeting", fallback: "Создать встречу")
  /// Удалить фото
  internal static let deletePhoto = L10n.tr("ru", "deletePhoto", fallback: "Удалить фото")
  /// Почта
  internal static let email = L10n.tr("ru", "email", fallback: "Почта")
  /// На сегодня встреч нет 😞
  /// 👇 Создайте его👇
  internal static let emptyHomeTitle = L10n.tr("ru", "emptyHomeTitle", fallback: "На сегодня встреч нет 😞\n👇 Создайте его👇")
  /// У тебя пока нет образов 😞
  /// 👇 Создайте его👇
  internal static let emptyLookTitle = L10n.tr("ru", "emptyLookTitle", fallback: "У тебя пока нет образов 😞\n👇 Создайте его👇")
  /// Произошла ошибочка 😞
  /// 👇 Попробуй еще раз👇
  internal static let errorTitle = L10n.tr("ru", "errorTitle", fallback: "Произошла ошибочка 😞\n👇 Попробуй еще раз👇")
  /// Как бы вы хотели добавить фото
  internal static let howAddPhoto = L10n.tr("ru", "howAddPhoto", fallback: "Как бы вы хотели добавить фото")
  /// Войти
  internal static let login = L10n.tr("ru", "login", fallback: "Войти")
  /// Образ
  internal static let look = L10n.tr("ru", "look", fallback: "Образ")
  /// Образы
  internal static let looks = L10n.tr("ru", "looks", fallback: "Образы")
  /// Localizable.strings
  ///   GPSStyle
  /// 
  ///   Created by Ivan Gorshkov on 22.10.2022.
  internal static let main = L10n.tr("ru", "main", fallback: "Главная")
  /// Имя
  internal static let name = L10n.tr("ru", "name", fallback: "Имя")
  /// Пароль
  internal static let password = L10n.tr("ru", "password", fallback: "Пароль")
  /// Профиль
  internal static let profile = L10n.tr("ru", "profile", fallback: "Профиль")
  /// Перезагрузить
  internal static let reload = L10n.tr("ru", "reload", fallback: "Перезагрузить")
  ///    Повторять каждую неделю
  internal static let repeatEveryWeek = L10n.tr("ru", "repeatEveryWeek", fallback: "   Повторять каждую неделю")
  /// Выберите 
  internal static let selectCharacteristic = L10n.tr("ru", "selectCharacteristic", fallback: "Выберите ")
  /// Выберите
  internal static let selectCharacteristicButton = L10n.tr("ru", "selectCharacteristicButton", fallback: "Выберите")
  /// Выйти
  internal static let signOut = L10n.tr("ru", "signOut", fallback: "Выйти")
  /// Размер
  internal static let size = L10n.tr("ru", "size", fallback: "Размер")
  /// Cделать фото
  internal static let takePhoto = L10n.tr("ru", "takePhoto", fallback: "Cделать фото")
  /// Время и дата
  internal static let timedate = L10n.tr("ru", "timedate", fallback: "Время и дата")
  /// Название
  internal static let title = L10n.tr("ru", "title", fallback: "Название")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
