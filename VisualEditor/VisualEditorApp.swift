//
//  VisualEditorApp.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI

/**
 
 Prompt:
 
 "use swiftui to create a view containing boxes that you can drag and connect with lines"
 
 Creating a draggable view with boxes that can be connected with lines in SwiftUI would involve a lot of parts. Let's break it down.

 We need a DraggableBox view that we can drag around the screen.
 We need a Line view to draw lines between boxes.
 We need a main ContentView where we manage our boxes and lines and handle drag gestures.
 */

@main
struct VisualEditorApp: App {
    var body: some Scene {
        WindowGroup {
            //VFirst()
            //ContentView()
            //VDragEditor1()
            //VDragEditor2()
            //VDragEditor3()
            //VUsingPreferenceKey()
            VIntersectingRects()
            //VUpdateDraggableLocation()
            //VDragUpdate()
        }
    }
}
