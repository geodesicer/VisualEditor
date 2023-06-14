//
//  VIntersectingRects.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-24.
//

import SwiftUI



typealias TPointColor = (point: CGPoint, color: Color)

struct VIntersectingRects: View {
    @GestureState private var dragState = EDragState.inactive
    //var localCoordingateSpace = NamedCoordinateSpace()

    @State public var positions: [
        TPointColor] = [
            (CGPoint(x: 20, y: 20), randomColor()),
            //(CGPoint(x: 20, y: 140), randomColor()),
            //(CGPoint(x: 20, y: 260), randomColor()),
            (CGPoint(x: 20, y: 380), randomColor()),
            //(CGPoint(x: 140, y: 20), randomColor()),
            (CGPoint(x: 140, y: 140), randomColor()),
            (CGPoint(x: 140, y: 260), randomColor()),
            //(CGPoint(x: 140, y: 380), randomColor()),
            //(CGPoint(x: 260, y: 20), randomColor()),
            (CGPoint(x: 260, y: 140), randomColor()),
            (CGPoint(x: 260, y: 260), randomColor()),
            //(CGPoint(x: 260, y: 380), randomColor()),
            (CGPoint(x: 380, y: 20), randomColor()),
            //(CGPoint(x: 380, y: 140), randomColor()),
            //(CGPoint(x: 380, y: 260), randomColor()),
            (CGPoint(x: 380, y: 380), randomColor()),
       ]
            
    var body: some View {
        VStack {
            Rectangle()
                .fill(isIntersecting() ? Color.green : Color.red)
                .frame(width: 100, height: 100)
            ZStack {
                ForEach(positions.indices, id: \.self) { index in
                    VDraggableRect3(bPos: $positions[index].point, color: positions[index].color)
                }
            }
            Spacer()
        }
        //.frame(width: 500, height: 500)
    }
    
    func isIntersecting() -> Bool  {
        var isIntersecting = false
        
        for primary in positions {
            let first = CGRect(origin: CGPoint(x: primary.point.x, y: primary.point.y)  , size: CGSize(width: 100, height: 100))

            for secondary in positions.dropFirst() {
                let second = CGRect(origin: CGPoint(x: secondary.point.x, y: secondary.point.y), size: CGSize(width: 100, height: 100))

                if primary != secondary {
                    isIntersecting = isIntersecting ? true : first.intersects(second)
                    
                    if isIntersecting { break }
                    //print("primary = \(primary)")
                    //print("first = \(first)")
                    //print("secondary = \(secondary)")
                    //print("second = \(second)")
               }
            }
            
            if isIntersecting { break }
        }
        
        return isIntersecting
    }
    
}

func randomColor() -> Color {
    let red = Double.random(in: 0..<1)
    let green = Double.random(in: 0..<1)
    let blue = Double.random(in: 0..<1)
    return Color(red: red, green: green, blue: blue, opacity: 1)
}

