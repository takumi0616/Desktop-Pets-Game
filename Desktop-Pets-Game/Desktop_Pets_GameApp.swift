//
//
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
//  Desktop_Pets_GameApp.swift

import SwiftUI
import AppKit

@main
struct DesktopPetsGameApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()

        // ウィンドウの設定
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 200, height: 200),
            styleMask: [.borderless, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isOpaque = false
        window.center()
        window.setFrameAutosaveName("Desktop Pets Game")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating // 常に最前面に表示
    }
}
