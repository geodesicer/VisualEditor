//
//  VSecond.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI



struct VSecond: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
        }
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
