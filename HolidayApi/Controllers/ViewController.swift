//
//  ViewController.swift
//  HolidayApi
//
//  Created by Ethan on 2020/1/29.
//  Copyright © 2020 playplay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var holidayListVM:HolidayListViewModel? = nil
    
    @IBOutlet weak var tableView:UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSearchBar()
        
        //(1) generic做法在下方searchTextDidChange裡
        
        //(2) 用result作法
        
        //        let holidayRequest = HolidayRequest(countryCode: "us")
        //        holidayRequest.getHoliday {[weak self] result in
        //            switch result {
        //
        //            case .failure(let error):
        //                print(error)
        //            case .success(let vm):
        //                self?.holidayListVM = vm
        //                DispatchQueue.main.async {
        //                    self?.tableView.reloadData()
        //                }
        //
        //            }
        //
        //        }
        
        
        //(3) 一般作法
        
        //        WebService().getHoliday(country: "us") {[weak self] (vm) in
        //            self?.holidayListVM = vm
        //
        //            DispatchQueue.main.async {
        //                 self?.tableView.reloadData()
        //            }
        //
        //        }
    }
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let holidayListVM = holidayListVM else { return 0 }
        return holidayListVM.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayCell", for: indexPath) as! HolidayTableViewCell
        cell.holiday = holidayListVM?.getHoliday(indexPath.row)
        return cell
    }
    
    
    func setupSearchBar(){
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = false
        navigationItem.searchController = searchController
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {return}
        
        // generic 作法
        let resource = Resource<HolidayListViewModel>(countryCode:searchText)
        
        GenericWebService().load(resource: resource){[weak self] result in
            switch result {
                
            case .failure(let error):
                print(error)
            case .success(let vm):
                self?.holidayListVM = vm
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    
                }
            }
        }
    }
}


