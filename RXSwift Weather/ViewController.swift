//
//  ViewController.swift
//  RXSwift Weather
//
//  Created by Israel Mayor on 30/11/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = WeatherViewModel()
    private let cebuGeoLocation = "10.3157,123.8854"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tagGestureRegcognizer: UITapGestureRecognizer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchBar.placeholder = "Enter Lat and Long (10.3157,123.8854))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRx()
    }
    
    func setUpRx() {
        viewModel.data
            .do(onNext: { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .drive(tableView.rx.items(cellIdentifier: "CellWeather", cellType: WeatherCell.self)) { index, weather, cell in
                cell.weather = weather
            }.addDisposableTo(disposeBag)
        
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        searchBar.rx.text.orEmpty
            .subscribe(onNext: { (str) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = !str.isEmpty
            })
            .addDisposableTo(disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .map({ "" })
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        viewModel.data
            .map({ "Weather Status for \($0.count) days" })
            .drive(navigationItem.rx.title)
            .addDisposableTo(disposeBag)
        
        tagGestureRegcognizer.rx.event.asDriver()
            .drive(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
            .addDisposableTo(disposeBag)
    }

}


