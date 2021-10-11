//
//  UserAccountRouter.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import SwiftUI

final class UserAccountRouter {
    
    var presenter: UserAccountPresenter
    var interactor: UserAccountInteractor
    
    init() {
        self.interactor = UserAccountInteractor(userAPI: UserAPI.shared)
        let userDataList = UserDataList()
        self.presenter = UserAccountPresenter(interactor: interactor, accountItems: userDataList)
    }
    
    func routeToUserAccount() -> some View {
        return presenter.initialView() as? UserAccountView
    }
    
}
