//
//  ForecastCell.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

final class ForecastCell: UITableViewCell {
    static let id = "ForecastCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private lazy var tempImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(tempImage)
        stackView.addArrangedSubview(tempLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func configure(with viewModel: Forecast){
        dayLabel.text = "viewModel.current"
        tempLabel.text = "String(viewModel.forecastday[0].hour[0].tempC)"
        
        if let iconURL = URL(string: "https://cdn.weatherapi.com/weather/64x64/day/302.png") {
            URLSession.shared.dataTask(with: iconURL) { data, _, error in
                if let data = data , let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.tempImage.image = image
                    }
                }
            }.resume()
        }
    }
    
    func mockConfigure(day: String, temp: String, icon: UIImage){
        dayLabel.text = day
        tempLabel.text = temp
        tempImage.image = icon
    }
}
