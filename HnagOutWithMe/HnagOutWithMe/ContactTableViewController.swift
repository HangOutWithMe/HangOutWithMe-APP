//
//  ContactTableViewController.swift
//  Yolo
//
//  Created by Boran Liu on 11/1/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    
    let exampleContacts = ["Actinium",
        "Aluminium",
        "Americium",
        "Antimony",
        "Argon",
        "Arsenic",
        "Astatine",
        "Barium",
        "Berkelium",
        "Beryllium",
        "Bismuth",
        "Bohrium",
        "Boron",
        "Bromine",
        "Cadmium",
        "Caesium",
        "Calcium",
        "Californium",
        "Carbon",
        "Cerium",
        "Chlorine",
        "Chromium",
        "Cobalt",
        "Copernicium",
        "Copper",
        "Curium",
        "Darmstadtium",
        "Dubnium",
        "Dysprosium",
        "Einsteinium",
        "Erbium",
        "Europium",
        "Fermium",
        "Fluorine",
        "Francium",
        "Gadolinium",
        "Gallium",
        "Germanium",
        "Gold",
        "Hafnium",
        "Hassium",
        "Helium",
        "Holmium",
        "Hydrogen",
        "Indium",
        "Iodine",
        "Iridium",
        "Iron",
        "Krypton",
        "Lanthanum",
        "Lawrencium",
        "Lead",
        "Lithium",
        "Lutetium",
        "Magnesium",
        "Manganese",
        "Meitnerium",
        "Mendelevium",
        "Mercury",
        "Molybdenum",
        "Neodymium",
        "Neon",
        "Neptunium",
        "Nickel",
        "Niobium",
        "Nitrogen",
        "Nobelium",
        "Osmium",
        "Oxygen",
        "Palladium",
        "Phosphorus",
        "Platinum",
        "Plutonium",
        "Polonium",
        "Potassium",
        "Praseodymium",
        "Promethium",
        "Protactinium",
        "Radium",
        "Radon",
        "Rhenium",
        "Rhodium",
        "Roentgenium",
        "Rubidium",
        "Ruthenium",
        "Rutherfordium",
        "Samarium",
        "Scandium",
        "Seaborgium",
        "Selenium",
        "Silicon",
        "Silver",
        "Sodium",
        "Strontium",
        "Sulfur",
        "Tantalum",
        "Technetium",
        "Tellurium",
        "Terbium",
        "Thallium",
        "Thorium",
        "Thulium",
        "Tin",
        "Titanium",
        "Tungsten",
        "Ununhexium",
        "Ununoctium",
        "Ununpentium",
        "Ununquadium",
        "Ununseptium",
        "Ununtrium",
        "Uranium",
        "Vanadium",
        "Xenon",
        "Ytterbium",
        "Yttrium",
        "Zinc",
        "Zirconium"]

    var sectionsToCharacterKeys: [Character]!
    
    var contactsDirectory: [Character: [String]]!
    
    func processContacts(contacts: [String]) -> [Character: [String]] {
        var directory = [Character: [String]]()
        for contact in contacts {
            let character = contact[contact.startIndex]
            
            if directory[character] == nil {
                directory[character] = [String]()
            }
            
            directory[character]?.append(contact)
        }
        
        return directory
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        contactsDirectory = processContacts(exampleContacts)
        sectionsToCharacterKeys = Array(contactsDirectory.keys).sort()
        self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, CGRectGetHeight(self.tabBarController!.tabBar.frame), 0.0)
        self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.navigationItem.title = "Contact"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addFunc")
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton

    }
    
    func addFunc() {
        let addPage = (self.storyboard?.instantiateViewControllerWithIdentifier("addFriends"))! as UIViewController
        self.navigationController?.pushViewController(addPage, animated: true)
        addPage.navigationItem.title = "Add Contacts"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return contactsDirectory.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let characterKey = sectionsToCharacterKeys[section]
        
        if let count = contactsDirectory[characterKey]?.count {
            return count
        } else {
            return 0
        }

    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell")
        cell?.textLabel?.text = String(sectionsToCharacterKeys[section])
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RowCell", forIndexPath: indexPath)
        
        let characterKey = sectionsToCharacterKeys[indexPath.section]
        let contactValue = contactsDirectory[characterKey]?[indexPath.row]
        
        cell.textLabel?.text = contactValue
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
