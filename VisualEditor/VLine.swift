//
//  VLine.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI



struct Line: View {
    var from: Box
    var to: Box

    var body: some View {
        Path { path in
            path.move(to: from.location)
            path.addLine(to: to.location)
        }
        .stroke(Color.black, lineWidth: 2)
    }
}


