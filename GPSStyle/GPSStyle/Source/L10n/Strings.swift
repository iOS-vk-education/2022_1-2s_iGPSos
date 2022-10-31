// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// GPSStyle
  internal static let appName = L10n.tr("ru", "appName", fallback: "GPSStyle")
  /// %@ %@ года
  internal static func calendarTitle(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("ru", "calendarTitle", String(describing: p1), String(describing: p2), fallback: "%@ %@ года")
  }
  /// Одежда
  internal static let cloth = L10n.tr("ru", "cloth", fallback: "Одежда")
  /// На сегодня образа нет 😞
  /// 👇 Создайте его👇
  internal static let emptyHomeTitle = L10n.tr("ru", "emptyHomeTitle", fallback: "На сегодня образа нет 😞\n👇 Создайте его👇")
  /// Произошла ошибочка 😞
  /// 👇 Попробуй еще раз👇
  internal static let errorHomeTitle = L10n.tr("ru", "errorHomeTitle", fallback: "Произошла ошибочка 😞\n👇 Попробуй еще раз👇")
  /// Localizable.strings
  ///   GPSStyle
  /// 
  ///   Created by Ivan Gorshkov on 22.10.2022.
  internal static let main = L10n.tr("ru", "main", fallback: "Главная")
  /// Перезагрузить
  internal static let reload = L10n.tr("ru", "reload", fallback: "Перезагрузить")
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
