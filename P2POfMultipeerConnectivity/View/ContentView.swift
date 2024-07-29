//
//  ContentView.swift
//  P2POfMultipeerConnectivity
//
//  Created by 渡邉華輝 on 2024/07/12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var multipeerManager: MultipeerManager
    @State private var message = ""

    var body: some View {
        NavigationView {
            VStack {
                List(multipeerManager.messages, id: \.self) { message in
                    Text(message)
                }
                HStack {
                    TextField("Enter message", text: $message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        multipeerManager.send(message: message)
                        message = ""
                    }) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Multipeer Chat")
        }
    }
}
