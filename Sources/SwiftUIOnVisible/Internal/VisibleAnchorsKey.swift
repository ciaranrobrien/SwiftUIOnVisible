/**
*  SwiftUIOnVisible
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct VisibleAnchorsKey: PreferenceKey {
    typealias Value = [AnyHashable : Anchor<CGRect>]
    
    static let defaultValue = Value()
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue()) { $1 }
    }
}
