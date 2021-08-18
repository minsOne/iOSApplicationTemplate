//
//  RootViewController.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa

protocol RootPresentableListener: AnyObject {
    func requestSettings()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let button = UIButton()
        button.backgroundColor = .red
        button.frame = .init(x: 50, y: 100, width: 200, height: 200)
        view.addSubview(button)

        button.rx.tap
            .bind(onNext: { [weak self] in
                self?.listener?.requestSettings()
            })
            .disposed(by: disposeBag)
    }
}
