//
//  UserAPI.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import Combine
import SwiftGRPC
import GRPC
import NIO

final class UserAPI {
    
    static let shared = UserAPI()
    var client: AccountServiceClient?
    
    private init() {
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        
//        defer {
//            try? group.syncShutdownGracefully()
//        }
        
        do {
            let channel = try GRPCChannelPool.with(target: .host("127.0.0.1", port: 50051),
                                                   transportSecurity: .plaintext,
                                                   eventLoopGroup: group)
            client = AccountServiceClient.init(channel: channel)

        } catch let error {
            print(error)
        }
    }
    
    deinit {
        try? self.client?.channel.close().wait()
    }
    
    func fetchUserData() -> Future<UserData, Error> {
        return Future { promisse in
            promisse(.success(UserData(id: UUID(),
                                       name: "name",
                                       account: [AccountUser(accountNumber: "123", amount: 123.99, lastOperation: Date())])))
        }
    }
    
    func fetchUserDataGRPC() -> Future<AccountList, Error> {
        
        return Future { promisse in
            
            var accList = AccountList()
            guard let _ = self.client?.serviceName else {
                print("service hasn't create yet")
                return
            }
            
            let callOptions = CallOptions(timeLimit: .timeout(.seconds(10)))
            let call = self.client!.list(Empty(), callOptions: callOptions)
            
            call.response.whenSuccess { accountList in
                print("call.response.whenSuccess")
                promisse(.success(accountList))
            }
            
            call.response.whenFailure { error in
                print("call.status.whenFailure: \(error)")
            }
            
            call.response.whenComplete { (result) in
                switch result {
                case .success(let response):
                    //print(response)
                    print("finished call.status.whenComplete")
                case .failure(let error):
                    print("failure call.status.whenComplete: \(error)")
                }
                
            }
                       
            do {
                let status = try call.response.wait()
                print("status: \(status)")
                promisse(.success(accList))
                
            } catch {
                print( "error: \(error)")
            }
        }

    }
    
}
