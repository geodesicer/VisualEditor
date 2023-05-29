//
//  VLine.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI



struct Line: View {
    var from: CGPoint
    var to: CGPoint

    var body: some View {
        Path { path in
            path.move(to: from)
            path.addLine(to: to)
        }
        .stroke(Color.black, lineWidth: 2)
    }
}


