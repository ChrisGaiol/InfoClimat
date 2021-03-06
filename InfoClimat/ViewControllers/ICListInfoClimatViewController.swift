//
//  ICListInfoClimatViewController.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import UIKit

class ICListInfoClimatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ICInfoClimatServiceRequestDelegate {
    
    @IBOutlet weak var tableViewInfoClimat: UITableView!
    
    var infoClimatElementList : [ICInfoClimatElement] = []
    var orderedInfoClimatElements = Dictionary<Date, [ICInfoClimatElement]>()
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewInfoClimat.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshInfoClimat), for: UIControlEvents.valueChanged)
        tableViewInfoClimat.addSubview(refreshControl)
        
        // Launch a request at launching
        self.refreshControl.beginRefreshing()
        self.refreshInfoClimat()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI
    /**
     Called when user needs to refresh
     */
    @objc func refreshInfoClimat() {
        let infoClimatRequest = ICInfoClimatServiceRequest(forLatitude: ICLocationManager.sharedInstance.latitude, andLongitude: ICLocationManager.sharedInstance.longitude)
        infoClimatRequest.delegate = self
        infoClimatRequest.sendRequest()
    }
    
    /**
     Show a Popup indicating a problem to the user and load cache datas
     */
    func refreshEndsWithError() {
        let errorPopup = UIAlertController(title: "Désolé", message: "Impossible de charger les informations actuellement.", preferredStyle: UIAlertControllerStyle.alert)
        errorPopup.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(errorPopup, animated: true, completion: {
            self.refreshControl.endRefreshing() // Doesn't work if doing it before / after
        })
        
        self.loadCacheDatas()
    }
    
    /**
    Load datas in cache
     */
    func loadCacheDatas()
    {
        self.infoClimatElementList = ICInfoClimatElementDAO.sharedInstance.getElementsFromCache()
        orderClimatElements()
        self.tableViewInfoClimat.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetailViewSegue" {
            let detailVC = segue.destination as! ICDetailsViewController
            if let indexPath = self.tableViewInfoClimat.indexPathForSelectedRow {
                detailVC.infoClimatElement = determineInfoClimatForIndexPath(indexPath)
            }
        }
    }
    
    // MARK: - ICInfoClimatServiceRequestDelegate
    func didResponseWithInfoClimatElements(_ infoClimatElements: [ICInfoClimatElement], sender:ICServiceRequest) {
        self.infoClimatElementList = infoClimatElements
        orderClimatElements()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableViewInfoClimat.reloadData()
        }
    }
    
    func didResponseWithError(_ error: Error?, sender:ICServiceRequest) {
        DispatchQueue.main.async {
            self.refreshEndsWithError()
        }
    }
    
    func didThrowException(sender: ICServiceRequest) {
        DispatchQueue.main.async {
            self.refreshEndsWithError()
        }
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
        
        if orderedInfoClimatElements.count <= section { // Safety check
            return cell
        }
        let sectionDate = Array(orderedInfoClimatElements.keys).sorted(by:<)[section]
        
        cell.lblDay.text = sectionDate.getDayLibelle().uppercased()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"InfoClimatCell", for: indexPath) as! ICInfoClimatTableViewCell
        
        // Try to get InfoClimatElement for row
        if orderedInfoClimatElements.count <= indexPath.section { // Safety check
            return cell
        }
        let sectionKey = Array(orderedInfoClimatElements.keys).sorted(by:<)[indexPath.section]
        
        
        guard let infoClimatOfDay = orderedInfoClimatElements[sectionKey] else {
            return cell
        }
        
        if infoClimatOfDay.count <= indexPath.row { // Safety check
            return cell
        }
        let infoClimatElement = infoClimatOfDay[indexPath.row]
        
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
        
        self.infoClimatElementList = self.infoClimatElementList.sorted(by:{ $0.date < $1.date })
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

