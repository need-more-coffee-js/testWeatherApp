//
//  ForecastTableView.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

final class ForecastTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        register(ForecastCell.self, forCellReuseIdentifier: ForecastCell.id)
        dataSource = self
        delegate = self
        rowHeight = 60
        separatorStyle = .none
    }
}

extension ForecastTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.id, for: indexPath) as! ForecastCell
        cell.mockConfigure(day: "day", temp: "15", icon: UIImage(systemName: "thermometer")!)
        return cell
    }
}
