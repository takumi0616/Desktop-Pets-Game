//
//
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
//  ContentView.swift
import SwiftUI
import AppKit

// 画像セットの状況を表す列挙型
enum MascotStatus {
    case normal, specialStatus
}

class ImageSetManager {
    // 各状況の画像セットを定義
    var defaultImageSet = (0...7).map { "slice_\($0)_wipe_the_window" }
    var specialStatusImageSet = (0...5).map { "slice_\($0)_special_status" }

    func getImageSet(forStatus status: MascotStatus) -> [String] {
        switch status {
        case .normal:
            return defaultImageSet
        case .specialStatus:
            return specialStatusImageSet
        }
    }
}

struct ContentView: View {
    var window: DraggableWindow
    @State private var draggingImageNames = (0...10).map { "slice_\($0)_while_dragging" }
    @State private var currentImageIndex = 0
    @State private var currentStatus = MascotStatus.normal
    @State private var lastDraggingState = false
    @State private var imageOpacity = 1.0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    private let imageSetManager = ImageSetManager()

    var body: some View {
        let currentImageSet = window.isDragging ? draggingImageNames : imageSetManager.getImageSet(forStatus: currentStatus)
        let currentImage = currentImageSet[currentImageIndex % currentImageSet.count]

        return Image(currentImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
            .background(Color.clear)
            .opacity(imageOpacity)
            .onReceive(timer) { _ in
                currentImageIndex += 1 // 常に画像インデックスを更新
                if window.isDragging != lastDraggingState {
                    imageOpacity = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        imageOpacity = 1.0
                        lastDraggingState = window.isDragging
                    }
                }
            }
    }
}
