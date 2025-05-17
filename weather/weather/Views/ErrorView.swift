//
//  ErrorView.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    var onRetry: (() -> Void)?
    
    private let label = UILabel()
    private let retryButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        label.text = "Не удалось загрузить данные"
        label.textAlignment = .center
        
        retryButton.setTitle("Повторить", for: .normal)
        retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [label, retryButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapRetry() {
        onRetry?()
    }
}
