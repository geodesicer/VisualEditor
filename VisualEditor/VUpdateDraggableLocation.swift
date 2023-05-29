//
//  VUpdateDraggableLocation.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



struct VUpdateDraggableLocation: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero

    var body: some View {
        VStack {
            Spacer()

            Circle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
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

            Spacer()

            Text("Location: \(Int(position.width + dragOffset.width)), \(Int(position.height + dragOffset.height))")
        }
    }
}

