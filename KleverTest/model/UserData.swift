//
//  UserData.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation

class UserData {
    var id: UUID
    var name: String = ""
    var account: [Account]
    
    init(id: UUID, name: String, account: [Account]) {
        self.account = account
        self.id = id
        self.name = name
    }
    
}

class Account: Identifiable {
    var accountNumber: String
    var amount: Float
    var lastOperation: Date
    
    init(accountNumber: String, amount: Float, lastOperation: Date) {
        self.accountNumber = accountNumber
        self.amount = amount
        self.lastOperation = lastOperation
    }
}

class UserDataList: ObservableObject {
    @Published var accountItems: [Account] = []
}

class UserDataName: ObservableObject {
    @Published var userName: String = ""
}

class UserDataAccount: ObservableObject {
    @Published var userAccount: String = ""
}
