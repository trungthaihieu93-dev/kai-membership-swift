//
//  KAIInputCalendarPicker.swift
//  KAI Membership
//
//  Created by DAKiet on 23/03/2021.
//

import UIKit

class KAIInputCalendarPicker: UIView {
    
    // MARK: Properties
    private let transparentView = UIView()
    
    private lazy var selectedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: "FAFBFB")
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.87), for: .normal)
        button.titleLabel?.font = UIFont.workSansFont(ofSize: 14, weight: .medium)
        let formatTime = Date().timeIntervalSince1970.formatTimeIntervalToString("dd/MM/yyyy")
        button.setTitle(formatTime, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.init(hex: "E6EAEF").cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onPressedCalendar), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var calendarPicker: KAICalendarPicker = {
        let view = KAICalendarPicker(baseDate: baseDate) { [weak self] date in
            guard let this = self else { return }
            
            let formatTime = date.timeIntervalSince1970.formatTimeIntervalToString("dd/MM/yyyy")
            this.setText(formatTime)
            this.selectedDateChanged(date)
            this.removeTransparentView()
        }
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        return view
    }()
    
    private let selectedDate: Date
    private let baseDate: Date
    
    private let selectedDateChanged: ((Date) -> Void)
    
    // MARK: Life cycle's
    init(baseDate: Date, frame: CGRect = .zero, _ selectedDateChanged: @escaping ((Date) -> Void)) {
        self.selectedDate = baseDate
        self.baseDate = baseDate
        self.selectedDateChanged = selectedDateChanged
        
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        addSubview(selectedButton)
        
        NSLayoutConstraint.activate([
            selectedButton.topAnchor.constraint(equalTo: topAnchor),
            selectedButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectedButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func addTransparentView() {
        let frames: CGRect = selectedButton.convert(selectedButton.frame, to: nil)
        let window = Navigator.window
        transparentView.frame = window?.frame ?? CGRect(origin: .zero, size: Constants.Device.screenBounds.size)
        window?.addSubview(transparentView)
        
        calendarPicker.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        window?.addSubview(calendarPicker)
        calendarPicker.layer.cornerRadius = 8
        calendarPicker.createShadow(radius: 8)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        let itemWidth = frames.width / 7
        let height = itemWidth * CGFloat(calendarPicker.numberOfWeeksInBaseDate)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.calendarPicker.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: height)
        }, completion: nil)
    }
    
    func setAttributedTitle(_ attributedString: NSAttributedString) {
        selectedButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func setText(_ text: String) {
        selectedButton.setTitle(text, for: .normal)
    }
    
    // MARK: Handle actions
    @objc func removeTransparentView() {
        let frames: CGRect = selectedButton.convert(selectedButton.frame, to: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.calendarPicker.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: { finish in
            self.calendarPicker.removeFromSuperview()
            self.transparentView.removeFromSuperview()
        })
    }
    
    @objc private func onPressedCalendar() {
        addTransparentView()
        Navigator.window?.endEditing(true)
    }
}
