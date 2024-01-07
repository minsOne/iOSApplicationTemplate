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
        
        let button1 = UIButton()
        button1.frame = .init(x: 50, y: 100, width: 200, height: 100)
        button1.backgroundColor = .systemGray
        button1.layer.borderWidth = 1.0
        button1.layer.borderColor = UIColor.red.cgColor
        button1.setTitle("완료화면1 띄우기", for: .normal)
        view.addSubview(button1)

        let button2 = UIButton()
        button2.frame = .init(x: 50, y: 250, width: 200, height: 100)
        button2.backgroundColor = .systemGray
        button2.layer.borderWidth = 1.0
        button2.layer.borderColor = UIColor.green.cgColor
        button2.setTitle("완료화면2 띄우기", for: .normal)
        view.addSubview(button2)

        button1.rx.tap
            .bind(onNext: { [weak self] in
                self?.listener?.requestSettings()
            })
            .disposed(by: disposeBag)
    }
}
