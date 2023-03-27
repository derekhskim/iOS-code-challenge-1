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
    var filteredSchedules: [Schedule?] = []
    
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
        tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmptyTableViewCell")
        
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
        calendarView.sizeToFit()
        calendarView.locale = Locale(identifier: "en_CA")
        calendarView.fontDesign = .rounded
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        Task {
            await sleepOneSecond()
            let currentDateComponents = gregorianCalendar.dateComponents([.year, .month, .day], from: Date())
            selection.setSelected(currentDateComponents, animated: true)
            
            self.dateSelection(selection, didSelectDate: currentDateComponents)
        }
                       
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
    
    func updateTableViewData(for selectedDate: Date) {
        filteredSchedules = schedules.filter { schedule in
            let scheduleStartTime = gregorianCalendar.dateComponents([.year, .month, .day], from: Date())
            let scheduleDate = gregorianCalendar.date(from: scheduleStartTime)

            return scheduleDate == selectedDate
        }

        if filteredSchedules.isEmpty {
            filteredSchedules = [nil]
        }

        tableView.reloadData()
    }
    
    func sleepOneSecond() async {
        do {
            try await Task.sleep(nanoseconds: 1000000000)
        } catch {
            print("Error while sleeping: \(error.localizedDescription)")
        }
    }

}

// MARK: - Extension
extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let schedule = filteredSchedules[indexPath.row] {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
                fatalError("Unable to dequeue CustomTableViewCell")
            }
            cell.updateScheduleCell(courseName: schedule.courseName, room: schedule.room, startTime: schedule.startTime, endTime: schedule.endTime)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell else {
                fatalError("Unable to dequeue EmptyTableViewCell")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}

extension ScheduleViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents, let selectedDate = gregorianCalendar.date(from: dateComponents) else { return }
        
        updateTableViewData(for: selectedDate)
        
    }
    
}
