// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let black = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#606060"></span>
  /// Alpha: 100% <br/> (0x606060ff)
  internal static let darkGrey = ColorName(rgbaValue: 0x606060ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a3a3a3"></span>
  /// Alpha: 100% <br/> (0xa3a3a3ff)
  internal static let lightGrey = ColorName(rgbaValue: 0xa3a3a3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fae8fc"></span>
  /// Alpha: 100% <br/> (0xfae8fcff)
  internal static let lightPink = ColorName(rgbaValue: 0xfae8fcff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9a55a0"></span>
  /// Alpha: 100% <br/> (0x9a55a0ff)
  internal static let mainPurple = ColorName(rgbaValue: 0x9a55a0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#aa9cab"></span>
  /// Alpha: 100% <br/> (0xaa9cabff)
  internal static let secondPurple = ColorName(rgbaValue: 0xaa9cabff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  internal static let white = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map { CGFloat($0 & 0xff) }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
