//
//  ContentView.swift
//  CallKitTest
//
//  Created by Kevin McQuown on 5/6/21.
//

import SwiftUI
import CloudKit
import AppDevWithSwiftLibrary

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.CKAccountChanged), perform: { _ in
            print("got notification")
        })
        .onAppear {
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
