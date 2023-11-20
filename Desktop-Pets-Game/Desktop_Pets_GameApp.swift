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
    @State private var isDragging = false

    var body: some Scene {
        WindowGroup {
            ContentView(isDragging: $isDragging)
        }
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let window = AppWindowManager.shared.build()
        AppWindowManager.shared.current = window
    }
}

class AppWindowManager {
    static let shared = AppWindowManager()
    weak var current: DraggableWindow?

    func build() -> DraggableWindow {
        let rect = NSRect(x: 100, y: 100, width: 300, height: 200)
        let window = DraggableWindow(contentRect: rect, styleMask: [.borderless, .nonactivatingPanel], backing: .buffered, defer: false)
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.center()
        // DraggableWindowのインスタンスを保持
        current = window
        // Bindingを使用してContentViewを初期化
        window.contentView = NSHostingView(rootView: ContentView(isDragging: Binding(get: { self.current?.isDragging ?? false }, set: { self.current?.isDragging = $0 })))
        customize(window)
        return window
    }
    
    func customize(_ window: NSWindow) {
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.makeKeyAndOrderFront(nil)
    }
}

class DraggableWindow: NSPanel, ObservableObject {
    private var initialLocation: NSPoint?
    @Published var isDragging = false

    override func mouseDown(with event: NSEvent) {
        initialLocation = event.locationInWindow
        isDragging = true  // ドラッグ開始時に状態をtrueに設定
    }

    override func mouseDragged(with event: NSEvent) {
        guard let initialLocation = initialLocation else { return }
        let currentLocation = event.locationInWindow
        let newOriginX = currentLocation.x - initialLocation.x
        let newOriginY = currentLocation.y - initialLocation.y
        self.setFrameOrigin(NSPoint(x: newOriginX, y: newOriginY))
    }

    override func mouseUp(with event: NSEvent) {
        isDragging = false  // ドラッグ終了時に状態をfalseに設定
    }
    
    private func updateContentView() {
        let draggableView = DraggableView()
        draggableView.addSubview(NSHostingView(rootView: ContentView(isDragging: Binding(get: { self.isDragging }, set: { self.isDragging = $0 }))))
        self.contentView = draggableView
    }
}

class DraggableView: NSView {
    override func mouseDown(with event: NSEvent) {
        window?.mouseDown(with: event)
    }

    override func mouseDragged(with event: NSEvent) {
        window?.mouseDragged(with: event)
    }
}
