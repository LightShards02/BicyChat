//
//  Account.swift
//  FinalProject
//
//  Created by Richard Du on 5/2/24.
//

import Foundation
import SwiftData


@Model
class Account: Identifiable {
    var id: String
    public var pw: String
    
    init(id: String, pw: String) {
        self.id = id
        self.pw = pw
    }
}

func addAccount(newemail: String, newpassword: String, context: ModelContext) {
    let item = Account(id: newemail, pw: newpassword)
    context.insert(item)
//    do {
//        try context.save()
//    }
//    catch {
//        print("\(error)")
//    }
}
