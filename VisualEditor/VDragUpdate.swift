//
//  VDragUpdate.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-27.
//

import SwiftUI



struct VDragUpdate: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero

    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 100, height: 100)
            .opacity(dragOffset.width == 0 && dragOffset.height == 0 ? 1 : 0.5)
            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        self.position.height += value.translation.height
                        self.position.width += value.translation.width
                    }
            )
    }
}
