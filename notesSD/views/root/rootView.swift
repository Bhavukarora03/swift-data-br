//
//  rootView.swift
//  notesSD
//
//  Created by Bhavuk Arora on 27/02/24.
//

import SwiftUI
import SwiftData

struct rootView: View {
    @Environment (\.modelContext) var context
  @State private var isSheetViewPresented = false
    @Query(sort: \NotesModel.date) var notes: [NotesModel] = []

  var body: some View {
    NavigationStack {
      List {
        ForEach(notes) { notes in
          notesCell(notes: notes)
        }.onDelete(perform: { indexSet in
            for index in indexSet {
                let note = notes[index]
                context.delete(note)
            }
        })
      
      }
      .navigationTitle("Notes")
      .navigationBarTitleDisplayMode(.large)
      .sheet(isPresented: $isSheetViewPresented, content: {
         AddNotesSheet()
      })
      .toolbar {
        // Conditional visibility for the "Add" button
        if !notes.isEmpty {
          Button("Add", systemImage: "plus") {
            isSheetViewPresented = true
          }
        }
      }
      .overlay {
        if notes.isEmpty {
            ContentUnavailableView(label: {
                Label("Add a note", systemImage: "list.bullet.rectangle.portrait")
            },
                                   
                                   description: {
                Text("add a note here")
            
            },
                                   actions: {
                Button("Add", action: {
                    isSheetViewPresented = true
                })
            }
            )
            
            
        }
      }
    }
  }
}





struct notesCell : View {
    
    let notes : NotesModel
    var body: some View {
        HStack{
            Text(notes.title)
                .font(.title)
            
            Text(notes.content)
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
    }
}



struct AddNotesSheet: View {
    
    @Environment (\.modelContext) var context
    
    @Environment (\.dismiss) var dismiss
    @State var uniqueId = Int64.random(in: 0...1000)
    @State private var name = ""
    @State private var content = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            Form{
                
                TextField("Add title", text: $name)
                TextField("Add content", text: $content)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                
            }
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Save") {
                        let note = NotesModel(id: uniqueId, title: name, content: content, date: date)
                        context.insert(note)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
            }
        }
        
        
    }
}


#Preview {
    rootView()
}
