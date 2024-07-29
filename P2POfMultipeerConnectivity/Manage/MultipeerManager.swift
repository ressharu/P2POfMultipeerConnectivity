//
//  MultipeerManager.swift
//  P2POfMultipeerConnectivity
//
//  Created by 渡邉華輝 on 2024/07/12.
//

import MultipeerConnectivity

class MultipeerManager: NSObject, ObservableObject {
    @Published var messages: [String] = [] // メッセージの配列（@PublishedでSwiftUIに更新を通知）
    @Published var connectedPeers: [MCPeerID] = [] // 接続されているピアの配列（@PublishedでSwiftUIに更新を通知）
    @Published var availablePeers: [MCPeerID] = [] // 発見されたピアの配列（@PublishedでSwiftUIに更新を通知）
    
    private let peerConnectionManager: PeerConnectionManager
    
    override init() {
        self.peerConnectionManager = PeerConnectionManager(serviceType: "example-chat", myPeerId: MCPeerID(displayName: UIDevice.current.name))
        super.init()
        
        self.peerConnectionManager.delegate = self
    }
    
    deinit {
        self.peerConnectionManager.stop()
    }
    
    func send(message: String) {
        guard !peerConnectionManager.connectedPeers.isEmpty else {
            print("No connected peers") // 接続されているピアがいない場合のメッセージ
            return
        }
        
        let data = Data(message.utf8) // 文字列をデータに変換
        do {
            try peerConnectionManager.send(data: data, toPeers: peerConnectionManager.connectedPeers) // データを接続されているピアに送信
            if(message != ""){
                messages.append("Me: \(message)") // 自分のメッセージを追加
            }
        } catch {
            print("Error sending message: \(error.localizedDescription)") // メッセージ送信エラーの処理
        }
    }
    
    func invite(peer: MCPeerID) {
        peerConnectionManager.invite(peer: peer)
    }
}

extension MultipeerManager: PeerConnectionManagerDelegate {
    func didChangeConnectedPeers(_ connectedPeers: [MCPeerID]) {
        DispatchQueue.main.async {
            self.connectedPeers = connectedPeers // 接続されたピアの変更を更新
        }
    }
    
    func didReceiveMessage(_ message: String, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.messages.append("\(peerID.displayName): \(message)") // 受信したメッセージを追加
        }
    }
    
    func didDiscoverPeer(_ peerID: MCPeerID) {
        DispatchQueue.main.async {
            if !self.availablePeers.contains(peerID) {
                self.availablePeers.append(peerID) // 発見されたピアを追加
            }
        }
    }
    
    func isPeerConnected(_ peer: MCPeerID) -> Bool {
        return connectedPeers.contains(peer)
    }
}

// ピア接続マネージャのデリゲートプロトコルに新しいメソッドを追加
protocol PeerConnectionManagerDelegate: AnyObject {
    func didChangeConnectedPeers(_ connectedPeers: [MCPeerID])
    func didReceiveMessage(_ message: String, fromPeer peerID: MCPeerID)
    func didDiscoverPeer(_ peerID: MCPeerID) // 発見されたピアを通知
}
