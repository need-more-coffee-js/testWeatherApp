//
//  CurrentDayView.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

final class CurrentDayView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    private let conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBlue.withAlphaComponent(0.1)
        layer.cornerRadius = 12
        
        addSubview(stackView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(conditionImageView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
    }
    
    func configure(weather: Forecast) {
            cityLabel.text = weather.location?.name ?? "Unknown"
            temperatureLabel.text = "\(weather.current?.tempC ?? 0)°C"
            
            if let iconPath = weather.current?.condition?.icon,
               let url = URL(string: "https:\(iconPath)") {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.conditionImageView.image = image
                        }
                    }
                }.resume()
            }
        }
}
