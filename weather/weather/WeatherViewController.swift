//
//  ViewController.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    // MARK: - UI
    private let mainView = MainView()
    private let loadingView = LoadingView()
    private let errorView = ErrorView()
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - UI Setup
    func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(mainView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.isHidden = true
        errorView.isHidden = true
        mainView.isHidden = false
    }


}

