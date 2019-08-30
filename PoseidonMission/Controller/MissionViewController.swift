//
//  MissionViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class MissionViewController: PMBaseViewController  {

    @IBOutlet weak var missionTableView: UITableView!{
        didSet{
             missionTableView.delegate = self
             missionTableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

}
extension MissionViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missionTableView.dequeueReusableCell(
            withIdentifier: String(describing: missionTableViewCell.self),
            for: indexPath)
        
        guard let missionCell = cell as? missionTableViewCell else { return cell }
        return missionCell 
    }
    
    
}
