//
//  ICInfoClimatServiceRequest.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation

protocol ICInfoClimatServiceRequestDelegate: class {
    /**
     Triggered when the request responds with datas
     
     - parameter infoClimatElements : an ICInfoClimatElement array
     - parameter sender : the ICServiceRequest that responds
     */
    func didResponseWithInfoClimatElements(_ infoClimatElements: [ICInfoClimatElement], sender:ICServiceRequest)
    
    /**
     Triggered when the request responds with error
     
     - parameter error : the returned Error
     - parameter sender : the ICServiceRequest that responds
     */
    func didResponseWithError(_ error: Error?, sender:ICServiceRequest)
    
    /**
     Triggered when the request throwns an exception

     - parameter sender : the ICServiceRequest that reponds
     */
    func didThrowException(sender:ICServiceRequest)
}

class ICInfoClimatServiceRequest : ICServiceRequest {
    private let infoClimatBaseURL = "http://www.infoclimat.fr/public-api/gfs/json"
    private let infoClimatAPIKey = "UUteSVYoUXNUeVViVyFVfABoUGVcKlB3CnYGZQ1oVisCaVY3VDRcOlM9Uy4CLQUzVntVNltgAzNQOwd%2FWylRMFE7XjJWPVE2VDtVMFd4VX4ALlAxXHxQdwphBmcNflY3AmVWO1QpXD5TIlMzAjQFLlZ6VTRbYQM7UDoHZ1s%2BUTdRNF47VjRRLFQkVTJXblU3AGdQOFxjUGgKOwY0DWZWNwJjVmBUN1wgUz5TOAIwBTFWYlU8W2QDPFAsB39bT1FBUS9eelZ3UWZUfVUqVzJVPwBn&_c=08b4f927d24269d729b600bd5aef790d"
    
    weak var delegate: ICInfoClimatServiceRequestDelegate?
    var latitude : Float = 0.0, longitude : Float = 0.0
    
    /**
     Init a new request for a position
     
     - parameter latitude : the latitude for the request
     - parameter longitude : the longitude for the resquest
     - returns : a new ICInfoClimatServiceRequest
     */
    init(forLatitude latitude : Float, andLongitude longitude : Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func sendRequest() {
        
        let session = URLSession.shared
        
        let requestURL = URL(string: "\(infoClimatBaseURL)?_ll=\(latitude),\(longitude)&_auth=\(infoClimatAPIKey)")!
        
        let dataTask = session.dataTask(with:requestURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                self.delegate?.didResponseWithError(error, sender:self)
                print("Error:\n\(error)")
            }
            else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("Received datas:\n\(dataString!)")
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String:AnyObject] {
                            let infoClimatElements = ICInfoClimatElementFactory.sharedInstance.getInfoClimatElements(fromJson: json);
                            self.delegate?.didResponseWithInfoClimatElements(infoClimatElements, sender:self)
                        }
                    } catch {
                         print("Exception trhown while trying to parse json.")
                        self.delegate?.didThrowException(sender: self)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
