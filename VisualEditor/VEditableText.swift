//
//  VEditableText.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI


/**
 prompt: "use swiftui to make a box containing text that you can doubleclick and edit"
 
 In this code, we have a ZStack that conditionally displays either a TextField or a Text view depending on the value of the isEditing state variable. When isEditing is false, it displays a Text view, and when you double tap the Text view, it sets isEditing to true, switching to the TextField view.

 When you hit return or double tap outside the TextField, it sets isEditing to false, switching back to the Text view. The text is stored in the text state variable, so it's preserved between switches.
 */

struct VEditableText: View {
    @Binding var location: CGPoint
    @State private var isEditing = false
    @State private var text = "^^Edit^^"

    var body: some View {
        ZStack {
            if isEditing {
                TextField("", text: $text, onCommit: {
                    isEditing = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onTapGesture(count: 2) {
                    isEditing = false
                }
            } else {
                Text(text)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .onTapGesture(count: 2) {
                        isEditing = true
                    }
            }
        }
        .frame(width: 120, height: 50)
        .position(location)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.location = value.location
                }
        )
    }
}
