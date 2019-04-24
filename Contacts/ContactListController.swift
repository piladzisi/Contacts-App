//
//  ContactListController.swift
//  Contacts
//
//  Created by anna.sibirtseva on 24/04/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import UIKit

class ContactListController: UITableViewController {
    
    var contacts = ContactsSource.contacts

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.firstName
        
        
        return cell
    }
    
    
}
