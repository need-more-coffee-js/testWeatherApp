//
//  MainView.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

final class MainView: UIView {
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - Subviews
    private let currentWeather = CurrentDayView()
    let hourlyView = HourlyView()
    let forecastTableView = ForecastTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.addSubview(currentWeather)
        contentView.addSubview(hourlyView)
        contentView.addSubview(forecastTableView)
        
        currentWeather.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        hourlyView.snp.makeConstraints { make in
            make.top.equalTo(currentWeather.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(hourlyView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
    }
}
