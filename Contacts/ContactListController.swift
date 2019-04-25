//
//  ContactListController.swift
//  Contacts
//
//  Created by anna.sibirtseva on 24/04/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import UIKit

extension Contact {
    var firstLetterForSort: String {
       return  String(firstName.first!).uppercased()
    }
}

extension  ContactsSource {
    static var sortedUniqueFirstLetters: [String] {
        let firstLetters = contacts.map { $0.firstLetterForSort }
        let uniqueFirstLetters = Set(firstLetters)
        return Array(uniqueFirstLetters).sorted()
    }
    
    static var sectionedContacts: [[Contact]] {
       return sortedUniqueFirstLetters.map { firstLetter in
            let filteredContacts = contacts.filter { $0.firstLetterForSort == firstLetter }
                return filteredContacts.sorted(by: { $0.firstName < $1.firstName })
            }
        }
    }


class ContactListController: UITableViewController {
    
   var sections = ContactsSource.sectionedContacts
    let sectionTitles = ContactsSource.sortedUniqueFirstLetters

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Data Source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
   override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return sectionTitles
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { fatalError() }
        
        let contact = sections[indexPath.section][indexPath.row]
        
        contactCell.profileImageView.image = contact.image
        contactCell.profileImageView.layer.cornerRadius = 30
        contactCell.nameLabel.text = contact.firstName
        contactCell.cityLabel.text = contact.city
        
        if contact.isFavorite {
            contactCell.favoriteView.image = #imageLiteral(resourceName: "Star")
        }
        return contactCell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80   
    }
    
    
    
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = sections[indexPath.section][indexPath.row]
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController else { return }
            
                contactDetailController.contact = contact
                contactDetailController.delegate = self
                
            }
        }
    
    }
}

extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.street == rhs.street && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.phone == rhs.phone && lhs.email == rhs.email
    }
}

extension ContactListController : ContactDetailControllerDelegate {
    func didMarkAsFavoriteContact(_ contact: Contact) {
        var outerIndex: Int? = nil
        var innerIndex: Int? = nil
        
        for (index, contacts) in sections.enumerated() {
            if let indexOfContact = contacts.firstIndex(of: contact) {
                outerIndex = index
                innerIndex = indexOfContact
                break
            }
        }
        if let outerIndex = outerIndex, let innerIndex = innerIndex {
            var favoriteContact = sections[outerIndex][innerIndex]
            favoriteContact.isFavorite = true
            sections[outerIndex][innerIndex] = favoriteContact
            
            tableView.reloadData() 
        }
    }
}
