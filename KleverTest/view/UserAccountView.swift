//
//  UserAccountView.swift
//  KleverTest
//
//  Created by marcelo bianchi on 10/10/21.
//

import SwiftUI

struct UserAccountView: View, UserAccountViewProtocol {
    var presenter: UserAccountPresenterProtocol?
    @StateObject var userDataList: UserDataList
    @StateObject var name: UserDataName
    @StateObject var account: UserDataAccount

    var body: some View {
        VStack {
            Spacer()
            VStack  {
                Spacer()
                HStack {
                    CardView(card0: Card(info: "name", detail: "\(self.name.userName)"),
                             card1: Card(info: "account", detail: "\(self.account.userAccount)"))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            Text("User Account View")
            
            List {
                Section(header: Text("data\t\tvalue")) {
                    VStack {
                        ForEach(0 ..< userDataList.accountItems.count) {
                            AccountRow(account: userDataList.accountItems[$0])
                        }
                    }
                }
                
            }
            .navigationBarTitle("Account balance")
        }
        .onAppear {
            presenter?.fetchUserData()
        }

    }
    
    func initView(userDataList: UserDataList) {
        print("init View")
    }
    

}

struct AccountRow: View {
    var account: Account
    let dateFormatter = DateFormatter()

    var body: some View {
        Text("\(formatDate(from: account.lastOperation))\t\(formatFloat(from: account.amount))")
    }
    
    func formatDate(from lastOperation: Date) -> String {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: lastOperation)
    }
    
    func formatFloat(from amount: Float) -> String {
        return String(format: "%0.2f", amount)
    }
    
}


struct CardView: View {
    let card0: Card
    let card1: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)

            VStack (alignment: .leading){
                Text(card0.info)
                    .font(.caption)
                    .foregroundColor(.black)
                Text(card0.detail)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(card1.info)
                    .font(.caption)
                    .foregroundColor(.black)
                Text(card1.detail)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(5)
            .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 150)
        .shadow(radius: 11)
        
    }
}

struct Card {
    let info: String
    let detail: String
}
