//
//  VDragEditor2.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI


/**
 n SwiftUI, a view's body should be a pure function of its state. It's not allowed to modify any state from within the body of the view or you will get a warning, "Modifying state during view update, this will cause undefined behavior."

 In the code I provided earlier, the state variables dragOffset and position are only modified during gesture updates, not during view updates. Therefore, you should not receive the "Modifying state during view update" warning with this code.

 If you are modifying a state variable directly in the body of a SwiftUI view, that would cause this warning. Also, if you call a function that modifies a state variable and that function is called from the body of the view, you will also see this warning.
 */

struct VDragEditor2: View {
    @State private var isInsideTarget = false
    @State private var rectPosition = CGSize.zero
    @State private var targetAreaFrame: CGRect = .zero

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
            }
            .frame(width: 200, height: 200)
            .overlay(
                Rectangle()
                    .fill(isInsideTarget ? Color.green : Color.red)
            )
            .onPreferenceChange(FramePreferenceKey.self) { value in
                self.targetAreaFrame = value
            }

            Spacer()

            GeometryReader { geometry in
                VDraggableRect2(rectPosition: $rectPosition)
                    .onChange(of: rectPosition) { newValue in
                        let local = geometry.size
                        let global = geometry.frame(in: .global).origin
                        print("local = \(local) , global = \(global)")
                        checkIfRectIsInsideTarget(newValue /* , correction: global */)
//                        checkIfRectIsInsideTarget(newValue)
                    }
            }
        }
        .onChange(of: rectPosition) { _ in
            checkIfRectIsInsideTarget(rectPosition /* , correction: CGPoint(x: 0, y: 24) */ )
        }

    }

    private func checkIfRectIsInsideTarget(_ rectPosition: CGSize) {
        let rectFrame = CGRect(x: rectPosition.width, y: rectPosition.height, width: 100, height: 100)
        isInsideTarget = rectFrame.intersects(targetAreaFrame)
        print("rectFrame = \(rectFrame)")
        print("targetAreaFrame = \(targetAreaFrame)")
        print("isInsideTarget = \(isInsideTarget)")
    }

//    private func checkIfRectIsInsideTarget(_ rectPosition: CGSize, correction: CGPoint) {
//        let rectFrame = CGRect(x: rectPosition.width + correction.x, y: rectPosition.height + correction.y, width: 100, height: 100)
//        isInsideTarget = rectFrame.intersects(targetAreaFrame)
//        print("rectFrame = \(rectFrame)")
//        print("targetAreaFrame = \(targetAreaFrame)")
//        print("isInsideTarget = \(isInsideTarget)")
//    }
}
