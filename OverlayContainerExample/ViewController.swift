//
//  ViewController.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 01/04/21.
//

import UIKit
import OverlayContainer

class ViewController: UIViewController {

    @IBOutlet var cardView: UIView!
    @IBOutlet weak var qrBtn: UIButton!
    
    enum OverlayNotch: Int, CaseIterable {
        case minimum, maximum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let overlayController = OverlayContainerViewController()
        overlayController.delegate = self
        overlayController.viewControllers = [HomeVC()]
        addChild(overlayController, in: cardView)
        qrBtn.layer.cornerRadius = qrBtn.frame.height/2
        overlayController.moveOverlay(toNotchAt: OverlayNotch.maximum.rawValue, animated: true)
        
        let bottomTipsView = BottomTipsVC()
        bottomTipsView.transitioningDelegate  = self
        bottomTipsView.modalPresentationStyle = .custom
        self.present(bottomTipsView, animated: true, completion: nil)
        navigationController?.navigationBar.isHidden = true
        
        qrBtn.layer.borderWidth = 1
        qrBtn.layer.borderColor = UIColor.lightGray.cgColor
        qrBtn.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    //MARK: -ActionButton
    @IBAction func qrButtonOnClick(_ sender: UIButton){
        print("onClick")
    }
}

extension ViewController: OverlayContainerViewControllerDelegate{
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        let notch = OverlayNotch.allCases[index]
        return notchHeight(for: notch, availableSpace: availableSpace)
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return OverlayNotch.allCases.count
    }
    
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        scrollViewDrivingOverlay overlayViewController: UIViewController) -> UIScrollView? {
        return (overlayViewController as? HomeVC)?.tableView
    }
    
    private func notchHeight(for notch: OverlayNotch, availableSpace: CGFloat) -> CGFloat{
        switch notch {
        case .maximum:
            return availableSpace
        case .minimum:
            return availableSpace * 1 / 1.5
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return OverlayPresentationController(presentedViewController:presented, presenting: self)
    }
}
