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
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: "FAFBFB")
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.init(hex: "E1E4E8").cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onPressedCalendar), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var calendarPicker: KAICalendarPicker = {
        let view = KAICalendarPicker(baseDate: baseDate) { [weak self] date in
            guard let this = self else { return }
            
            this.selectedDateChanged(date)
            this.removeTransparentView()
        }
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        return view
    }()
    
    private let selectedDate: Date
    private let baseDate: Date
    
    private var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    private let selectedDateChanged: ((Date) -> Void)
    private let calendar = Calendar(identifier: .gregorian)
    
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
        
        selectedButton.backgroundColor = .red
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
        let height: CGFloat = 500//CGFloat(dataSources.count) * itemHeight
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.calendarPicker.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: height)
        }, completion: nil)
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
