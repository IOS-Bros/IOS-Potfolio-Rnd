//
//  DBModel.swift
//  RndNew
//
//  Created by SooHoon on 2021/08/03.
//

import Foundation

class DBModel: NSObject{
    var cNo: String?
    var cWriter: String?
    var cContent: String?
    var cSubmitDate: String?

    override init() {
        
    }
    
    init(cNo: String, cWriter: String, cContent: String, cSubmitDate: String) {
        self.cNo = cNo
        self.cWriter = cWriter
        self.cContent = cContent
        self.cSubmitDate = cSubmitDate
        
    }
   
}
