//
//  notesSDApp.swift
//  notesSD
//
//  Created by Bhavuk Arora on 27/02/24.
//

import SwiftUI
import SwiftData


@main
struct notesSDApp: App {
    
    let container : ModelContainer = {
        do{
            let schema = Schema([NotesModel.self])
            let container = try ModelContainer(for: schema, configurations: [])
            return container
        }
        catch{
            fatalError("Unable to create ModelContainer")
        }
   
    }()
    
    
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(container)
        
    }
}
