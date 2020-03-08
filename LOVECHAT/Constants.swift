//
//  Constants.swift
//  LOVECHAT
//
//  Created by kittawat phuangsombat on 2020/3/1.
//  Copyright © 2020 kittawat phuangsombat. All rights reserved.
//

import Foundation

struct  K {
        static let appName = "JUST💕US"
        static let slogan = "Make texting meaningful again"
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "MessageCell"
        static let registerSegue = "RegisterToChat"
        static let loginSegue = "LoginToChat"
        
//        struct BrandColors {
//            static let purple = "BrandPurple"
//            static let lightPurple = "BrandLightPurple"
//            static let blue = "BrandBlue"
//            static let lighBlue = "BrandLightBlue"
//        }
        
        struct FStore {
            static let collectionName = "messages"
            static let senderField = "sender"
            static let bodyField = "body"
            static let dateField = "date"
}

}
