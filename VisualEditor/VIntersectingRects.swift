//
//  VIntersectingRects.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI


/**
 To determine if two rectangles intersect, you'll want to track the positions of each rectangle and use the intersects(_:) method from CGRect. This method returns a Boolean value indicating whether two rectangles intersect.

 Here's an example SwiftUI view that has two draggable rectangles. The view's background color changes based on whether the rectangles intersect:

 */

typealias TPointColor = (point: CGPoint, color: Color)

struct VIntersectingRects: View {
    @GestureState private var dragState = EDragState.inactive

    @State public var positions: [
        TPointColor] = [
            (CGPoint(x: 20, y: 20), randomColor()),
//            (CGPoint(x: 140, y: 140), randomColor()),
//            (CGPoint(x: 260, y: 260), randomColor()),
//            (CGPoint(x: 220, y: 20), randomColor()),
//            (CGPoint(x: 340, y: 140), randomColor()),
//            (CGPoint(x: 460, y: 260), randomColor()),
//            (CGPoint(x: 420, y: 20), randomColor()),
//            (CGPoint(x: 540, y: 140), randomColor()),
            (CGPoint(x: 660, y: 260), randomColor()),
       ]
            
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(isIntersecting() ? Color.green : Color.red)
                //                    .onPreferenceChange(EDragStatePreferenceKey.self) { value in
                //                        print("value!.translation = \(value!.translation)")
                //                    }
                //Text("Very Good")
                    .frame(width: 100, height: 50)
                //}
                //            .padding(20)
                GeometryReader { proxy in
                    ZStack {
                        ForEach(positions.indices, id: \.self) { index in
                            VDraggableRect3(bPos: $positions[index].point, color: positions[index].color)
                            //Text("Position: ( \(Int(positions[index].point.x)),\(Int(positions[index].point.y)) )")
                                //.frame(width: 100, height: 50)

                            //                            .preference(key: EDragStatePreferenceKey.self, value: dragState)
                        }
                    }
                }
            }
        }
    }
    
    func isIntersecting() -> Bool  {
        var isIntersecting = false
        
        for primary in positions {
            let first = CGRect(origin: primary.point, size: CGSize(width: 100, height: 100))

            for secondary in positions {
                let second = CGRect(origin: secondary.point, size: CGSize(width: 100, height: 100))
                
                if primary != secondary {
                    isIntersecting = isIntersecting ? true : first.intersects(second)
                }
            }
        }
        
        return isIntersecting
    }
    
}

func randomColor() -> Color {
    let red = Double.random(in: 0..<1)
    let green = Double.random(in: 0..<1)
    let blue = Double.random(in: 0..<1)
    return Color(red: red, green: green, blue: blue)
}

