//
//  VEditableText.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI


struct VEditableText: View {
    @Binding var location: CGPoint
    @State private var isEditing = false
    @State private var text = "Dummy"
    //@FocusState private var isInFocus: Bool = true

    var body: some View {
        ZStack {
            if isEditing {
                TextField("", text: $text, onCommit: {
                    isEditing = false
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.red)
                //.focused($isInFocus)
            } else {
                Text(text)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .onLongPressGesture() {
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
