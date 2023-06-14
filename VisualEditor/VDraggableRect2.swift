//
//  VDraggableRect2.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



struct VDraggableRect2: View {
    @GestureState private var dragState = EDragState.inactive
    @Binding var rectPosition: CGSize

    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
            }
            .onEnded { value in
                self.rectPosition.width += value.translation.width
                self.rectPosition.height += value.translation.height
            }

        return GeometryReader { geometry in
            Rectangle()
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .offset(x: self.rectPosition.width + self.dragState.translation.width, y: self.rectPosition.height + self.dragState.translation.height)
                .gesture(drag)
                .preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
        }
        .onPreferenceChange(FramePreferenceKey.self) { value in
            print("FramePreferenceKey changed")
        }
    }
}
