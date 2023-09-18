//
//  Candidates.swift
//  Lesson08
//
//  Created by Sasutski on 29/8/23.
//

import SwiftUI

struct Candidates: Identifiable, Equatable, Hashable {
    var name: String
    var age: Int
    var specialities: String
    var scandals: Int
    var id = UUID()
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
