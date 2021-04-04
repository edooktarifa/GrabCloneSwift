//
//  BottomTipsVC.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 02/04/21.
//

import UIKit

class BottomTipsVC: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    var didTapButton: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }

    private func configureView(){
        self.view.layer.cornerRadius = CGFloat(20)
        self.view.clipsToBounds = true
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        startButton.layer.cornerRadius = 24
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton){
        didTapButton?()
    }
}
