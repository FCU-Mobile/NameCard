//
//  YUNameCardModel.swift
//  NameCard
//
//  Created by 張郁眉 on 2025/9/13.
//

import Foundation


struct YUNameCardModel:Identifiable{
//    Identifiable = 有身分證的物件
//    Identifiable 只需要一個屬性：id
//    通常我們會用 UUID() 自動產生唯一值：
    let id = UUID()
    var name:String
    var phone:String
    var email:String
  
    var title:String?
    var company: String?
//    變數型別後面加 ?，表示它可以 有值 或 沒有值（nil）
//    不用 ?，就必須要保證它一定有值，不能為空
    var note:String
}
