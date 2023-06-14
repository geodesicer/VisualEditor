//
//  ContentView.swift
//  VisualEditor
//
//  Created by Ulf Olsson on 2023-05-22.
//

import SwiftUI



typealias ID = UUID

struct Box: Hashable {
    var id = UUID()
    var location: CGPoint
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct BoxList {
    var boxes: [Box]
}

struct VBoxesAndLines: View {
    @State private var boxList = BoxList(boxes: [Box(location: CGPoint(x: 100, y: 100)), Box(location: CGPoint(x: 200, y: 200))])
    //@FocusState private var focusedBox: UUID?
    
    var body: some View {
        ZStack {
            if boxList.boxes.count > 1 {
                ForEach(0 ..< boxList.boxes.count - 1, id: \.self) { index in
                    Line(from: boxList.boxes[index], to: boxList.boxes[index+1])
                }
            }
            
            ForEach(boxList.boxes.indices, id: \.self) { index in
                VEditableText(location: $boxList.boxes[index].location)
                    //.focused($focusedBox, equals: boxList.boxes[index].id)
            }
            //.defaultFocus($focusedBox, boxList.boxes.last?.id)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(count: 2) { addBox(at: CGPoint(x: 150, y: 150)) }
    }

    func addBox(at location: CGPoint) {
        boxList.boxes.append(Box(location: location))
    }
}


