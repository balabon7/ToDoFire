//
//  User.swift
//  ToDoFire
//
//  Created by mac on 23.07.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation
import Firebase

struct TaskUser {
    
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}
