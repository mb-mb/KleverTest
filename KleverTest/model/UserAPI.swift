//
//  UserAPI.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import Combine

final class UserAPI {
    
    static let shared = UserAPI()
    
    private init() {}
    
    func fetchUserData() -> Future<UserData, Error> {
        return Future { promisse in
            promisse(.success(UserData(id: UUID(), name: "name", account: [Account(accountNumber: "123", amount: 123.99, lastOperation: Date())])))
        }
    }
}
