//
//  ContentView.swift
//  CallKitTest
//
//  Created by Kevin McQuown on 5/6/21.
//

import SwiftUI
import CloudKit
import AppDevWithSwiftLibrary
import CallKit

struct ContentView: View {
    @State var providerDelegate: ProviderDelegate?
    
    var body: some View {
        VStack {
            Button(action: {
                providerDelegate?.reportIncoming()
            }, label: {
                Text("Initiate Call")
            }).padding()
            Button(action: {
                providerDelegate?.endCall()
            }, label: {
                Text("Cancel Call")
            }).padding()

        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.CKAccountChanged), perform: { _ in
            print("CallKitTest: got notification")
            providerDelegate?.reportIncoming()
        })
        .onAppear {
            providerDelegate = ProviderDelegate(name: "test")
            createSubscription(recordType: "seizureAlert",
                               predicate: NSPredicate(value: true)) { _, _ in
                ()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
