//
//  LuanchViewController.swift
//  MarvelApp
//
//  Created by Ali Merhie on 8/18/20.
//  Copyright © 2020 Ali Merhie. All rights reserved.
//

import UIKit
//import Lottie

class LandingViewController: BaseViewController<LandingVM>, UIScrollViewDelegate {
    
    override class var pageStoryBoard: AppStoryboard {
        get { return .OnBoard }
    }
    
    internal var presenter: LandingViewControllerPresenter!
//    let animationView = AnimationView()


    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    let cellIdentinfier = "IntroductionCollectionViewCell"

    override func viewDidLoad() {
        isLightStatus = true
        setupCollectionView()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2

        self.navigationController?.navigationBar.isHidden = true
        presenter = LandingViewControllerPresenter(delegate: self)
        view.bringSubviewToFront(pageControl)
        pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 2)
        startButton.setTitle("Let's Get Started", for: .normal)

    }
    
    @IBAction func startClicked(_ sender: Any) {
        _ = CharactersViewController.setRootNavigationController()
    }
}

extension LandingViewController: LandingViewControllerDelegate{
    func updateText(title: String) {
        titleLabel.text = title
    }
    
    func reloadCollectionData() {
        collectionView.reloadData()
    }
    
    func didSelectCollectionRow(indexPath: IndexPath) {
        
    }
    
    func currentPageChanged(index: Int) {
      pageControl.currentPage = index
    }
}
