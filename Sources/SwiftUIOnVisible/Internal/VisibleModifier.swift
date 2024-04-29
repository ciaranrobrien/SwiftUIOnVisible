/**
*  SwiftUIOnVisible
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct VisibleModifier<ID>: ViewModifier
where ID : Hashable
{
    var action: (_ id: ID, _ isVisible: Bool) -> Void
    var insets: EdgeInsets
    var safeAreaEdges: Edge.Set
    
    public func body(content: Content) -> some View {
        content
            .backgroundPreferenceValue(VisibleAnchorsKey.self) { anchors in
                GeometryReader { geometry in
                    let size = geometry.size
                    let frame = CGRect(
                        x: -insets.leading,
                        y: -insets.top,
                        width: size.width + insets.leading + insets.trailing,
                        height: size.height + insets.top + insets.bottom
                    )
                    
                    let ids = anchors.reduce(into: Set<ID>()) { ids, anchor in
                        if frame.intersects(geometry[anchor.value]), let id = anchor.key as? ID {
                            ids.insert(id)
                        }
                    }
                    
                    Color.clear
                        .hidden()
                        .onAppear {
                            for id in ids {
                                action(id, true)
                            }
                        }
                        .onValueChange(ids) { oldValue, newValue in
                            for id in newValue.symmetricDifference(oldValue) {
                                action(id, !oldValue.contains(id))
                            }
                        }
                }
                .edgesIgnoringSafeArea(safeAreaEdges)
            }
    }
}
