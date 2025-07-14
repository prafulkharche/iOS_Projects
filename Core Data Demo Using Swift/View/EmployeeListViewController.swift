import UIKit

class EmployeeListViewController: UITableViewController {

    var employees: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Employees"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        employees = CoreDataManager.shared.fetchEmployees()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let emp = employees[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = """
        Name: \(emp.name ?? "")
        ID: \(emp.empID ?? "") | Grade: \(emp.grade ?? "")
        Mobile: \(emp.mobile ?? "")
        Address: \(emp.address ?? "")
        """

        return cell
    }
}
