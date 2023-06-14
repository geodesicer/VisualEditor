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
         return Rectangle()
                .fill(color)
                .frame(width: 100, height: 100)
                .border(Color.black)
                .offset(x: self.pos.x + self.dragState.translation.width, y: self.pos.y + self.dragState.translation.height)
                .gesture(DragGesture()
                    .updating($dragState) { (value, state, transaction) in
                        state = .dragging(translation: value.translation)
                        //print("state = \(state)'")
                    }
                    .onChanged { value in
                        self.bPos.x = self.pos.x + value.translation.width
                        self.bPos.y = self.pos.y + value.translation.height
                        //print("self.bPos: \(value.translation.description)")
                    }
                    .onEnded { value in
                        self.pos.x += value.translation.width
                        self.pos.y += value.translation.height
                    }
                )
                .onAppear() {
                    pos = bPos
                }
    }
}
