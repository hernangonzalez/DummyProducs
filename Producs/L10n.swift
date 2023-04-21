// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum General {
    /// Localizable.strings
    ///   Producs
    /// 
    ///   Created by Hernan G. Gonzalez on 21/04/2023.
    internal static let title = L10n.tr("Localizable", "general.title", fallback: "Dummy Products")
  }
  internal enum Product {
    /// Add to cart
    internal static let add = L10n.tr("Localizable", "product.add", fallback: "Add to cart")
    /// Available: %@
    internal static func available(_ p1: Any) -> String {
      return L10n.tr("Localizable", "product.available", String(describing: p1), fallback: "Available: %@")
    }
    /// Price: %@
    internal static func price(_ p1: Any) -> String {
      return L10n.tr("Localizable", "product.price", String(describing: p1), fallback: "Price: %@")
    }
  }
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
