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
       missionTableView.separatorStyle = .none
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
        missionCell.missionImage.image = UIImage(named: MissionContent.missionPictures[indexPath.row].rawValue)
        missionCell.rewardView.layer.cornerRadius = 5
        missionCell.limitTimesView.layer.cornerRadius = 5
        missionCell.missionInstroduction.text = MissionContent.missionIntroduction[indexPath.row]
        missionCell.missionTitle.text = MissionContent.missionTitles[indexPath.row].rawValue
        
        missionCell.selectionStyle = .none
        return missionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var goToMissionsController = UIViewController()
        switch indexPath.row {
        
        case 0:
            goToMissionsController = UIStoryboard.mission.instantiateViewController(withIdentifier: "MapViewController")
            
        case 1:
            goToMissionsController = UIStoryboard.mission.instantiateViewController(withIdentifier: "JellyfishViewController")
        case 2:
            goToMissionsController = UIStoryboard.mission.instantiateViewController(withIdentifier: "FishingViewController")
        case 3:
            goToMissionsController = UIStoryboard.mission.instantiateViewController(withIdentifier: "LoginTodayViewController")
            
        default:
            goToMissionsController = UIStoryboard.mission.instantiateViewController(withIdentifier: "MapTodayViewController")
        }
          self.navigationController?.pushViewController(goToMissionsController, animated: true)
    }
    
    
    
    
}
