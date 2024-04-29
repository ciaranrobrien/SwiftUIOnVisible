/**
*  SwiftUIOnVisible
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public extension View {
    func visibleID(_ id: some Hashable) -> some View {
        anchorPreference(key: VisibleAnchorsKey.self, value: .bounds) { [id : $0] }
    }
}
