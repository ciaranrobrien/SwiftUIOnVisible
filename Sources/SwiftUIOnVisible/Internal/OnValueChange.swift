/**
*  SwiftUIOnVisible
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import Combine
import SwiftUI

internal extension View {
    @ViewBuilder
    @inlinable func onValueChange<V>(_ value: V, action: @escaping (V, V) -> Void) -> some View
    where V : Equatable
    {
        if #available(iOS 17, macOS 14, tvOS 17, visionOS 1, watchOS 10, *) {
            self.onChange(of: value, action)
        } else if #available(iOS 14, macOS 11, tvOS 14, watchOS 7, *) {
            self.onChange(of: value) { [oldValue = value] newValue in
                action(oldValue, newValue)
            }
        } else {
            self.onReceive(Just(value)) { [oldValue = value] newValue in
                action(oldValue, newValue)
            }
        }
    }
}
