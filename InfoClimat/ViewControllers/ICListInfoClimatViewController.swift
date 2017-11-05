//
//  ICListInfoClimatViewController.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import UIKit

class ICListInfoClimatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewInfoClimat: UITableView!
    
    var infoClimatElementList : [ICInfoClimatElement] = []
    var orderedInfoClimatElements = Dictionary<Date, [ICInfoClimatElement]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        infoClimatElementList = ICInfoClimatElementMock.infoClimatElementArray
        orderClimatElements()
        
        tableViewInfoClimat.delegate = self
        self.tableViewInfoClimat.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView Delegate / DataSource Implementation
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderedInfoClimatElements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = Array(orderedInfoClimatElements.keys).sorted(by:<)[section]
        
        guard let nb = orderedInfoClimatElements[sectionKey]?.count else {
            return 0
        }
        return nb;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier:"DayHeaderCell") as! ICDayHeaderTableViewCell
        
        let sectionDate = Array(orderedInfoClimatElements.keys).sorted(by:<)[section]
        
        cell.lblDay.text = sectionDate.getDayLibelle().uppercased()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"InfoClimatCell", for: indexPath) as! ICInfoClimatTableViewCell
        
        // Try to get InfoClimatElement for row
        let sectionKey = Array(orderedInfoClimatElements.keys).sorted(by:<)[indexPath.section]
        guard let infoClimatElement = orderedInfoClimatElements[sectionKey]?[indexPath.row] else {
            return cell
        }
        
        // Complete cell UI
        cell.lblTime.text = infoClimatElement.date.getTimeString()
        if let temperature = infoClimatElement.temperatureCelsius {
            cell.lblTemperature.text = String(format: "%.1f°", temperature)
        }
        
        cell.imgClimat.image = UIImage(named:infoClimatElement.climatType.rawValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // MARK: - Utils func
    /**
     Order the ICInfoClimatElement List in the orderedInfoClimatElements Dictionary by Date
     It allows to access it easier
     */
    func orderClimatElements() {
        orderedInfoClimatElements = Dictionary<Date, [ICInfoClimatElement]>()
        for infoClimat in infoClimatElementList
        {
            let dateString : String = infoClimat.date.getDateString()
            let date : Date = Date(dateString: dateString)
            
            if(orderedInfoClimatElements.keys.contains(date))
            {
                var infoClimatList = orderedInfoClimatElements[date]
                infoClimatList?.append(infoClimat)
                orderedInfoClimatElements[date] = infoClimatList
            }
            else
            {
                let infoClimatList = [infoClimat]
                orderedInfoClimatElements[date] = infoClimatList
            }
        }
    }
    
    /**
     Get the correct ICInfoClimatElement for an indexPath
     - returns : an ICInfoclimatElement
     */
    func determineInfoClimatForIndexPath(_ indexPath:IndexPath) -> ICInfoClimatElement? {
        let sectionKey = Array(orderedInfoClimatElements.keys).sorted(by:<)[indexPath.section]
        guard let infoClimatElement = orderedInfoClimatElements[sectionKey]?[indexPath.row] else {
            return nil
        }
        return infoClimatElement
    }


}

