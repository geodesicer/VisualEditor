//
//  VUpdateDraggableLocation.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



extension CGPoint: CustomStringConvertible {
    public var description: String {
        return "(\(x), \(y))"
    }
}

private struct BoundsPreferenceKey: PreferenceKey {

    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }

}

struct VUpdateDraggableLocation: View {
    @State private var bPos = CGPoint(x: 150, y: 150)

    var body: some View {
            VStack {
                Spacer()
                GeometryReader { proxy in
                    VCircle(bPos: $bPos, color: Color.orange)
                }
                Spacer()
                //Text("Position: (\(Int(self.bPos.x)),\(Int(self.bPos.y)))")
                Text("Position: \(bPos.description)")
            }
    }
}

struct VCircle: View {
    @GestureState private var dragState = EDragState.inactive
    @Binding var bPos: CGPoint
    @State private var pos: CGPoint = CGPoint(x: 150, y: 150)
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
        }
    }
}

