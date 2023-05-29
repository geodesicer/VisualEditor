//
//  VDraggableRect3.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



struct VDraggableRect3: View {
    @GestureState public var dragState = EDragState.inactive
    @Binding var position: CGPoint
    var color: Color
    public var currentPosition: CGSize {
        get { dragState.translation }
    }

    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { (value, state, transaction) in
                state = .dragging(translation: value.translation)
                print("state = \(state)'")
//                self.position.x += value.translation.width
//                self.position.y += value.translation.height
                //self.rectFrame = CGRect(origin: rectPosition, size: CGSize(width: 100, height: 100))
            }
            .onEnded { value in
                self.position.x += value.translation.width
                self.position.y += value.translation.height
            }

        return GeometryReader { geometry in
            Rectangle()
                .fill(color)
                .frame(width: 100, height: 100)
                .offset(x: self.position.x + self.dragState.translation.width, y: self.position.y + self.dragState.translation.height)
                .gesture(drag)
                .preference(key: EDragStatePreferenceKey.self, value: dragState)
//                .background(GeometryReader { geometry in
//                    Color.blue.preference(key: EDragStatePreferenceKey.self, value: dragState)
//                })
//                .onPreferenceChange(PositionPreferenceKey.self) { value in
//                    self.childWidth = value.translation
//                }
        }
    }
    
//    static func updatePosition() -> CGPoint {
//
//    }
}
