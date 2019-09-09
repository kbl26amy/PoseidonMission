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

       missionTableView.backgroundView = UIImageView(image: UIImage(named: "missionbackground"))
       
    }
    
}
extension MissionViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missionTableView.dequeueReusableCell(
            withIdentifier: String(describing: MissionTableViewCell.self),
            for: indexPath)
        
        guard let missionCell = cell as? MissionTableViewCell else { return cell }
        
        missionCell.backgroundView = UIImageView(image: UIImage(named: "missiontask"))
        missionCell.missionImage.image = UIImage(named: "mapmission")
        return missionCell
    }
    
    
}
