//
//  ContentView.swift
//  RememberMyNumber
//
//  Created by Antony Wilson on 6/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    @State private var contactName: String = ""
    @State private var contactNumber: String = ""
    
    @State private var contacts: [PhoneContact] = [PhoneContact]()
    
    private func populateContacts() {
        contacts = coreDM.getAllContacts()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter name", text: $contactName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter number", text: $contactNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    coreDM.saveContact(name: contactName, number: contactNumber)
                    populateContacts()
                }
                
                List {
                    ForEach (contacts, id: \.self) { contact in
                        NavigationLink(
                            destination: PhoneContactDetail(contact: contact, coreDM: coreDM),
                            label: {
                                Text(contact.name ?? "")
                            }
                        )
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let contact = contacts[index]
                            coreDM.deleteContact(contact: contact)
                            populateContacts()
                        }
                    }).listStyle(PlainListStyle())
                }
                Spacer()
            }.padding()
                .onAppear(perform: {
                    populateContacts()
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

    /*
    var body: some ViewOld {
        VStack {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        Text("Item at \(contact.name!, formatter: itemFormatter)")
                    } label: {
                        Text(contact.name!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/
