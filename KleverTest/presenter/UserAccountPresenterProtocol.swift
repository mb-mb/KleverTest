//
//  UserAccountPresenterProtocol.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import Combine
import SwiftUI

protocol UserAccountPresenterProtocol {
    var view: UserAccountView? { get set }
    
    func initialView() -> UserAccountViewProtocol
    func fetchUserData() -> Void 
}
