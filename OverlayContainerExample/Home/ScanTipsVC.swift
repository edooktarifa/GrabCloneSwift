//
//  ScanTipsVC.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 02/04/21.
//

import UIKit

class ScanTipsVC: UIViewController {

    @IBOutlet weak var topViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
        self.configureTopView()
    }

    private func configureView(){
        pageIndicator.numberOfPages = 4
        let heightWidth = downView.frame.size.width
        let path = CGMutablePath()
        containerView.layer.cornerRadius = 8.0
        containerView.clipsToBounds = true
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        downView.layer.insertSublayer(shape, at: 0)
    }
    
    private func configureTopView(){
        let heightWidth = topView.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.white.cgColor

        topView.layer.insertSublayer(shape, at: 0)
    }
}
