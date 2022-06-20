//
//  FileManager.swift
//  Mumin
//
//  Created by OS on 24.05.2022.
//

import Foundation

public extension FileManager {
  static var documentsDirectoryURL: URL {
    `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

public extension String {
  
  ///Returns an empty string when there is no path.
  func substring(from left: String, to right: String) -> String {
      if let match = range(of: "(?<=\(left))[^\(right)]+", options: .regularExpression) {
          return String(self[match])
      }
      return ""
  }
}

