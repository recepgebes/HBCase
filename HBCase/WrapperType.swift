//
//  WrapperType.swift
//  HBCase
//
//  Created by Recep on 25.04.2022.
//

import Foundation

enum WrapperType: String {
    case movie,music,ebook,podcast

    var id: String { self.rawValue }
}

extension WrapperType: CaseIterable, Identifiable, Codable { }
