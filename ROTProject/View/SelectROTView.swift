//
//  SelectROTView.swift
//  ROTProject
//
//  Created by Hackman Adu Gyamfi on 01/03/2022.
//

import UIKit

class SelectROTView: UIViewController {

    var RotValues = ROTValues.getValues
    var selectedROTValue:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Select ROT"
        navigationController?.navigationBar.backgroundColor = .systemPink
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.initViews()
        
    }
    
    private func initViews(){
        view.addSubview(RotTabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.SetUpLayOuts()
    }
    
    private func SetUpLayOuts(){
        RotTabel.position(top: view.layoutMarginsGuide.topAnchor, left: view.leftAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor)
    }
    
    lazy var RotTabel:UITableView = {
        var table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.register(UITableViewCell.self, forCellReuseIdentifier: "rotCell")
        table.rowHeight = 60
        return table
    }()
}

extension SelectROTView:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RotValues.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedValue:String = self.RotValues[indexPath.row]
        NotificationCenter.default.post(name: .init(rawValue: "ROTSelection"), object: nil, userInfo: ["selected":selectedValue])
        self.dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rotCell", for: indexPath)
        let rotValue = self.RotValues[indexPath.row]
        let isSelected = self.selectedROTValue == rotValue
        cell.backgroundColor = isSelected ? .systemPink.withAlphaComponent(0.07) : .white
        cell.textLabel?.text = rotValue
        cell.textLabel?.textColor = isSelected ? .systemPink : .black
        return cell
    
    }
    
    
}
