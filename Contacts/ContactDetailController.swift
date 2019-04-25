//
//  ContactDetailController.swift
//  Contacts
//
//  Created by anna.sibirtseva on 24/04/2019.
//  Copyright © 2019 anna.sibirtseva. All rights reserved.
//

import UIKit

protocol ContactDetailControllerDelegate: class {
    func didMarkAsFavoriteContact(_ contact: Contact)
}

class ContactDetailController: UITableViewController {
    
    var contact: Contact? //optional because on app load no contact to show
    
    
    // Outlets
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    weak var delegate: ContactDetailControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        profileView.layer.cornerRadius = 50
   }
    
    func configureView() {
        guard let contact = contact else { return }
        profileView.image = contact.image
        nameLabel.text = "\(contact.firstName)  \(contact.lastName)"
        
        phoneNumberLabel.text = contact.phone
        emailLabel.text = contact.email
        streetAddressLabel.text = contact.street
        cityLabel.text = contact.city
        stateLabel.text = contact.state
        zipLabel.text = contact.zip
        
    }
    
    @IBAction func markAsFavorite(_ sender: Any) {
        
        guard let contact = contact else { return }
        delegate?.didMarkAsFavoriteContact(contact)
    }
    
}
