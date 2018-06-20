//
//  ViewController.swift
//  Battery Charge
//
//  Created by Cameron Swenson on 6/19/18.
//  Copyright © 2018 Cameron Swenson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Set up phone battery data
    var phoneBatteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    var phoneBatteryState: UIDeviceBatteryState {
        return UIDevice.current.batteryState
    }
    var phoneChargeStateText: String {
        var str = ""
        //Check which state we are in and give it a label
        switch phoneBatteryState {
        case .charging: str = "Charging"
        case .full: str = "Full"
        case .unknown: str = "Unknown"
        case .unplugged: str = "Unplugged"
        }
    return str
    }
        
    //Set up text
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Turn on phone battery monitoring
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        //Handle phone battery changes
        NotificationCenter.default.addObserver(self, selector: #selector(phoneBatteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(phoneBatteryStateDidChange), name: .UIDeviceBatteryStateDidChange, object: nil)
        
        updatePhoneLabel()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        view.addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func updatePhoneLabel() {
         textView.text = "Phone Battery Level: \(phoneBatteryLevel * 100), Charger State: \(phoneChargeStateText)"
    }
    
    @objc func phoneBatteryLevelDidChange(_ notification: Notification) {
        updatePhoneLabel()
    }
    
    @objc func phoneBatteryStateDidChange(_ notification: Notification) {
        updatePhoneLabel()
    }
}
