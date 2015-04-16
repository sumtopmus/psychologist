//
//  DiagnoseHappinessViewController.swift
//  Psychologist
//
//  Created by Oleksandr Iaroshenko on 15.04.15.
//  Copyright (c) 2015 Oleksandr Iaroshenko. All rights reserved.
//

import UIKit

class DiagnoseHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {

    private struct History {
        static let segueIdentifier = "Show Diagnostic History"
        static let defaultsKey = "DiagnosedHappinessViewCOntroller.History"
    }

    private let defaults = NSUserDefaults.standardUserDefaults()

    var diagnosticHistory: [Int] {
        get {
            return defaults.objectForKey(History.defaultsKey) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.defaultsKey)
        }
    }

    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.segueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"

                }
            default:
                break
            }
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}