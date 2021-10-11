//
//  UserAccountPresenter.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import Combine

final class UserAccountPresenter {
    var view: UserAccountView?
    var interactor: UserAccountInteractorProtocol
    var cancellables: Set<AnyCancellable> = []
    let dateFormatter = DateFormatter()
    
    @Published var userDataList: UserDataList


    
    init(view: UserAccountView? = nil, interactor: UserAccountInteractorProtocol,
         accountItems: UserDataList) {
        self.view = view
        self.interactor = interactor
        self.userDataList = accountItems
        self.view?.userDataList.accountItems = self.userDataList.accountItems
        
        dateFormatter.dateFormat = "dd'/'MM'/'yyyy"
        
        
    }
    
    
}

extension UserAccountPresenter: UserAccountPresenterProtocol {

    
    
    func initialView() -> UserAccountViewProtocol {
        let name = UserDataName()
        name.userName = "John Doe"
        let account = UserDataAccount()
        account.userAccount = "JKO876Y-09"
        self.view = UserAccountView(presenter: self,
                                    userDataList: self.userDataList,
                                    name: name,
                                    account: account)
        
        if let view = view {
            return view
        }
        
        
        
        return ErrorView() as! UserAccountViewProtocol
    }
    
    func fetchUserData() -> Void {
        interactor.fetchUserDataGRPC()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] data in
                var accountUser: [AccountUser] = []
                _ = data.accounts.map { account in
                    let dt = self?.dateFormatter.date(from: account.lastOperation)
                    let account = AccountUser(accountNumber: account.id,
                                              amount: Float(account.amount) ?? Float(0),
                                              lastOperation: dt ?? Date())
                    accountUser.append(account)
                }
                self?.view?.userDataList.accountItems = accountUser
            })
            .store(in: &self.cancellables)
    }
    
    

}


