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
