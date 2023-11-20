//
//
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
//  ContentView.swift

import SwiftUI
import AppKit

struct ContentView: View {
    @State private var imageNames = (0...7).map { "slice_\($0)_wipe_the_window" }
    @State private var draggingImageNames = (0...10).map { "slice_\($0)_while_dragging" }
    @State private var currentImageIndex = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Binding var isDragging: Bool

    var body: some View {
        Image(isDragging ? draggingImageNames[currentImageIndex % draggingImageNames.count] : imageNames[currentImageIndex % imageNames.count])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .background(Color.clear)
            .onReceive(timer) { _ in
                currentImageIndex += 1
            }
    }
}
