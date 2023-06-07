//
//  VDraggableRect3.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



struct VDraggableRect3: View {
    @GestureState public var dragState = EDragState.inactive
    @Binding var bPos: CGPoint
    @State private var pos = CGPoint.zero
    var color: Color
    
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
                print("state = \(state)'")
            }
            .onChanged { value in
                self.bPos.x = value.translation.width
                self.bPos.y = value.translation.height
            }
            .onEnded { value in
                self.pos.x += value.translation.width
                self.pos.y += value.translation.height
            }
        
        return GeometryReader { geometry in
            Rectangle()
                .fill(color)
                .frame(width: 100, height: 100)
                .offset(x: self.pos.x + self.dragState.translation.width, y: self.pos.y + self.dragState.translation.height)
                .gesture(drag)
                .onAppear() {
                    pos = bPos
                }
        }
    }
}
