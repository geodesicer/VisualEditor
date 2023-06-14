//
//  VDraggableRect.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-23.
//

import SwiftUI



struct VDraggableRect1: View {
    @GestureState private var dragState = EDragState.inactive
    @Binding var rectPosition: CGSize

    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
                print("value.translation = \(value.translation)")
            }
            .onEnded { value in
                self.rectPosition.width += value.translation.width
                self.rectPosition.height += value.translation.height
            }

        return Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .offset(x: self.rectPosition.width + self.dragState.translation.width, y: self.rectPosition.height + self.dragState.translation.height)
            .gesture(drag)
    }
}

