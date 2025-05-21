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
    private let currentDay = CurrentDayView()
    
    // MARK: - Services
    private let viewModel = WeatherViewModel()
    private let locationManager = LocationManager.shared
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadWeatherData()
    }
    
    //MARK: - UI Setup
    private func setupUI(){
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
        
        showLoadingState()
    }
    
    private func setupBindings(){
        errorView.onRetry = { [weak self] in
            self?.loadWeatherData()
        }
    }
    
    private func loadWeatherData(){
        showLoadingState()
        
        locationManager.onLocationReceived = { [weak self] coordinate in
            self?.fetchWeather(lat:coordinate.latitude , lon: coordinate.longitude)
        }
        locationManager.requestLocation()
    }
    
    private func fetchWeather(lat: Double, lon: Double){
        viewModel.fetchWeather(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    print(weatherResponse.current ?? "def error")
                    self?.handleSuccess(weather: weatherResponse)
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    //MARK: - State
    private func showLoadingState(){
        loadingView.isHidden = false
        errorView.isHidden = true
        mainView.isHidden = true
    }
    
    private func showErrorState(){
        loadingView.isHidden = true
        errorView.isHidden = false
        mainView.isHidden = true
    }
    
    private func showWeatherState(){
        loadingView.isHidden = true
        errorView.isHidden = true
        mainView.isHidden = false
    }
    
    //MARK: - Handlers
    private func handleSuccess(weather: Forecast){
        showWeatherState()
    }
    
    private func handleError(error: Error){
        print("Error: \(error.localizedDescription)")
        showErrorState()
    }
}

