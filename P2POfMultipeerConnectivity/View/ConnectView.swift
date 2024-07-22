//
//  ConnectView.swift
//  P2POfMultipeerConnectivity
//
//  Created by 渡邉華輝 on 2024/07/12.
//

import SwiftUI

struct ConnectView: View {
    @StateObject private var multipeerManager = MultipeerManager()
    @State private var message = ""

    var body: some View {
        NavigationView {
            VStack {
                List(multipeerManager.availablePeers, id: \.self) { peer in
                    HStack {
                        Text(peer.displayName)
                        Spacer()
                        if multipeerManager.isPeerConnected(peer) {
                            Text("Connected")
                                .padding(6)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        } else {
                            Button(action: {
                                multipeerManager.invite(peer: peer)
                            }) {
                                Text("Connect")
                                    .padding(6)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Multipeer Chat", displayMode: .inline)
        }
    }
}

struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
