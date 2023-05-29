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

public struct IDView {
    var id = UUID()
    var view: any View
}


struct VIntersectingRects: View {
    @GestureState private var dragState = EDragState.inactive

    @State public var positions: [
        TPointColor] = [
            (CGPoint(x: 20, y: 20), randomColor()),
            (CGPoint(x: 140, y: 140), randomColor()),
            (CGPoint(x: 260, y: 260), randomColor()),
            (CGPoint(x: 220, y: 20), randomColor()),
            (CGPoint(x: 340, y: 140), randomColor()),
            (CGPoint(x: 460, y: 260), randomColor()),
            (CGPoint(x: 420, y: 20), randomColor()),
            (CGPoint(x: 540, y: 140), randomColor()),
            (CGPoint(x: 660, y: 260), randomColor()),
       ]
    
    var views: [IDView] = []
    
    init() {
//        for index in positions.indices {
//            views.append(IDView(view: VDraggableRect3(position: $positions[index].point, /* rectFrame: $rect1Frame, */ color: positions[index].color)))
//        }
    }
    
    var body: some View {
//        let drag = DragGesture()
//            .updating($dragState) { (value, state, _) in
//                state = .dragging(translation: value.translation)
//                print("updating = \(value.translation)")
//            }
        
        VStack {
            ZStack {
                Rectangle()
                    .fill(isIntersecting() ? Color.green : Color.red)
                    .onPreferenceChange(EDragStatePreferenceKey.self) { value in
                        print("value!.translation = \(value!.translation)")
                        //self.childWidth = value!.translation
                    }
                Text("Very Good")
                //                .background(GeometryReader { geometry in
                //                    Color.blue.preference(key: EDragStatePreferenceKey.self, value: dragState)
                //                })
            }
            .frame(width: 100, height: 50)
            .padding(20)
            ZStack {
                ForEach(positions.indices, id: \.self) { index in
                    VDraggableRect3(position: $positions[index].point, /* rectFrame: $rect1Frame, */ color: positions[index].color)
                        .preference(key: EDragStatePreferenceKey.self, value: dragState)
                        //.gesture(drag)

//                        .gesture(
//                            DragGesture()
//                                .updating($dragOffset) { value, state, _ in
//                                    state = value.translation
//                                    print("state = \(state)'")
//                                }
//                                .onEnded { value in
//                                    positions[index].point.x += value.translation.width
//                                    positions[index].point.y += value.translation.height
//                                }
//                        )

                }
            }
        }
    }
    
    func isIntersecting() -> Bool  {
        var isIntersecting = false
        //guard positions.count > 1 else { return false }
        
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

