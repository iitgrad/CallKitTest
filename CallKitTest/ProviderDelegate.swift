//
//  ProviderDelegate.swift
//  CallKitTest
//
//  Created by Kevin McQuown on 5/6/21.
//

import Foundation
import CallKit

class ProviderDelegate: NSObject, CXProviderDelegate {
    
    private let provider: CXProvider
    private let callController: CXCallController
    
    var UUIDCurrentCall = UUID()
    
    init(name: String) {
        provider = CXProvider(configuration: ProviderDelegate.providereConfiguration)
        callController = CXCallController()
        super.init()
        provider.setDelegate(self, queue: nil)
    }
    func providerDidReset(_ provider: CXProvider) {
        print("provider did reset")
    }
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("cxanswercallaction")
        action.fulfill()
    }
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("end call action")
        action.fulfill()
    }
    static var providereConfiguration: CXProviderConfiguration {
        let providerConfiguration = CXProviderConfiguration()
        providerConfiguration.supportsVideo = false
        providerConfiguration.maximumCallGroups = 1
        providerConfiguration.maximumCallsPerCallGroup = 1
        return providerConfiguration
    }
    
    func reportIncoming() {
        let update = CXCallUpdate()
        update.localizedCallerName = "CloudKit Calling"
        provider.reportNewIncomingCall(with: UUIDCurrentCall, update: update) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("call accepted")
            }
        }
    }
    
    func endCall() {
        let endCallAction = CXEndCallAction(call: UUIDCurrentCall)
        let transaction = CXTransaction(action: endCallAction)
        callController.request(transaction) { error  in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("call is ended")
            }
        }
        
    }
    
}
