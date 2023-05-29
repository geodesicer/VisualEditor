//
//  VDraggableBox.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI



struct VDraggableBox: View {
    @Binding var location: CGPoint

    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 50, height: 50)
            .position(location)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.location = value.location
                    }
            )
    }
}


