//
//  RootView.swift
//  P2POfMultipeerConnectivity
//
//  Created by 渡邉華輝 on 2024/07/13.
//

import Foundation
import SwiftUI

struct RootView: View {
    var body: some View {
        TabView{
            ContentView() //1枚目の子ビュー
                .tabItem {
                    Image(systemName: "paperplane.fill") //送信タブ的な？
                }
            ConnectView() //2枚目の子ビュー
                .tabItem {
                    Image(systemName: "person.badge.plus") //デバイスの検索
                }
        }
    }
}
