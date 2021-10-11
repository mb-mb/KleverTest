//
//  UserAccountViewProtocol.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import Foundation
import SwiftUI
import Combine

protocol UserAccountViewProtocol  {
    var presenter: UserAccountPresenterProtocol? { get set }

}
