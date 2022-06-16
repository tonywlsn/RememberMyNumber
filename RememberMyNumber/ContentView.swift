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
    @State private var contactName: String = "John Doe"
    @State private var contactNumber: String = "410-555-5555"
    @State private var isActive = false
    
    @State private var contacts: [PhoneContact] = [PhoneContact]()
    
    private func populateContacts() {
        contacts = coreDM.getAllContacts()
    }
    
    var body: some View {
        NavigationView {
            VStack {
/*
                TextField("Enter name", text: $contactName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter number", text: $contactNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    coreDM.saveContact(name: contactName, number: contactNumber)
                    populateContacts()
 */
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
            }.navigationBarTitle("RememberMyNumber")
                .navigationBarItems(
                      trailing: Button(action: {}, label: {
                         NavigationLink(destination:
                                            AddPhoneContact(coreDM: coreDM)) {
                              Image(systemName: "plus")
                         }
                      }))
                Spacer()
            }.padding()
                .onAppear(perform: {
                    populateContacts()
                })
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(coreDM: CoreDataManager())
            ContentView(coreDM: CoreDataManager())
            ContentView(coreDM: CoreDataManager())
        }
    }
}
