//
//  MealCell.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

final class MealCell: UICollectionViewCell {
    
    // MARK: - UIElements
    private lazy var mealNameLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont.systemFont(ofSize: 19))
        return label
    }()
    
    // MARK: - Ivars
    static let cellID = "MealCellID"
    
    var mealCellViewModel: MealCellViewModel? {
        didSet {
            
            guard let mealCellViewModel = mealCellViewModel else { return }
            
            setupBinders(for: mealCellViewModel)
            
            setupUILayout()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Binders
extension MealCell {
    
    private func setupBinders(for mealCellViewModel: MealCellViewModel) {
        
        mealCellViewModel.mealName.bind { [weak self](text) in
            self?.mealNameLabel.text = text
        }
    }
}

// MARK: - LayoutUI
extension MealCell {
    
    private func setupUILayout() {
        
        contentView.addSubview(mealNameLabel)
        
        let leadingAndTrailingPadding: CGFloat = 16
        
        mealNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        mealNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingAndTrailingPadding).isActive = true
        mealNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -leadingAndTrailingPadding).isActive = true
    }
}
