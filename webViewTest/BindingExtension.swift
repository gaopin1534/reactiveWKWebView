//
//  BindingExtension.swift
//  webViewTest
//
//  Created by 高松　幸平 on 2017/05/23.
//  Copyright © 2017年 高松　幸平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIBarButtonItem {
    var isEnabled: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: base) { button, isEnable in
            button.isEnabled = isEnable
        }
    }
}

extension Reactive where Base: UIProgressView {
    var progress: UIBindingObserver<Base, Float> {
        return UIBindingObserver(UIElement: base) { progressbar, progressRate in
            progressbar.progress = progressRate
        }
    }
    
    var appear: UIBindingObserver<Base, Bool> {
        return UIBindingObserver(UIElement: base) { progressbar, isProgressing in
            progressbar.isHidden = !isProgressing
        }
    }
}
