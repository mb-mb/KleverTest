//
//  UserAccountInteractor.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import Combine


class UserAccountInteractor: UserAccountInteractorProtocol {
    var userAPI: UserAPI
    var cancellables: Set<AnyCancellable> = []
    
    init(userAPI: UserAPI) {
        self.userAPI = userAPI
    }
    
    func fetchUserData() -> Future<UserData, Error> {
        return Future { promisse in
            self.userAPI.fetchUserData()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }, receiveValue: { data in
                    promisse(.success(data))
                }).store(in: &self.cancellables)
        }

    }
}

