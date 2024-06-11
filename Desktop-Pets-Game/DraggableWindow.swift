//
//  DraggableWindow.swift
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/21.
//

import SwiftUI
import AppKit

// DraggableWindowクラス
class DraggableWindow: NSPanel, ObservableObject {
    @Published var isDragging = false

    private var initialLocation: NSPoint?

    override func mouseDown(with event: NSEvent) {
        self.initialLocation = event.locationInWindow
        self.isDragging = true
    }

    override func mouseDragged(with event: NSEvent) {
        guard let initialLocation = self.initialLocation else { return }
        let currentLocation = event.locationInWindow
        let deltaX = currentLocation.x - initialLocation.x
        let deltaY = currentLocation.y - initialLocation.y

        var newOrigin = self.frame.origin
        newOrigin.x += deltaX
        newOrigin.y += deltaY

        self.setFrameOrigin(newOrigin)
    }

    override func mouseUp(with event: NSEvent) {
        self.isDragging = false
    }
    
    override func rightMouseDown(with event: NSEvent) {
        let menu = NSMenu(title: "Context Menu")

        // 各メインメニュー項目にサブメニューを追加
        menu.addItem(withTitle: "食事", action: nil, keyEquivalent: "").submenu = createFoodSubMenu()
        menu.addItem(withTitle: "ステータス", action: nil, keyEquivalent: "").submenu = createStatusSubMenu()
        menu.addItem(withTitle: "活動", action: nil, keyEquivalent: "").submenu = createActivitySubMenu()
        menu.addItem(withTitle: "ゲーム", action: nil, keyEquivalent: "").submenu = createGameSubMenu()
        menu.addItem(withTitle: "設定", action: nil, keyEquivalent: "").submenu = createSettingsSubMenu()

        if let contentView = self.contentView {
            NSMenu.popUpContextMenu(menu, with: event, for: contentView)
        }
    }

    func createFoodSubMenu() -> NSMenu {
        let subMenu = NSMenu()
        // ここに「食事」に関するサブメニュー項目を追加
        return subMenu
    }

    func createStatusSubMenu() -> NSMenu {
        let subMenu = NSMenu()

        let statusGraphItem = NSMenuItem()
        let statusGraphView = StatusGraphView(frame: NSRect(x: 0, y: 0, width: 150, height: 200)) // サイズは適宜調整
        statusGraphView.level = 5 // レベル
        statusGraphView.money = 200 // 所持金
        statusGraphView.health = "Good" // 体調
        // その他のプロパティも設定
        statusGraphItem.view = statusGraphView
        subMenu.addItem(statusGraphItem)

        return subMenu
    }

    // 同様に、残りのカテゴリーに対してもサブメニュー作成関数を定義
    func createActivitySubMenu() -> NSMenu {
        let subMenu = NSMenu()
        // ここに「ステータス」に関するサブメニュー項目を追加
        return subMenu
    }
    func createGameSubMenu() -> NSMenu {
        let subMenu = NSMenu()
        // ここに「ステータス」に関するサブメニュー項目を追加
        return subMenu
    }
    func createSettingsSubMenu() -> NSMenu {
        let subMenu = NSMenu()
        // ここに「ステータス」に関するサブメニュー項目を追加
        return subMenu
    }

    @objc func subMenuItemAction() {
        // サブメニュー項目がクリックされた時のアクション
    }
}

class StatusGraphView: NSView {
    var level: Int = 1
    var money: Int = 100
    var health: String = "Good"

    var exp: CGFloat = 0.5
    var stamina: CGFloat = 0.7
    var hunger: CGFloat = 0.4
    var thirst: CGFloat = 0.3
    var mood: CGFloat = 0.6

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // ここにテキストとグラフの描画ロジックを実装
        // 例: drawText("Level: \(level)", at: CGPoint(x: 10, y: 180))
        // 例: drawBar(for: exp, color: NSColor.blue, at: CGRect(x: 10, y: 160, width: 100, height: 10))
        // 同様にスタミナ、空腹度、喉の渇き度、気分のバーを描画
    }

    // テキスト描画のヘルパーメソッド
    func drawText(_ text: String, at point: CGPoint) {
        // テキスト描画のロジック
    }

    // バー描画のヘルパーメソッド
    func drawBar(for value: CGFloat, color: NSColor, at rect: CGRect) {
        // バー描画のロジック
    }
}
