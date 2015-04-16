//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Oleksandr Iaroshenko on 19.03.15.
//  Copyright (c) 2015 Oleksandr Iaroshenko. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {

    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }

    @IBAction func changeHapiness(gesture: UIPanGestureRecognizer) {
        switch (gesture.state) {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
    }

    var happiness: Int = 75 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
//            println("hapiness = \(happiness)")
            updateUI()
        }
    }

    func updateUI() {
        title = "Happiness = \(happiness)"
        faceView?.setNeedsDisplay()
    }

    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}