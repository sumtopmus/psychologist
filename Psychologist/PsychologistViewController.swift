//
//  ViewController.swift
//  Psychologist
//
//  Created by Oleksandr Iaroshenko on 14.04.15.
//  Copyright (c) 2015 Oleksandr Iaroshenko. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navVC = destination as? UINavigationController {
            destination = navVC.visibleViewController
        }
        if let happinessVC = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch (identifier) {
                case "showSadFace":
                    happinessVC.happiness = 0
                case "showHappyFace":
                    happinessVC.happiness = 100
                case "nothing":
                    happinessVC.happiness = 25
                default:
                    happinessVC.happiness = 50
                }
            }
        }
    }
}