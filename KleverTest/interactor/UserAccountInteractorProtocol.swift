//
//  UserAccountInteractorProtocol.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import Combine

protocol UserAccountInteractorProtocol {
    var userAPI: UserAPI { get set }

    func fetchUserData() -> Future<UserData, Error>
    func fetchUserDataGRPC() -> Future<AccountList, Error>
}
