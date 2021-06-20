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

protocol RootPresentableListener: AnyObject {}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
}
