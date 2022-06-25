//
//  AddPhoneContact.swift
//  RememberMyNumber
//
//  Created by Antony Wilson on 6/16/22.
//

import SwiftUI

struct AddPhoneContact: View {
    @State private var contactName: String = ""
    @State private var contactNumber: String = ""
    let coreDM: CoreDataManager

    var body: some View {
        VStack {
            TextField("John Doe", text:$contactName).textFieldStyle(PlainTextFieldStyle())
            TextField("410-555-5252", text:$contactNumber).textFieldStyle(PlainTextFieldStyle())
            Button("Save") {
                if !contactName.isEmpty {
                    coreDM.saveContact(name: contactName, number: contactNumber)
                    coreDM.updateContact()
                }
            }
        }.padding()
    }
}

struct AddPhoneContact_Previews: PreviewProvider {
    static var previews: some View {
        let coreDM = CoreDataManager()
        AddPhoneContact(coreDM: coreDM)
    }
}
