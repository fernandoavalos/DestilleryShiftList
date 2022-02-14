//
//  ShiftsListVC.swift
//  Destillery
//
//  Created by Fernando Avalos on 11/02/22.
//

import UIKit

class ShiftsListVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    let cellIdentifier = "shiftCell"
    var shifts: [Shift]?
    var employees = Set<String>()
    var roles = Set<String>()
    var colors = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        getShifts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    func setupTableview() {
        tableview.dataSource = self
        tableview.register(UINib(nibName: "ShiftCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func getShifts() {
        ShiftsAPI.shared.loadShifts { result in
            self.handleApiResult(result)
            
        }
    }
    
    func handleApiResult(_ result: Result<APIResult, Error>) {
        switch result {
        case let .success(apiResult):
            self.shifts = apiResult.shifts
            let apiEmployees = apiResult.shifts.reduce(into: Set<String>()) { partialResult, shift in
                partialResult.insert(shift.name)
            }
            self.employees = apiEmployees
            
            let apiRoles = apiResult.shifts.reduce(into: Set<String>()) { partialResult, shift in
                partialResult.insert(shift.role)
            }
            self.roles = apiRoles
            
            let apiColors = apiResult.shifts.reduce(into: Set<String>()) { partialResult, shift in
                partialResult.insert(shift.color)
            }
            self.colors = apiColors
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        case let .failure(error):
            // On this demo it will not fail, but here we can add some logic for when it does
            print("API call failed with error: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newShiftVC = segue.destination as? NewShiftVC else { return }
        newShiftVC.delegatge = self
        newShiftVC.employees = Array(employees)
        newShiftVC.roles = Array(roles)
        newShiftVC.colors = Array(colors)
    }
}

extension ShiftsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let shifts = self.shifts else { return UITableViewCell() }
        
        let shift = shifts[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShiftCell
        cell?.configure(with: shift)
        return cell ?? UITableViewCell()
    }
}

extension ShiftsListVC: NewShiftVCDelegate {
    func didSaveNewShift(shift: Shift) {
        self.shifts?.append(shift)
        self.tableview.reloadData()
    }
}
