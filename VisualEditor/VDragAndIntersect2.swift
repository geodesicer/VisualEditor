//
//  VDragAndIntersect2.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI




struct VDragAndIntersect2: View {
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
                        checkIfRectIsInsideTarget(newValue, correction: global)
                    }
            }
        }
        .onChange(of: rectPosition) { _ in
            checkIfRectIsInsideTarget(rectPosition, correction: CGPoint(x: 0, y: 24))
        }

    }

    private func checkIfRectIsInsideTarget(_ rectPosition: CGSize, correction: CGPoint) {
        let rectFrame = CGRect(x: rectPosition.width + correction.x, y: rectPosition.height + correction.y, width: 100, height: 100)
        isInsideTarget = rectFrame.intersects(targetAreaFrame)
        print("rectFrame = \(rectFrame)")
        print("targetAreaFrame = \(targetAreaFrame)")
        print("isInsideTarget = \(isInsideTarget)")
    }
}
