//
//  BaseVM.swift
//  MarvelApp
//
//  Created by Ali Merhie on 9/1/21.
//

import Foundation

class BaseVM {
    
    @SubjectAction<String>var showLoader
    @Action var hideLoader
    @Action var startSkeletonAnimation
    @Action var hideSkeletonAnimation
    @Action var popViewController

    required init() {
        print("BASEVM")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Memory to be released soon \(self)")
    }
}
