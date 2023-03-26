//
//  ScheduleViewController.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

class ScheduleViewController: UIViewController, MainStoryBoarded {
    
    let topView = UIView()
    let calendarView = UICalendarView()
    let tableView = UITableView()
    let gregorianCalendar = Calendar(identifier: .gregorian)
    var schedules: [Schedule] = []
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTopView()
        configureCalendar()
        configureTableView()
        fetchScheduleData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomTableViewCell")

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            calendarView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
        
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Function
    func configureTopView() {
        topView.backgroundColor = UIColor.appColor(LPColor.LPYellow)
        
        let titleLabel = UILabel()
        titleLabel.text = "Schedule"
        titleLabel.textColor = UIColor.appColor(LPColor.LPTextGray)
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Sign Out", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(topView)
        
        topView.addSubview(titleLabel)
        topView.addSubview(backButton)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 51),
            
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8)
        ])
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.calendar = .current
        calendarView.locale = Locale(identifier: "en_CA")
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        view.addSubview(calendarView)
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
    }
    
    func fetchScheduleData() {
        NetworkManager.shared.getScheduleData { [weak self] (schedules, error) in
                if let error = error {
                    print("Error fetching schedules: \(error.localizedDescription)")
                    return
                }
                
                if let schedules = schedules {
                    self?.schedules = schedules
                    self?.tableView.reloadData()
                }
            }
    }
    
}

// MARK: - Extension
extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
                fatalError("Unable to dequeue CustomTableViewCell")
            }
            
            let schedule = schedules[indexPath.row]
            cell.updateScheduleCell(courseName: schedule.courseName, room: schedule.room, startTime: schedule.startTime, endTime: schedule.endTime)
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}

extension ScheduleViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let day = dateComponents.day else {
            return nil
        }
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
    }
}
