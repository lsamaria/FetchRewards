//
//  HomeController.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: - Init
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ivars
    private let homeViewModel: HomeViewModel
    
    // MARK: - UIElements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(MealCell.self, forCellWithReuseIdentifier: MealCell.cellID)
        
        return collectionView
    }()
    
    private lazy var networkSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.createActivityIndicatorView()
        return spinner
    }()
    
    // MARK: - VIew Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUILayout()
        
        fetchMeals()
    }
}

// MARK: - Fetch User
extension HomeController {
    
    private func fetchMeals() {
        
        homeViewModel.fetchMeals { [weak self](meals) in
            DispatchQueue.main.async { [weak self] in
                self?.reloadCollectionView(with: meals)
            }
        }
    }
    
    private func reloadCollectionView(with meals: [Meal]) {
        
        collectionView.reloadData()
        networkSpinner.stopAnimating()
        
        if !meals.isEmpty {
            navigationItem.title = homeViewModel.navTitle
            return
        }
        
        showAlert(title: "No Meals", message: "Sorry, no meals to show.\n\nPlease check the debugger for more info.")
    }
}

// MARK: - Layout UI
extension HomeController {
    
    private func setupUILayout() {
        
        view.addSubview(collectionView)
        view.addSubview(networkSpinner)
        
        networkSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        networkSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

// MARK: - UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCell.cellID, for: indexPath) as? MealCell else {
            return UICollectionViewCell()
        }
        
        let meal = homeViewModel.datasource[indexPath.item]
        
        cell.mealCellViewModel = MealCellViewModel(strMeal: meal.strMeal)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width
        let cellHeight: CGFloat = 80
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MealCell else { return }
        
        let mealName = cell.mealCellViewModel?.mealName
        
        let meal = homeViewModel.datasource[indexPath.item]
        
        pushOnMealDetailVC(from: meal, and: mealName?.value)
    }
}

// MARK: - PushOn MealDetailVC
extension HomeController {
    
    private func pushOnMealDetailVC(from meal: Meal, and mealName: String?) {
        
        guard let idMeal = meal.idMeal else {
            showAlert(message: "idMeal is nil")
            return
        }
        
        let endpoint = Endpoint(path: APIConstants.endpointLookupPath,
                                queryDict: [APIConstants.mealDetailQueryKey : idMeal])
        
        let mealDetailViewModel = MealDetailViewModel(endpointURL: endpoint.url,
                                                      mealName: mealName,
                                                      strMealThumb: meal.strMealThumb)
        
        let mealDetailVC = MealDetailController(mealDetailViewModel: mealDetailViewModel)
        
        navigationController?.pushViewController(mealDetailVC, animated: true)
    }
}
