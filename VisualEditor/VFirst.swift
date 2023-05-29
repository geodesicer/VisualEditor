//
//  VFirst.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI

/**
 prompt: "using a longpress go into a new view and remove the old, and by using double click anywhere go back to the old view"
 
 In this example, VFirst is a NavigationView that contains a hidden NavigationLink. The NavigationLink is activated when the onLongPressGesture sets isActive to true. This pushes VSecond onto the navigation stack.

 VSecond uses the presentationMode environment variable to dismiss itself when the onTapGesture is triggered by a double tap. This pops VSecond from the navigation stack and returns to VFirst.
 
 Thanks for pointing that out. It looks like the API has changed in macOS 13.0. You can now use the NavigationLink value and label initializer. This new initializer uses a binding to an optional value instead of a binding to a boolean to control whether the navigation link is active.
 */

struct VFirst: View {
    @State private var activeView: Int? = nil

    var body: some View {
        NavigationView {
            VStack {
                Text("First View")
                    .font(.largeTitle)
                NavigationLink(destination: VSecond(), tag: 1, selection: $activeView) {
                    EmptyView()
                }
            }
            .contentShape(Rectangle())
            .onLongPressGesture {
                activeView = 1
            }
        }
    }
}
