//
//  FlightCell.swift
//  Wildberries
//
//  Created by Tatyana Sidoryuk on 02.06.2022.
//

import Foundation
import UIKit
import SwiftUI

protocol MyTableViewCellDelegate: AnyObject {
    func tapFlight (cell: FlightCell)
    func tappedLike (cell: FlightCell)
}

class FlightCell: UITableViewCell {
    
    weak var delegate: MyTableViewCellDelegate?
    
    private var tapFlightGesture = UITapGestureRecognizer()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView () {
            
        self.addSubview(contentView)
        
        contentView.layer.cornerRadius = 2
        contentView.layer.cornerRadius = 2
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 5
        clipsToBounds = false
        layer.masksToBounds = false
        
        
        self.contentView.addSubview(self.myView)
        myView.addSubview(self.startCityLabel)
        myView.addSubview(self.endCityLabel)
        myView.addSubview(self.startDateLabel)
        myView.addSubview(self.endDateLabel)
        myView.addSubview(self.startCityCodeLabel)
        myView.addSubview(self.endCityCodeLabel)
        myView.addSubview(self.plane)
        myView.addSubview(self.plane2)
        myView.addSubview(self.priceLabel)
        self.contentView.addSubview (self.myLike1)
        
        let contentTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let contentLeadingConstraint = self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let contentTrailingConstraint = self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let contentBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        let myViewTopConstraint = self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0)
        let myViewLeadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let myViewTrailingConstraint = self.myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let myViewBottomConstraint = self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        let priceTopConstraint = self.priceLabel.topAnchor.constraint(equalTo: self.myView.topAnchor, constant: 20)
        let priceLeadingConstraint = self.priceLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 20)
        
        let startDateTopConstraint = self.startDateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10)
        let startDateLeadingConstraint = self.startDateLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 20)
        
        let startCityTopConstraint = self.startCityLabel.topAnchor.constraint(equalTo: self.startDateLabel.bottomAnchor, constant: 5)
        let startCityLeadingConstraint = self.startCityLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 15)
        let startCityTrailingConstraint = self.startCityLabel.trailingAnchor.constraint(equalTo: self.myView.centerXAnchor)
        let startCityHeightConstraint = self.startCityLabel.heightAnchor.constraint(equalToConstant: 50)
        
        let endDateTopConstraint = self.endDateLabel.topAnchor.constraint(equalTo: self.startDateLabel.topAnchor)
        let endDateLeadingConstraint = self.endDateLabel.leadingAnchor.constraint(equalTo: super.centerXAnchor)
       
        let endCityTopConstraint = self.endCityLabel.topAnchor.constraint(equalTo: self.startCityLabel.topAnchor)
        let endCityLeadingConstraint = self.endCityLabel.leadingAnchor.constraint(equalTo: super.centerXAnchor, constant: -5)
        let endCityTrailingConstraint = self.endCityLabel.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor)
        let endCityHeightConstraint = self.endCityLabel.heightAnchor.constraint(equalToConstant: 50)
        
        
        let startCityCodeTopConstraint = self.startCityCodeLabel.topAnchor.constraint(equalTo: self.startCityLabel.bottomAnchor, constant: 5)
        let startCityCodeLeadingConstraint = self.startCityCodeLabel.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 20)
       
        let endCityCodeTopConstraint = self.endCityCodeLabel.topAnchor.constraint(equalTo: self.endCityLabel.bottomAnchor, constant: 5)
        let endCityCodeLeadingConstraint = self.endCityCodeLabel.leadingAnchor.constraint(equalTo: super.centerXAnchor)
        
        let planeTopConstraint = self.plane.topAnchor.constraint(equalTo: self.startCityCodeLabel.bottomAnchor, constant: 10)
        let planeLeadingConstraint = self.plane.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 17)
        let planeHeightConstraint = self.plane.heightAnchor.constraint(equalToConstant: 25)
        
        let plane2TopConstraint = self.plane2.topAnchor.constraint(equalTo: self.startCityCodeLabel.bottomAnchor, constant: 10)
        let plane2LeadingConstraint = self.plane2.leadingAnchor.constraint(equalTo: self.endCityCodeLabel.leadingAnchor, constant: -3)
        let plane2HeightConstraint = self.plane2.heightAnchor.constraint(equalToConstant: 25)
        
        let likeBottomConstraint = self.myLike1.bottomAnchor.constraint(equalTo: self.myView.bottomAnchor, constant: -20)
        let likeTrailingConstraint = self.myLike1.trailingAnchor.constraint(equalTo: self.myView.trailingAnchor, constant: -20)
        
        NSLayoutConstraint.activate([
            myViewTopConstraint, myViewLeadingConstraint, myViewTrailingConstraint, myViewBottomConstraint,
            startCityTopConstraint, startCityLeadingConstraint, endCityTopConstraint, endCityLeadingConstraint,
            startDateTopConstraint, startDateLeadingConstraint,
            startCityCodeTopConstraint, startCityCodeLeadingConstraint,
            endCityCodeTopConstraint, endCityCodeLeadingConstraint,
            endDateTopConstraint, endDateLeadingConstraint,
            planeTopConstraint, planeHeightConstraint, planeLeadingConstraint,
            plane2TopConstraint, plane2HeightConstraint, plane2LeadingConstraint,
            priceTopConstraint, priceLeadingConstraint,
            likeBottomConstraint, likeTrailingConstraint,
            endCityTrailingConstraint, endCityHeightConstraint,
            startCityTrailingConstraint, startCityHeightConstraint,
            contentTopConstraint, contentBottomConstraint, contentLeadingConstraint, contentTrailingConstraint
            
        ])
    }
    
    private lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    public var myLike1: HeartButton = {
        let like = HeartButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        like.translatesAutoresizingMaskIntoConstraints = false
        like.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        like.isUserInteractionEnabled = true
        return like
    } ()
    
    
    @objc func didTapButton(sender: UIButton)
    {
        myLike1.flipLikedState()
        delegate?.tappedLike(cell: self)
        print (likes)
    }
    
    public lazy var startCityLabel: UITextView = { // startCity
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        label.textColor = .black
        label.isUserInteractionEnabled = false
        return label
    } ()
    
    public lazy var startCityCodeLabel: UILabel = { // startCityCode
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .darkGray
        return label
    } ()
    
    public lazy var endCityLabel: UITextView = { // endCity
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        label.textColor = .black
        label.isUserInteractionEnabled = false
        return label
    } ()
    
    public lazy var endCityCodeLabel: UILabel = { // endCityCode
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .darkGray
        return label
    } ()
    public lazy var startDateLabel: UILabel = { // startDate
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    } ()
    
    public lazy var endDateLabel: UILabel = { // endDate
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    } ()
    
    public lazy var priceLabel: UILabel = { // price
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .purple
        return label
    } ()
    
    public lazy var plane: UIButton = { // plane
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .black)
        let homeImage = UIImage(systemName: "airplane.departure", withConfiguration: homeSymbolConfiguration)
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        homeButton.tintColor = UIColor.systemGray
        homeButton.setImage(homeImage, for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    } ()
    
    public lazy var plane2: UIButton = { // plane
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .black)
        let homeImage = UIImage(systemName: "airplane.arrival", withConfiguration: homeSymbolConfiguration)
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        homeButton.tintColor = UIColor.systemGray
        homeButton.setImage(homeImage, for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    } ()
}


