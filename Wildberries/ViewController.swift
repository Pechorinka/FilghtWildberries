//
//  ViewController.swift
//  Wildberries
//
//  Created by Tatyana Sidoryuk on 02.06.2022.
//

import Foundation
import UIKit

public var flights = [Flight]()
public var flightNumber = 0
public var likes = [Bool]()

public func DateFromWebtoApp(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "dd-MM-yyyy"
    return  dateFormatter.string(from: date!)
}
public func TimeFromWebtoApp(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "HH:mm"
    return  dateFormatter.string(from: date!)
}
public func ShortTimeFromWebtoApp(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "dd MMM"
    return  dateFormatter.string(from: date!)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath) as! FlightCell
            let flight = flights[indexPath.section]
            cell.startCityLabel.text = flight.startCity
            cell.endCityLabel.text = flight.endCity
            cell.startCityCodeLabel.text = flight.startCityCode.uppercased()
            cell.endCityCodeLabel.text = flight.endCityCode.uppercased()
            cell.startDateLabel.text = ShortTimeFromWebtoApp(flight.startDate)
            cell.endDateLabel.text = ShortTimeFromWebtoApp(flight.endDate)
            cell.priceLabel.text = String(flight.price) + " ₽"

            
            if cell.myLike1.isLiked != likes[indexPath.section] {
                cell.myLike1.flipLikedState()
            }
            cell.delegate = self
        
            return cell
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return flights.count
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
         tableView.dataSource = self
         tableView.backgroundColor = .white
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.register(FlightCell.self, forCellReuseIdentifier: "FlightCell")
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
         tableView.delegate = self
         tableView.separatorStyle = .none
         return tableView
     } ()
    
    private lazy var image: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "logo_wildberries_gradient.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .medium)
      view.color = .purple
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.titleView?.isHidden = true
        view.addSubview(tableView)
        view.addSubview(image)
        view.addSubview(indicatorView)
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        

        let topImageViewConstraint = self.image.topAnchor.constraint(equalTo: super.view.topAnchor)
        let leftImageViewConstraint = self.image.leadingAnchor.constraint(equalTo: super.view.leadingAnchor)
        let trailingImageViewConstraint = self.image.trailingAnchor.constraint(equalTo: super.view.trailingAnchor)
        let heightImageViewConstraint = self.image.heightAnchor.constraint(equalToConstant: 120)
        
        let topTableViewConstraint = self.tableView.topAnchor.constraint(equalTo: self.image.bottomAnchor)
        let leadingTableViewConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        let trailingTableViewConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        let bottomTableViewConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let first = indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let second = indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
       
        NSLayoutConstraint.activate([
                                     topTableViewConstraint, leadingTableViewConstraint, trailingTableViewConstraint, bottomTableViewConstraint,
                                     topImageViewConstraint, leftImageViewConstraint, trailingImageViewConstraint, heightImageViewConstraint,
                                     first, second
        ])

        let urlString = "https://travel.wildberries.ru/statistics/v1/cheap"
        
        if let url = URL (string: urlString) {
            if let data = try? Data (contentsOf: url) {
                parse(json: data)
            }
        }
        
        func parse (json: Data) {
            let decoder = JSONDecoder()
            if let jsonFlights = try? decoder.decode(Flights.self, from: json) {
                flights = jsonFlights.data
                likes = [Bool] (repeating: false, count: flights.count)
                self.tableView.reloadData()
            }
        }
        self.tableView.reloadData()
        
        self.indicatorView.stopAnimating()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ViewController: MyTableViewCellDelegate, SecondViewDelegate {
    func tappedLike(number: Int) {
        tableView.reloadData()
    }
    func tapFlight(cell: FlightCell) {
        guard let index = self.tableView.indexPath(for: cell)?.section else { return }
        flightNumber = index
        let thisFlight = SecondViewController()
        thisFlight.delegate = self
        self.navigationController?.pushViewController(thisFlight, animated: true)
    }
    func tappedLike (cell: FlightCell) {
        guard let index = self.tableView.indexPath(for: cell)?.section else { return }
        likes[index].toggle()
    }
}
