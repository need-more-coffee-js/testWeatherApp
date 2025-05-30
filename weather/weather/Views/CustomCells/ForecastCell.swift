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
    
    func configure(with forecastDay: Forecastday) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        if let dateString = forecastDay.date,
           let date = ISO8601DateFormatter().date(from: dateString) {
            dayLabel.text = dateFormatter.string(from: date)
        } else {
            dayLabel.text = "N/A"
        }
        
        tempLabel.text = "\(forecastDay.day?.avgtempC ?? 0)°C"
        
        if let iconPath = forecastDay.day?.condition?.icon,
           let url = URL(string: "https:\(iconPath)") {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
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
