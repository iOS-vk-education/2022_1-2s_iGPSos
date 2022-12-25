//
//  Once.swift
//  GPSStyle
//
//  Created by Ivan Gorshkov on 26.12.2022.
//

import Foundation

class Once {
  var already: Bool = false

  func run(block: () -> Void) {
    guard !already else { return }

    block()
    already = true
  }
}
