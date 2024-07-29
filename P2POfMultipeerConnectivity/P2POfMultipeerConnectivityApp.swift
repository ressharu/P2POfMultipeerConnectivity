//
//  P2POfMultipeerConnectivityApp.swift
//  P2POfMultipeerConnectivity
//
//  Created by 渡邉華輝 on 2024/07/12.
//

import SwiftUI

@main
struct P2POfMultipeerConnectivityApp: App {
    @StateObject private var multipeerManager = MultipeerManager() // アプリ全体で1つのインスタンスを使用

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(multipeerManager) // 環境オブジェクトとして渡す
        }
    }
}
