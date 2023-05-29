//
//  ContentView.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI

/**
 This ContentView starts with two boxes at specified points. When you double tap anywhere, it creates a new box at a default location (150, 150). The boxes are draggable and you'll see lines connect them in the order they were created. The boxes are displayed as blue circles and lines are black. You can modify this to suit your needs. This is a simple way to show the concept, and it can be expanded upon to meet more specific needs.

 This also does not handle the removal of boxes or reordering, and boxes will be stacked on top of each other when created. You could add more complex logic to handle these scenarios if needed.
 */

struct ContentView: View {
    @State private var boxes: [CGPoint] = [CGPoint(x: 100, y: 100), CGPoint(x: 200, y: 200)]
    
    var body: some View {
        ZStack {
            if boxes.count > 1 {
                ForEach(0..<boxes.count-1, id: \.self) { index in
                    Line(from: boxes[index], to: boxes[index+1])
                }
            }
            
            ForEach(boxes.indices, id: \.self) { index in
                VEditableText(location: $boxes[index])
                //VDraggableBox(location: $boxes[index])
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(count: 2) { addBox(at: CGPoint(x: 150, y: 150)) }
    }

    func addBox(at location: CGPoint) {
        boxes.append(location)
    }
}


