//
//  HourlyCollectionViewCell.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let id = "HourlyCollectionViewCell"
    
    private let timeLabel = UILabel()
    private let iconImageView = UIImageView()
    private let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, iconImageView, tempLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
    }
    
    func configure(with hour: Current) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let timeEpoch = hour.timeEpoch {
            let date = Date(timeIntervalSince1970: TimeInterval(timeEpoch))
            timeLabel.text = dateFormatter.string(from: date)
        } else {
            timeLabel.text = "--:--"
        }
        
        tempLabel.text = "\(hour.tempC ?? 0)°C"
        
        if let iconPath = hour.condition?.icon,
           let url = URL(string: "https:\(iconPath)") {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.iconImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
