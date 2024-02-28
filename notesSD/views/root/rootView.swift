//
//  rootView.swift
//  notesSD
//
//  Created by Bhavuk Arora on 27/02/24.
//

import SwiftUI
import SwiftData

struct RootView: View {
    
    @State private var showWelcomeSheet = UserDefaults.standard.bool(forKey: "showWelcomSheet")
    @Environment (\.modelContext) var context
    @State private var isSheetViewPresented = false
    @Query(sort: \NotesModel.date) var notes: [NotesModel] = []
    @State private var notesToEdit: NotesModel?

  var body: some View {
    NavigationStack {
      List {
        ForEach(notes) { notes in
          notesCell(notes: notes)
                .onTapGesture {
                    notesToEdit = notes
                    
                }
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
          AddNotesSheet(isEditing: false)
          
      })
      .sheet(item: $notesToEdit) { notes in
          UpdateNotesSheet(notes: notes)
      }
      .sheet(isPresented: $showWelcomeSheet) {
          OnboardingSheet()
        }
        .onAppear {
          if !UserDefaults.standard.bool(forKey: "showWelcomSheet") {
            showWelcomeSheet = true
            UserDefaults.standard.set(true, forKey: "showWelcomSheet")
          }
        }
      .toolbar {
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
                .font(.subheadline)
            
            Text(notes.content)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(notes.date, style: .date
            ).font(.subheadline)
        }
    }
}



struct AddNotesSheet: View {
    
    @Environment (\.modelContext) var context
    
    let isEditing: Bool
    @Environment (\.dismiss) var dismiss
    @State var uniqueId = Int64.random(in: 0...1000)
    @State private var name = ""
    @State private var content = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            Form{
                
                TextField("Add title", text: $name )
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


struct UpdateNotesSheet: View {
    
    @Bindable var notes : NotesModel
    @Environment (\.modelContext) var context
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            
            Form{
                
                TextField("Add title", text: $notes.title)
                TextField("Add content", text: $notes.content)
                DatePicker("Date", selection: $notes.date, displayedComponents: .date)
                
                
            }
            .navigationTitle("Update Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .topBarTrailing, content: {
                    Button("update") {
                       dismiss()
                    }
                })
            }
        }
        
        
    }
}

#Preview {
    RootView()
}
