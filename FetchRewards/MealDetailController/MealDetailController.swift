//
//  MealDetailController.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

final class MealDetailController: UIViewController {
    
    // MARK: - Init
    init(mealDetailViewModel: MealDetailViewModel) {
        self.mealDetailViewModel = mealDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ivars
    private let mealDetailViewModel: MealDetailViewModel
    
    // MARK: - UIElements
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView.createImageView(with: .scaleAspectFit)
        return imageView
    }()
    
    private lazy var mealNameLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont.systemFont(ofSize: 23), textColor: .green)
        return label
    }()
    
    private lazy var instructionsTextView: UITextView = {
        let textView = UITextView.createTextView(textColor: UIColor.orange)
        return textView
    }()
    
    private lazy var ingredientsTextView: UITextView = {
        let textView = UITextView.createTextView(textColor: UIColor.purple)
        return textView
    }()
    
    private lazy var measurementsTextView: UITextView = {
        let textView = UITextView.createTextView(textColor: UIColor.brown)
        return textView
    }()
    
    private lazy var networkSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.createActivityIndicatorView()
        return spinner
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUILayout()
        
        setupBindersForMealDetailViewModel()
        
        fetchMeal()
        
        fetchMealThumbImage()
    }
    
    // MARK: - Deinit
    deinit {
        print("\nMealDetailVC - DEINIT")
    }
}

// MARK: - Fetch Meal Info
extension MealDetailController {
    
    private func fetchMeal() {
        
        mealDetailViewModel.fetchMeal { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.networkSpinner.stopAnimating()
            }
        }
    }
}

// MARK: - Fetch Meal ThumbImage
extension MealDetailController {
    
    private func fetchMealThumbImage() {
        
        guard let strMealThumb = mealDetailViewModel.strMealThumb, let url = URL(string: strMealThumb) else { return }
        
        imageView.loadImage(with: url)
    }
}

// MARK: - Set Meal Binders
extension MealDetailController {
    
    private func setupBindersForMealDetailViewModel() {
        
        mealDetailViewModel.mealName.bind { [weak self](text) in
            self?.mealNameLabel.text = text
        }
        
        mealDetailViewModel.instructionsList.bind { [weak self](text) in
            self?.setInstructionsTextView(text)
        }
        
        mealDetailViewModel.ingredientsList.bind { [weak self](list) in
            self?.setIngredientsTextView(from: list)
        }
        
        mealDetailViewModel.measurementsList.bind { [weak self](list) in
            self?.setMeasurementsTextView(from: list)
        }
    }
}

// MARK: - Set TextViews
extension MealDetailController {
    
    private func setInstructionsTextView(_ text: String?) {
        
        instructionsTextView.text = text
    }
    
    private func setIngredientsTextView(from list: [String]?) {
        
        mealDetailViewModel.setText(for: ingredientsTextView, title: "Ingredients", from: list)
    }
    
    private func setMeasurementsTextView(from list: [String]?) {
        
        mealDetailViewModel.setText(for: measurementsTextView, title: "Measurements", from: list)
    }
}

// MARK: - Layout UI
extension MealDetailController {
    
    private func setupUILayout() {
        
        view.addSubview(imageView)
        view.addSubview(mealNameLabel)
        view.addSubview(instructionsTextView)
        view.addSubview(ingredientsTextView)
        view.addSubview(measurementsTextView)
        view.addSubview(networkSpinner)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: instructionsTextView.topAnchor).isActive = true
        
        let padding: CGFloat = 8
        let textViewHeight: CGFloat = 75
        
        mealNameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: padding).isActive = true
        mealNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        mealNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        
        instructionsTextView.bottomAnchor.constraint(equalTo: ingredientsTextView.topAnchor, constant: -padding).isActive = true
        instructionsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        instructionsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        instructionsTextView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        
        ingredientsTextView.bottomAnchor.constraint(equalTo: measurementsTextView.topAnchor, constant: -padding).isActive = true
        ingredientsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        ingredientsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        ingredientsTextView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        
        measurementsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        measurementsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        measurementsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        measurementsTextView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        
        networkSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        networkSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
