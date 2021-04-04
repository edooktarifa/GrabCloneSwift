//
//  OverlayPresentationController.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 02/04/21.
//

import Foundation
import UIKit

class OverlayPresentationController: UIPresentationController {

    private var dimmedBackgroundView = UIView()
    private let height: CGFloat = 200.0
    private var parentViewController: UIViewController?
    private var tipsView: ScanTipsVC?
    private var index: Int = 0
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.parentViewController = presentingViewController
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
//        self.dimmedBackgroundView.addGestureRecognizer(tapGestureRecognizer)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var frame =  CGRect.zero
        if let containerBounds = containerView?.bounds {
            if presentedViewController is BottomTipsVC {
                if let tipsView = presentedViewController as? BottomTipsVC {
                    let window = UIApplication.shared.windows[0]
                    let bottomPadding = window.safeAreaInsets.bottom

                    frame = CGRect(x:0, y: containerBounds.height - (380 + bottomPadding), width: containerBounds.width, height: 380 + bottomPadding)
                    tipsView.didTapButton = {[weak self]() in
                        guard let self = self else { return }
                        self.presentingViewController.removeChild(tipsView)
                        self.configureScanQrTips()
                    }
                }
            }
            
        }
        return frame
    }

    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.backgroundColor = .black
            self.dimmedBackgroundView.frame = containerView.bounds
            self.dimmedBackgroundView.alpha = 0
            coordinator.animate(alongsideTransition: { _ in
                self.dimmedBackgroundView.alpha = 0.4
            }, completion: nil)
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
//        self.dimmedBackgroundView.removeFromSuperview()
    }
    
    private func configureScanQrTips(){
        if parentViewController is ViewController {
            guard let mainView = parentViewController as? ViewController else { return }
            let buttonScanQr = mainView.qrBtn.frame

            if let containerView = self.containerView {
                DispatchQueue.main.async {
                    self.dimmedBackgroundView.removeFromSuperview()
                    self.tipsView = ScanTipsVC(nibName: "ScanTipsVC", bundle: nil)
                    guard let tipsView = self.tipsView else { return }

                    self.dimmedBackgroundView = self.createOverlay(frame: mainView.view.bounds, offset: CGRect(x: buttonScanQr.origin.x - 1 , y: buttonScanQr.origin.y - 1, width: 72, height: 72), radius: 72/2)
                    containerView.addSubview(self.dimmedBackgroundView)
                    self.dimmedBackgroundView.addSubview(tipsView.view)
                    let frame = CGRect(x:20, y: buttonScanQr.origin.y - 140, width: containerView.bounds.width - 40, height: 160)
                    self.scanQRTipsView(frame: frame)
                    tipsView.skipButton.addTarget(self, action: #selector(self.backgroundTapped), for: .touchUpInside)
                }
            }
        }
    }
    
    private func scanQRTipsView(frame: CGRect){
        guard let tipsView = self.tipsView else { return }
        tipsView.view.frame = frame
        tipsView.titleLabel.text = "Pilih Icon Bayar"
        tipsView.descriptionLabel.text = "Kemudahan pembayaran non tunai dengan scan barcode yang diterima di semua toko berlogo QRIS"
        tipsView.topView.isHidden = true
        tipsView.pageIndicator.currentPage = 0
        self.index = 1
        tipsView.nextButton.addTarget(self, action: #selector(self.onNextScanQRTipsAction), for: .touchUpInside)
    }
    
    @objc func onNextScanQRTipsAction(){
        DispatchQueue.main.async { [self] in
            switch self.index {
            case 1:
                self.confgureTipsView()
                self.index = 2
                print(index)
                break
            case 2:
                self.confgureTipsView()
                self.index = 3
                break
            case 3:
                self.confgureTipsView()
                self.index = 3
                break
            default:
                break
            }
        }
        
    }
    
    private func confgureTipsView(){
        guard let containerView = self.containerView else { return }
        guard let mainView = parentViewController as? ViewController else { return }
//        mainView.cardViewController.view.safeAreaLayoutGuide
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        self.dimmedBackgroundView.removeFromSuperview()
        guard let tipsView = self.tipsView else { return }
        tipsView.pageIndicator.currentPage = index
        if index == 1 {
            tipsView.titleLabel.text = "Riwayat transaksi kamu lengkap"
            tipsView.descriptionLabel.text = "Kamu bisa transaksi dengan menggunakan QR"
            self.dimmedBackgroundView = self.createOverlay(frame: mainView.view.bounds, offset: CGRect(x: mainView.view.bounds.width - 68 , y: 142 + statusBarHeight, width: 45, height: 45), radius: 45/2)
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.addSubview(tipsView.view)
            tipsView.topView.isHidden = false
            tipsView.downView.isHidden = true
            tipsView.topViewConstraints.constant = containerView.bounds.width - 80
            tipsView.view.frame = CGRect(x:20, y: 104 + 104 + statusBarHeight, width: containerView.bounds.width - 40, height: 150)
        } else if index == 2 {
            tipsView.titleLabel.text = "Rewards"
            tipsView.descriptionLabel.text = "Kamu bisa mendapatkan reward dari app Grab"
            self.dimmedBackgroundView = self.createOverlay(frame: mainView.view.bounds, offset: CGRect(x: mainView.view.bounds.width - 104 , y: 204 + statusBarHeight , width: 40, height: 40), radius: 40/2)
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.addSubview(tipsView.view)
            tipsView.topViewConstraints.constant = containerView.bounds.width - 100
            tipsView.view.frame = CGRect(x:5, y: 260 + statusBarHeight, width: containerView.bounds.width - 40, height: 150)
        } else if index == 3 {
            tipsView.titleLabel.text = "Banyak promo menanti kamu"
            tipsView.descriptionLabel.text = "Kamu bisa update info promo terbaru SPIN di sini."
            self.dimmedBackgroundView = self.createOverlay(frame: mainView.view.bounds, offset: CGRect(x: mainView.view.bounds.width - 91.5 , y: 91 + statusBarHeight , width: 36, height: 36), radius: 36/2)
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.addSubview(tipsView.view)
            tipsView.topViewConstraints.constant = containerView.bounds.width - 100
            tipsView.view.frame = CGRect(x:20, y: 125 + statusBarHeight, width: containerView.bounds.width - 40, height: 116)
            tipsView.skipButton.isHidden = true
            tipsView.nextButton.setTitle("Mengerti", for: .normal)
            tipsView.nextButton.addTarget(self, action: #selector(self.backgroundTapped), for: .touchUpInside)
        }
    }
    
    private func createOverlay(frame: CGRect, offset: CGRect, radius: CGFloat) -> UIView {
        self.presentedViewController.view.layoutIfNeeded()
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let path = CGMutablePath()
        path.addRoundedRect(in: offset, cornerWidth: radius, cornerHeight: radius)
        path.addRect(frame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        
        maskLayer.fillRule = .evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true

        return overlayView
    }
    

    @objc private func backgroundTapped() {
       self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
