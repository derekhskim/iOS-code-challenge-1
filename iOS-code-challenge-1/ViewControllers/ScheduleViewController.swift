//
//  ScheduleViewController.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

class ScheduleViewController: UIViewController, MainStoryBoarded {
    
    let calendarView = UICalendarView()
    let tableView = UITableView()
    let gregorianCalendar = Calendar(identifier: .gregorian)
    var scheduleData: [Schedule] = []
    
    // MARK: - @IBOutlet
    @IBOutlet weak var topView: UIView!
    
    // MARK: - @IBAction
    @IBAction func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendar()
        configureTableView()
        fetchScheduleData(for: Date())
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomTableViewCell")
        
        view.addSubview(calendarView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            calendarView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 2) - 51),
            
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Function
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
            
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .red
    }
    
    func configureCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        calendarView.calendar = .current
        calendarView.locale = Locale(identifier: "en_CA")
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
    }
    
    func fetchScheduleData(for date: Date) {
        print("fetching schedule data for \(date)")
        NetworkManager.shared.getScheduleData(for: date) { [weak self] result in
            switch result {
            case .success(let schedules):
                self?.scheduleData = schedules
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching schedule data: \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: - Extension
extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Tableview cellforrowat")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let schedule = scheduleData[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTime = dateFormatter.string(from: schedule.startTime)
        let endTime = dateFormatter.string(from: schedule.endTime)
        
        cell.updateScheduleCell(courseName: schedule.courseName, room: schedule.room, startTime: startTime, endTime: endTime)
        
        return cell
    }
}

extension ScheduleViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}
