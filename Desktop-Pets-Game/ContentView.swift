//
//
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
//  ContentView.swift

import SwiftUI
import Combine

struct ContentView: View {
    @State private var imageNames = ["Image1", "Image2"] // 画像名を配列で管理
    @State private var currentImageIndex = 0            // 現在の画像のインデックス
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() // 10秒ごとのタイマー

    var body: some View {
        Image(imageNames[currentImageIndex]) // 現在の画像を表示
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(timer, perform: { _ in
                currentImageIndex = (currentImageIndex + 1) % imageNames.count // 画像のインデックスを更新
            })
            .frame(width: 200, height: 200)
            .background(Color.clear)
    }
}
