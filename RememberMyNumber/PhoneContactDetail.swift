//
//  PhoneContactDetail.swift
//  RememberMyNumber
//
//  Created by Antony Wilson on 6/12/22.
//

import SwiftUI

struct PhoneContactDetail: View {
    
    let contact: PhoneContact
    @State private var contactName: String = ""
    let coreDM: CoreDataManager
    
    var body: some View {
        VStack {
            TextField(contact.name ?? "", text: $contactName).textFieldStyle(PlainTextFieldStyle())
            Button("Call") {
                if !contactName.isEmpty {
                    contact.name = contactName
                    coreDM.updateContact()
                }
            }
        }.padding()
    }
}

struct PhoneContactDetail_Previews: PreviewProvider {
    static var previews: some View {
        let coreDM = CoreDataManager()
        let contact = PhoneContact(context: coreDM.persistentContainer.viewContext)
        PhoneContactDetail(contact: contact, coreDM: coreDM)
    }
}
