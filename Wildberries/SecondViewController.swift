//
//  SecondViewController.swift
//  Wildberries
//
//  Created by Alexey Sidoryuk on 04.06.2022.
//

import Foundation
import UIKit

protocol SecondViewDelegate  {
    func tappedLike (number: Int)
}

extension NSNotification.Name {
    static let myNotification = NSNotification.Name ("isLiked")
}

class SecondViewController: UIViewController {
    
    var delegate: SecondViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.backButtonTitle = "Назад"
        self.view.addSubview(backView)
        self.backView.addSubview(contentView)
        self.contentView.addSubview(price)
        self.contentView.addSubview(plane)
        self.contentView.addSubview(time1)
        self.contentView.addSubview(time2)
        self.contentView.addSubview(shortTime1)
        self.contentView.addSubview(shortTime2)
        self.contentView.addSubview(city1)
        self.contentView.addSubview(city1Code)
        self.contentView.addSubview(city2)
        self.contentView.addSubview(city2Code)
        self.contentView.addSubview(plane2)
        self.contentView.addSubview(myLike)
        self.contentView.addSubview(button)
        setupConstraints()
        
        if likes[flightNumber] == true {
            myLike.flipLikedState()
        }
    }

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
   private lazy var time1: UILabel = {
        let day = UILabel()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        day.textColor = .black
        let flight = flights[flightNumber]
        day.text = TimeFromWebtoApp (flight.startDate)
        return day
    }()
    
    private lazy var time2: UILabel = {
         let day = UILabel()
         day.translatesAutoresizingMaskIntoConstraints = false
         day.font = UIFont.systemFont(ofSize: 20, weight: .bold)
         day.textColor = .black
         let flight = flights[flightNumber]
         day.text = TimeFromWebtoApp (flight.endDate)
         return day
     }()
    
    private lazy var city1: UITextView = {
         let city = UITextView()
         city.translatesAutoresizingMaskIntoConstraints = false
         city.font = UIFont.systemFont(ofSize: 20, weight: .bold)
         city.textColor = .black
         let flight = flights[flightNumber]
         city.text = flight.startCity
         city.isUserInteractionEnabled = false
         return city
     }()
    
    private lazy var city1Code: UILabel = {
         let city = UILabel()
         city.translatesAutoresizingMaskIntoConstraints = false
         city.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         city.textColor = .darkGray
         let flight = flights[flightNumber]
         city.text = flight.startCityCode.uppercased()
         return city
     }()
    
    private lazy var city2: UITextView = {
         let city = UITextView()
         city.translatesAutoresizingMaskIntoConstraints = false
         city.font = UIFont.systemFont(ofSize: 20, weight: .bold)
         city.textColor = .black
         let flight = flights[flightNumber]
         city.text = flight.endCity
        city.isUserInteractionEnabled = false
         return city
     }()
    
    public lazy var myLike: HeartButton = {
        let like = HeartButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        like.translatesAutoresizingMaskIntoConstraints = false
        like.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        like.isUserInteractionEnabled = true
        return like
    } ()
    
    @objc func didTapButton(sender: UIButton)
    {
        myLike.flipLikedState()
        likes[flightNumber].toggle()
        delegate?.tappedLike(number: flightNumber)
    }
    
    private lazy var city2Code: UILabel = {
         let city = UILabel()
         city.translatesAutoresizingMaskIntoConstraints = false
         city.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         city.textColor = .darkGray
         let flight = flights[flightNumber]
         city.text = flight.endCityCode.uppercased()
         return city
     }()
    
    private lazy var shortTime1: UILabel = {
         let day = UILabel()
         day.translatesAutoresizingMaskIntoConstraints = false
         day.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         day.textColor = .darkGray
         let flight = flights[flightNumber]
         day.text = ShortTimeFromWebtoApp (flight.startDate)
         return day
     }()
    
    private lazy var shortTime2: UILabel = {
         let day = UILabel()
         day.translatesAutoresizingMaskIntoConstraints = false
         day.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         day.textColor = .darkGray
         let flight = flights[flightNumber]
         day.text = ShortTimeFromWebtoApp (flight.endDate)
         return day
     }()
    
    private lazy var button: UIButton = {
         let buy = UIButton()
         buy.translatesAutoresizingMaskIntoConstraints = false
         buy.setTitle("Купить", for: .normal)
         buy.titleLabel?.textColor = .white
         buy.backgroundColor = UIColor.systemPurple
         buy.layer.cornerRadius = 4
         buy.layer.shadowOffset.width = 4
         buy.layer.shadowOffset.height = 4
         buy.layer.shadowColor = UIColor.black.cgColor
         buy.layer.shadowOpacity = 0.7
         buy.layer.shadowRadius = 4
         return buy
     }()
    
    public lazy var plane: UIButton = { // plane
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .black)
        let homeImage = UIImage(systemName: "airplane.departure", withConfiguration: homeSymbolConfiguration)
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        homeButton.tintColor = UIColor.darkGray
        homeButton.setImage(homeImage, for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    } ()
    
    public lazy var plane2: UIButton = { // plane
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .black)
        let homeImage = UIImage(systemName: "airplane.arrival", withConfiguration: homeSymbolConfiguration)
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        homeButton.tintColor = UIColor.darkGray
        homeButton.setImage(homeImage, for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    } ()
    
    private lazy var price: UILabel = {
        let price = UILabel()
        price.textColor = .systemPurple
        price.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        price.translatesAutoresizingMaskIntoConstraints = false
        let flight = flights[flightNumber]
        price.text = String (flight.price) + " ₽"
        return price
    }()
    
    private func setupConstraints() {
        
        let topBackViewConstraint = self.backView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingBackViewConstraint = self.backView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingBackViewConstraint = self.backView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomBackViewConstraint = self.backView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let topContentViewConstraint = self.contentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)
        let leadingContentViewConstraint = self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let trailingContentViewConstraint = self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let bottomContentViewConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        
        let topPriceConstraint = self.price.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40)
        let leadingPriceConstraint = self.price.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40)
        
        let topPlaneViewConstraint = self.plane.topAnchor.constraint(equalTo: self.price.bottomAnchor, constant: 40)
        let leadingPlaneViewConstraint = self.plane.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        
        let timeTopConstraint = self.time1.topAnchor.constraint(equalTo: plane.topAnchor, constant: -20)
        let timeLeadingConstraint = self.time1.leadingAnchor.constraint(equalTo: plane.trailingAnchor, constant: 20)
        
        let shortTimeTopConstraint = self.shortTime1.topAnchor.constraint(equalTo: time1.bottomAnchor, constant: 40)
        let shortTimeLeadingConstraint = self.shortTime1.leadingAnchor.constraint(equalTo: time1.leadingAnchor)
        
        let city1TopConstraint = self.city1.topAnchor.constraint(equalTo: time1.topAnchor, constant: -10)
        let city1LeadingConstraint = self.city1.leadingAnchor.constraint(equalTo: time1.trailingAnchor, constant: 15)
        let city1TrailingConstraint = self.city1.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -20)
        let city1HeightConstraint = self.city1.heightAnchor.constraint(equalToConstant: 60)
        
        let city1CodeTopConstraint = self.city1Code.topAnchor.constraint(equalTo: shortTime1.topAnchor)
        let city1CodeLeadingConstraint = self.city1Code.leadingAnchor.constraint(equalTo: city1.leadingAnchor, constant: 5)
        
        
        let plane2TopConstraint = self.plane2.topAnchor.constraint(equalTo: plane.bottomAnchor, constant: 90)
        let plane2LeadingConstraint = self.plane2.leadingAnchor.constraint(equalTo: plane.leadingAnchor)
        
        let time2TopConstraint = self.time2.topAnchor.constraint(equalTo: plane2.topAnchor, constant: -20)
        let time2LeadingConstraint = self.time2.leadingAnchor.constraint(equalTo: plane2.trailingAnchor, constant: 20)
        
        let shortTime2TopConstraint = self.shortTime2.topAnchor.constraint(equalTo: time2.bottomAnchor, constant: 40)
        let shortTime2LeadingConstraint = self.shortTime2.leadingAnchor.constraint(equalTo: time1.leadingAnchor)
        
        let city2TopConstraint = self.city2.topAnchor.constraint(equalTo: time2.topAnchor, constant: -10)
        let city2LeadingConstraint = self.city2.leadingAnchor.constraint(equalTo: time1.trailingAnchor, constant: 15)
        let city2TrailingConstraint = self.city2.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -20)
        let city2HeightConstraint = self.city2.heightAnchor.constraint(equalToConstant: 60)
        
        let city2CodeTopConstraint = self.city2Code.topAnchor.constraint(equalTo: shortTime2.topAnchor)
        let city2CodeLeadingConstraint = self.city2Code.leadingAnchor.constraint(equalTo: city1.leadingAnchor, constant: 5)
        
        let topLikeConstraint = self.myLike.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40)
        let trailingLikeConstraint = self.myLike.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40)
        
        let bottomButtonConstraint = self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        let centerButtonConstraint = self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        let widthButtonConstraint = self.button.widthAnchor.constraint(equalToConstant: 90)
        let heightButtonConstraint = self.button.heightAnchor.constraint(equalToConstant: 40)
        
        
        NSLayoutConstraint.activate([
            bottomButtonConstraint, centerButtonConstraint, widthButtonConstraint, heightButtonConstraint,
            topBackViewConstraint, leadingBackViewConstraint, trailingBackViewConstraint, bottomBackViewConstraint,
            topContentViewConstraint, leadingContentViewConstraint, trailingContentViewConstraint, bottomContentViewConstraint,
            topPriceConstraint, leadingPriceConstraint,
            topPlaneViewConstraint, leadingPlaneViewConstraint,
            timeTopConstraint, timeLeadingConstraint,
            shortTimeTopConstraint, shortTimeLeadingConstraint,
            city1TopConstraint, city1LeadingConstraint,
            city1CodeTopConstraint, city1CodeLeadingConstraint,
            plane2TopConstraint, plane2LeadingConstraint,
            time2TopConstraint, time2LeadingConstraint,
            shortTime2TopConstraint, shortTime2LeadingConstraint,
            city2TopConstraint, city2LeadingConstraint, city2CodeTopConstraint, city2CodeLeadingConstraint,
            topLikeConstraint, trailingLikeConstraint, city2TrailingConstraint, city2HeightConstraint,
            city1TrailingConstraint, city1HeightConstraint
        ])
        
    }

}
