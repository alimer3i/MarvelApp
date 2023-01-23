//
//  BaseViewController.swift
//  MarvelApp
//
//  Created by Ali Merhie on 8/30/21.
//

import Foundation
import UIKit
import MBProgressHUD
import SkeletonView
import Combine

class BaseViewController<Element: BaseVM>: UIViewController, Storyboarded, ScreenLoader {
    
    var cancellables = Set<AnyCancellable>()
    class var pageStoryBoard: AppStoryboard { get { return .Main } }
    internal var viewModel = Element()
    var isLightStatus = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = isLightStatus ? .lightContent : .darkContent
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidBecomeActiveNotification(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    internal func bindToViewModel() {
        
        viewModel.$popViewController
            .sink(self) { _, strongSelf in
                strongSelf.navigationController?.popViewController()
            }.store(in: &cancellables)
        
        viewModel.$showLoader
            .sink(self) { message, strongSelf in
                let hud = MBProgressHUD.showAdded(to:strongSelf.view, animated: true)
                hud.label.text = message
                hud.isUserInteractionEnabled = true
            }.store(in: &cancellables)
        
        viewModel.$hideLoader
            .sink(self) { _, strongSelf in
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
            }.store(in: &cancellables)
        
        
        viewModel.$startSkeletonAnimation
            .sink(self) { _, strongSelf in
                strongSelf.view.showAnimatedGradientSkeleton()
            }.store(in: &cancellables)
        
        viewModel.$hideSkeletonAnimation
            .sink(self) { _, strongSelf in
                strongSelf.view.hideSkeleton()
            }.store(in: &cancellables)
    }
    
    internal func displayAlert(title: String, message: String, cancelText: String) {
        //        let vc = UIApplication.getTopViewController()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelText, style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func displayConfirmAlert(title: String, message: String, confirmText: String, cancelText: String, completion: @escaping (Bool) -> () ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelText, style: .destructive,  handler: { (action) in completion(false) })
        let confirm = UIAlertAction(title: confirmText, style: .default, handler: { (action) in completion(true) })
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func reloadPage(_ notification:Notification) {
        self.viewDidLoad()
    }
    @objc func handleAppDidBecomeActiveNotification(notification: Notification) {
        print("did become active \(self)")
    }
    @objc func willEnterForeground() {
        print("will enter foreground \(self)")
    }
    @objc func keyboardWillAppear() {
        print("keyboard will appear")
    }
    
    @objc func keyboardWillDisappear() {
        print("keyboard will disappear")
    }
    
    deinit {
        print("Memory to be released soon \(self)")
    }
}
