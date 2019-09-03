//
//  ProfileViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

class ProfileViewController: PMBaseViewController  {
    
    static var totalScore: Int = 0

    @IBOutlet weak var userTotalPoint: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var getPointTableView: UITableView!{
        didSet{
            getPointTableView.delegate = self
            getPointTableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getPointTableView.dequeueReusableCell(
            withIdentifier: String(describing: GetPointTableViewCell.self),
            for: indexPath)
        
        guard let getPointCell = cell as? GetPointTableViewCell else { return cell }
        return getPointCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
   
}
