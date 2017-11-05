//
//  ICDetailsViewController.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import UIKit

class ICDetailsViewController: UIViewController {
    let bigExtension = "-big"
    
    var infoClimatElement : ICInfoClimatElement?
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var imgMeteo: UIImageView!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blurView.layer.cornerRadius = 30
        blurView.clipsToBounds = true
        
        self.lblDay.text = infoClimatElement?.date.getDayLibelle().uppercased()
        self.lblTime.text = infoClimatElement?.date.getTimeString()
        
        if let imgName = infoClimatElement?.climatType.rawValue {
            self.imgMeteo.image = UIImage(named:imgName + bigExtension)
        }
        
        if let temperature = infoClimatElement?.temperatureCelsius {
            self.lblTemperature.text = String(format: "%.1f°", temperature)
        }
        
        if let humidity = infoClimatElement?.humidite {
            self.lblHumidity.text = "HUMIDITY: \(humidity)%"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        // Prepare animation
        self.blurView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.blurView.alpha = 0
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Launch animation
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                            self.blurView.alpha = 1
                            self.blurView.transform = CGAffineTransform(scaleX: 1, y: 1)
                            self.view.layoutIfNeeded()
                        },
                       completion:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
