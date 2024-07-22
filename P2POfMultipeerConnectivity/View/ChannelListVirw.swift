//
//  ChannelVirw.swift
//  P2POfMultipeerConnectivity
//
//  Created by 渡邉華輝 on 2024/07/22.
//

import SwiftUI

struct ChannelListVirw: View {
    
    var array: [Int] = [1, 3, 4, 5, 6]
    
    func NavigationView() {
        ScrollView {
            List(array) { array in
                VStack {
                    Text("Channel \(array)")
                }
            }
        }
    }
}
