//
//  ViewModifiers.swift
//  Compositional Layout Demo (iOS)
//
//  Created by Sai Nikhit Gulla on 04/01/21.
//

import SwiftUI


struct ContextModifier: ViewModifier {
    var card: Card
    
    func body(content: Content) -> some View {
        content
            .contextMenu(menuItems: {
                Text("By \(card.author)")
            })
            .contentShape(RoundedRectangle(cornerRadius: 5.0))
    }
}
