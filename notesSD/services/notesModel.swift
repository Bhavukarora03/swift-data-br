//
//  notesModel.swift
//  notesSD
//
//  Created by Bhavuk Arora on 27/02/24.
//

import Foundation
import SwiftData


@Model
class NotesModel {
    @Attribute(.unique) let id : Int64
    var title : String
    var content : String
    var date : Date
    
    
    init(id: Int64, title: String, content: String, date: Date) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
    }
   
}
