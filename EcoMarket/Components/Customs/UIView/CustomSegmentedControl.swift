//
//  CustomSegmentedControl.swift
//  EcoMarket
//
//  Created by Ernazar on 20/12/23.
//

import UIKit

final class CustomSegmentedControl: UIView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 8
        return view
    }()
    
    private let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGreen
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var widthConstraint = NSLayoutConstraint()
    private var leadingConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(_ buttonText: String...) {
        self.init()
        buttonText.enumerated().forEach {
            let button: UIButton = .createSegmentedButton(title: $0.element)
            button.tag = $0.offset
            button.addTarget(self, action: #selector(segmentButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        DispatchQueue.main.async {
            self.widthConstraint.constant = self.stackView.arrangedSubviews[0].frame.width
        }
    }
    
    func firstSelectedSegment(tag: Int) {
        let color = #colorLiteral(red: 0.8571347594, green: 0.8542680144, blue: 0.8668256402, alpha: 1)
        changeColorText(tag: tag)
        DispatchQueue.main.async {
            self.widthConstraint.constant = self.stackView.arrangedSubviews[tag].frame.width
            self.leadingConstraint.constant = self.stackView.arrangedSubviews[tag].frame.origin.x
        }
    }
    
    @objc private func segmentButtonTapped(sender: UIButton) {
        widthConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.width
        leadingConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.origin.x
        
        UIView.animate(withDuration: 0.1) {
            self.stackView.layoutIfNeeded()
            
        } completion: { _ in
            self.changeColorText(tag: sender.tag)
        }
    }
    
    private func changeColorText(tag: Int) {
        let color = #colorLiteral(red: 0.8571347594, green: 0.8542680144, blue: 0.8668256402, alpha: 1)
        stackView.arrangedSubviews.forEach {
            if let button = $0 as? UIButton {
                if button.tag == tag {
                    button.setTitleColor(.white, for: .normal)
                } else {
                    button.setTitleColor(color, for: .normal)
                }
            }
        }
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(selectedView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        widthConstraint = selectedView.widthAnchor.constraint(equalToConstant: 0)
        
        leadingConstraint = selectedView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            selectedView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectedView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            widthConstraint,
            leadingConstraint,
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
