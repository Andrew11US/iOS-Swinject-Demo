//
//  ViewController.swift
//  Swinject Demo
//
//  Created by Andrew on 9/10/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit
import Swinject

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = Container()
        container.register(NetworkServicing.self) { _ in NetworkService() }
        container.register(ViewModel.self) { resolver in
            let viewModel = ViewModel()
            viewModel.service = resolver.resolve(NetworkServicing.self)
            return viewModel
        }
        
        let viewModel: ViewModel? = container.resolve(ViewModel.self)
        viewModel?.loadData()
    }


}

class ViewModel {
    var service: NetworkServicing!
    
    func loadData() {
        service.getData()
    }
}

struct NetworkService: NetworkServicing {
    func getData() {
        print("Data has been fetched")
    }
}

protocol NetworkServicing {
    func getData()
}

