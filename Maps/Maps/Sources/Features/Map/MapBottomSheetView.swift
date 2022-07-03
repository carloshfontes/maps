//
//  BottomSheetView.swift
//  Maps
//
//  Created by Carlos Fontes on 02/07/22.
//
import UIKit

protocol MapBottomSheetViewDelegate: AnyObject {
    func didTapAddPin()
    func didTapVisualizePin()
}

protocol MapBottomSheetViewConfigurable: UIView {
    var delegate: MapBottomSheetViewDelegate? { get set }
}

final class MapBottomSheetView: UIView, MapBottomSheetViewConfigurable {
    weak var delegate: MapBottomSheetViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "O que gostaria de fazer?"
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, buttonsStackView])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add-button"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddPin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var visualizeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "visualize-button"), for: .normal)
        button.addTarget(self, action: #selector(didTapVisualizePin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addButton, visualizeButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let defaultHeight: CGFloat = 90
    let maximumContainerHeight: CGFloat = 200
    var currentContainerHeight: CGFloat = 90
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    // MARK: - Selectors
    @objc
    func didTapAddPin() {
        delegate?.didTapAddPin()
    }
    
    @objc
    func didTapVisualizePin() {
        delegate?.didTapVisualizePin()
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }
    
    @objc
    private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if currentContainerHeight <= maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                layoutIfNeeded()
            }
            
        case .ended:
            if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
                buttonsStackView.isHidden = true
                
            } else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
                buttonsStackView.isHidden = true
                
            } else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
                buttonsStackView.isHidden = false
            }
        default:break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.layoutIfNeeded()
        }
        
        currentContainerHeight = height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapBottomSheetView: ViewCodable {
    func setupConfigurations() {
        backgroundColor = .white
        setupPanGesture()
    }
    
    func setupHierarchy() {
        addSubview(contentStackView)
    }
    
    func setupConstraints() {
        containerViewHeightConstraint = heightAnchor.constraint(equalToConstant: defaultHeight)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
        
        containerViewHeightConstraint?.isActive = true
    }
}
