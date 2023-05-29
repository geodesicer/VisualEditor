//
//  VDragEditor.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-23.
//

import SwiftUI



/**
 prompt: "use swiftui to move a draggable rect into one of several target areas and drop it"
 
 Here is a basic example of how you can use SwiftUI to create a draggable rectangle that can be dropped into one of several target areas. In this example, we'll have three target areas.
 
 However, this example only visually moves the rectangle and provides targets. It doesn't actually handle a "drop" event or provide any feedback that the rectangle is in a target area. To accomplish this, you would need to add additional state to your application to track the position of the rectangle and check if it is within the boundaries of a target area when the drag gesture ends.

 prompt: "handle a "drop" event and feedback that the rectangle is in a target area"
 
 1. We have a @State property isInsideTarget which is used to determine if the rectangle is inside the target. The checkIfRectIsInsideTarget function is used to calculate if the rectangle's position is within the target frame when the rectangle's position changes.
 
 2. We have a @State property rectPosition which is used to store the last position of the rectangle when the drag has ended.
 
 3. We are using a GeometryReader to get the frame of the target area in global coordinates.
 
 4. The FramePreferenceKey is used to propagate the frame of the target area up to the ContentView.
 
 5. In the VDraggableRect1, we have added an .onEnded closure to the DragGesture to update rectPosition when the drag ends.
 
 6. The color of the target area changes to green when the rectangle is inside the target area and to red when it's not
 
 */

struct VDragEditor1: View {
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
                VDraggableRect1(rectPosition: $rectPosition)
                    .onChange(of: rectPosition) { newValue in
                        let local = geometry.size
                        let global = geometry.frame(in: .global).origin
                        print("local = \(local) , global = \(global)")
                        checkIfRectIsInsideTarget(newValue, correction: global)
                    }
            }
        }
        //.padding()
    }

    private func checkIfRectIsInsideTarget(_ rectPosition: CGSize, correction: CGPoint) {
        let rectFrame = CGRect(x: rectPosition.width + correction.x, y: rectPosition.height + correction.y, width: 100, height: 100)
        isInsideTarget = rectFrame.intersects(targetAreaFrame)
        print("rectFrame = \(rectFrame)")
        print("targetAreaFrame = \(targetAreaFrame)")
        print("isInsideTarget = \(isInsideTarget)")
    }
}
