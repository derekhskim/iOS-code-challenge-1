//
//  ScheduleViewController.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

class ScheduleViewController: UIViewController, UICalendarViewDelegate, MainStoryBoarded {
    
    let calendarView = UICalendarView()
    let gregorianCalendar = Calendar(identifier: .gregorian)
    var scheduleData: [Schedule] = []
    
    // MARK: - @IBOutlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "en_CA")
        calendarView.fontDesign = .rounded
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 3, day: 24)
        
        view.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            calendarView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)
        ])
        
    }
    
    func fetchScheduleData(for date: Date) -> [Schedule] {
            return []
        }
    
}
