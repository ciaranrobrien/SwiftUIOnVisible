/**
*  SwiftUIOnVisible
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public extension View {
    @inlinable func onVisible<ID>(
        _ id: ID.Type,
        padding: CGFloat = .zero,
        safeAreaEdges: Edge.Set = .all,
        action: @escaping (_ id: ID, _ isVisible: Bool) -> Void
    ) -> some View
    where ID : Hashable
    {
        onVisible(
            id,
            insets: .init(top: padding, leading: padding, bottom: padding, trailing: padding),
            safeAreaEdges: safeAreaEdges,
            action: action
        )
    }
    
    func onVisible<ID>(
        _ id: ID.Type,
        insets: EdgeInsets,
        safeAreaEdges: Edge.Set = .all,
        action: @escaping (_ id: ID, _ isVisible: Bool) -> Void
    ) -> some View
    where ID : Hashable
    {
        modifier(VisibleModifier(action: action, insets: insets, safeAreaEdges: safeAreaEdges))
    }
    
    @inlinable func onVisible(
        padding: CGFloat = .zero,
        safeAreaEdges: Edge.Set = .all,
        action: @escaping (_ id: AnyHashable, _ isVisible: Bool) -> Void
    ) -> some View {
        onVisible(
            AnyHashable.self,
            insets: .init(top: padding, leading: padding, bottom: padding, trailing: padding),
            safeAreaEdges: safeAreaEdges,
            action: action
        )
    }
    
    @inlinable func onVisible(
        insets: EdgeInsets,
        safeAreaEdges: Edge.Set = .all,
        action: @escaping (_ id: AnyHashable, _ isVisible: Bool) -> Void
    ) -> some View
    {
        onVisible(AnyHashable.self, insets: insets, safeAreaEdges: safeAreaEdges, action: action)
    }
}
