//
//  ItemTableHeaderView.swift
//  Bonida
//
//  Created by Rus Razvan on 30/10/2018.
//  Copyright © 2018 Rus Razvan. All rights reserved.
//

import UIKit

private enum Constants {
    static let nibName = "ItemTableHeaderView"
    static let deleteHiddenConstraintsConstant: CGFloat = 0
    static let deleteShownConstraintsConstant: CGFloat = 120
    static let changeConstraintsAnimationDuration = 0.25
}

protocol ItemTableHeaderProtocol: class {
    func headerWasTapped(_ headerIndex: Int)
    func headerDeleteButtonTapped(_ headerIndex: Int)
}

class ItemTableHeaderView: UIView {
    @IBOutlet private var containerView: UIView!
    
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subItemLabel: UILabel!
    @IBOutlet private weak var subItemCountLabel: UILabel!
    
    @IBOutlet private weak var viewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var viewTrailingConstraint: NSLayoutConstraint!
    
    var delegate: ItemTableHeaderProtocol!
    var headerIndex: Int!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed(Constants.nibName, owner: self, options: nil)
        addSubview(containerView)
    }
    
    init(frame: CGRect, title: String, count: Int) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed(Constants.nibName, owner: self, options: nil)
        containerView.frame = frame
        addSubview(containerView)
        
        titleLabel.text = title
        subItemCountLabel.text = String(count)
        
        addTapGestureRecognizer()
        addRightSwipeGestureRecognized()
        addLeftSwipeGestureRecognized()
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func addRightSwipeGestureRecognized() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeGesture.direction = .right
        containerView.addGestureRecognizer(swipeGesture)
    }
    
    private func addLeftSwipeGestureRecognized() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeGesture.direction = .left
        containerView.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    private func handleTap() {
        handleSwipeRight()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constants.changeConstraintsAnimationDuration) {
            self.delegate.headerWasTapped(self.headerIndex)
        }
    }
    
    @objc
    private func handleSwipeRight() {
        UIView.animate(withDuration: Constants.changeConstraintsAnimationDuration) {
            self.viewLeadingConstraint.constant = Constants.deleteHiddenConstraintsConstant
            self.viewTrailingConstraint.constant = Constants.deleteHiddenConstraintsConstant
            self.layoutIfNeeded()
        }
    }
    
    @objc
    private func handleSwipeLeft() {
        UIView.animate(withDuration: Constants.changeConstraintsAnimationDuration) {
            self.viewLeadingConstraint.constant = -Constants.deleteShownConstraintsConstant
            self.viewTrailingConstraint.constant = Constants.deleteShownConstraintsConstant
            self.layoutIfNeeded()
        }
    }
    
    @IBAction private func deleteButtonTapped(_ sender: Any) {
        delegate.headerDeleteButtonTapped(headerIndex)
    }
}
