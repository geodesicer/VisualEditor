//
//  VDragEditor3.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI


/**
 1. Each VDraggableRect3 handles its own DragGesture, updating dragState as it's being dragged.
 2. The rectPosition for each VDraggableRect3 is updated when the drag ends (onEnded).
 3. The rectFrame is updated every time the GeometryReader changes, which happens when the Rectangle is moved.
 4. We use onChange on rect1Position and rect2Position to call checkIntersect whenever the position of either rectangle changes.
 5. The checkIntersect function checks if the rectangles intersect and updates the isIntersecting variable, which in turn updates the color of the ZStack.
 6. The ZStack will turn red if the rectangles intersect, and green if they do not.
 */

struct VDragEditor3: View {
    @State private var position1 = CGPoint(x: 100, y: 100)
    @State private var position2 = CGPoint(x: 150, y: 250)
//    @State private var rect1Frame: CGRect = .zero
//    @State private var rect2Frame: CGRect = .zero

    var body: some View {
        let isIntersecting = CGRect(origin: position1, size: CGSize(width: 100, height: 100))
            .intersects(CGRect(origin: position2, size: CGSize(width: 100, height: 100)))

        return ZStack {
            if isIntersecting {
                Color.red
            } else {
                Color.green
            }

            VDraggableRect3(position: $position1, /* rectFrame: $rect1Frame,*/ color: Color.yellow)
                //.frame(width: rect1Frame.width, height: rect1Frame.height)
                //.position(rect1Position)

            VDraggableRect3(position: $position2, /* rectFrame: $rect2Frame, */ color: Color.orange)
                //.frame(width: rect2Frame.width, height: rect2Frame.height)
                //.position(rect2Position)
        }
        .onChange(of: position1) { _ in
            checkIntersect()
        }
        .onChange(of: position2) { _ in
            checkIntersect()
        }
    }

    private func checkIntersect() {
        let rect1 = CGRect(origin: position1, size: CGSize(width: 100, height: 100))
        let rect2 = CGRect(origin: position2, size: CGSize(width: 100, height: 100))
        print("rect1 = \(rect1)")
        print("rect2 = \(rect2)")
        if rect1.intersects(rect2) {
            print("Intersected")
        } else {
            print("Not Intersected")
        }
    }
}