public class HeartButton: UIButton {
    private let unlikedImage = UIImage(systemName: "heart")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    private let likedImage = UIImage(systemName: "heart.fill")?.withTintColor(.purple, renderingMode: .alwaysOriginal)
    
    public let heartConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(unlikedImage?.withConfiguration(heartConfiguration), for: .normal)
        self.isUserInteractionEnabled = true
  }
    
    public var isLiked = false
    
    public func flipLikedState() {
      isLiked = !isLiked
      animate()
    }
    
    private func animate() {
      // Step 1
        let newImage = self.isLiked ? self.likedImage?.withConfiguration(heartConfiguration) : self.unlikedImage?.withConfiguration(heartConfiguration)
        
      UIView.animate(withDuration: 0.1, animations: {
          self.transform = self.transform.scaledBy(x: 1.5, y: 1.5)
          self.setImage(newImage, for: .normal)
      }, completion: { _ in
        // Step 2
        UIView.animate(withDuration: 0.1, animations: {
          self.transform = CGAffineTransform.identity
        })
      })
    }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension FlightCell {
    private func setupGesture() {
        
        self.tapFlightGesture.addTarget(self, action: #selector(self.flightTapGesture(_:)))
        self.myView.addGestureRecognizer(self.tapFlightGesture)
        self.myView.isUserInteractionEnabled = true
    }

    @objc func flightTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapFlightGesture === gestureRecognizer else { return }
        delegate?.tapFlight(cell: self)
    }
}
