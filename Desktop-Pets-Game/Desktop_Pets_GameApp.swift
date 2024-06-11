//
//
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
//  Desktop-Pets-Game.swift
import SwiftUI
import AppKit

// DesktopPetsGameApp.swiftの定義
@main
struct DesktopPetsGameApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}

// AppDelegateクラス
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: DraggableWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        window = DraggableWindow(
            contentRect: NSRect(x: 100, y: 100, width: 300, height: 200),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false)
        window.center()
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.level = .floating // これを追加
        window.makeKeyAndOrderFront(nil)
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.isMovable = true

        window.contentView = NSHostingView(rootView: ContentView(window: window))
    }
}

