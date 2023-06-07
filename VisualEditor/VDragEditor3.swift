//
//  VDragEditor3.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI


//typealias TPointColor = (point: CGPoint, color: Color)

/**
 1. Each VDraggableRect3 handles its own DragGesture, updating dragState as it's being dragged.
 2. The rectPosition for each VDraggableRect3 is updated when the drag ends (onEnded).
 3. The rectFrame is updated every time the GeometryReader changes, which happens when the Rectangle is moved.
 4. We use onChange on rect1Position and rect2Position to call checkIntersect whenever the position of either rectangle changes.
 5. The checkIntersect function checks if the rectangles intersect and updates the isIntersecting variable, which in turn updates the color of the ZStack.
 6. The ZStack will turn red if the rectangles intersect, and green if they do not.
 */

struct VDragEditor3: View {
    @State private var moving: CGPoint = CGPoint(x: 200, y: 300)
    @State private var targetAreaFrame: CGRect = .zero

    @State public var positions: [
        TPointColor] = [
            (CGPoint(x: 20, y: 20), randomColor()),
            (CGPoint(x: 140, y: 20), randomColor()),
            (CGPoint(x: 260, y: 20), randomColor()),
            (CGPoint(x: 380, y: 20), randomColor()),
            (CGPoint(x: 500, y: 20), randomColor()),
            (CGPoint(x: 620, y: 20), randomColor()),
       ]
    

    var body: some View {
        ZStack {
            ForEach(positions.indices, id: \.self) { index in
                VDraggableRect3(bPos: $positions[index].point, color: positions[index].color)
                    .preference(key: FramePreferenceKey.self, value: targetAreaFrame)
            }
            
            VDraggableRect3(bPos: $moving, color: .blue)
        }
        .onPreferenceChange(FramePreferenceKey.self) { value in
            self.targetAreaFrame = value
        }
    }

    func isInsideTarget() -> Bool  {
        var isIntersecting = false
        
        for target in positions {
        }
        
        return isIntersecting
    }
}
