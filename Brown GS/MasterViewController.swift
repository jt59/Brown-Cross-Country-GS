//
//  MasterViewController.swift
//  Brown GS
//
//  Created by Jillian Turner on 6/27/18.
//  Copyright © 2018 Jillian Turner. All rights reserved.
//

import UIKit


class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    let objects = ["GS 1", "GS 2", "GS 3", "GS 4", "GS 5"]
    let moreOptions = ["View PDF", "Watch Video"]
    
    let gs1Array = [["Donkey Kicks (left)", "30"], ["Donkey Kicks (right)", "30"], ["Scorpions", "30"], ["Iron Cross", "30"], ["3 Position Leg Lift (8 reps)", "-1"], ["Donkey Whips (left)", "30"], ["Donkey Whips (right)", "30"], ["Lower Body Crawl", "30"], ["Single Knee Drop", "45"], ["Scorpions", "30"], ["Iron Cross", "30"], ["Russian Twist", "60"], ["Front Plank", "45"], ["Side Plank", "45"], ["Side Plank", "45"], ["Back Plank", "45"], ["Push ups","60"], ["Russian Hamstring (left)", "30"], ["Russian Hamstring (right)", "30"], ["L-Ups", "60"], ["Bouncing Seated Twist", "60"], ["Fire Hydrant (left)", "30"], ["Fire Hydrant (right)", "30"], ["Leg Swings (10 each side)", "-1"]]
    
    let gs2Array = [["Single Leg Squat (8 each leg)", "-1"], ["Mountain Climbers (12 each leg)", "-1"], ["Scorpions", "45"], ["Iron Cross", "45"], ["Quick Lateral Shuffle", "-1"], ["Full Depth Squats (20)", "-1"], ["Rowers", "60"], ["Swimmers", "60"], ["Lower Body Crawl", "45"], ["Burpies", "30"], ["Russian Hamstring (left)", "30"], ["Russian Hamstring (right)", "30"], ["Front Plank", "90"], ["Side Plank", "90"], ["Side Plank", "90"], ["Back Plank", "90"], ["V-Ups", "60"], ["Single Leg Squat (8 each leg)", "-1"], ["Mountain Climbers (12 each leg)", "-1"],["Full Depth Squats (20)", "-1"], ["Rowers", "60"], ["Swimmers", "60"],["Burpies", "30"],["Front Plank", "90"], ["Side Plank", "90"], ["Side Plank", "90"], ["Back Plank", "90"], ["V-Ups", "60"]]
    
    
    let gs3Array = [["Push ups", "60"], ["Russian Hamstring (left)", "30"], ["Russian Hamstring (right)", "30"], ["Leg Lift & Roll Up", "60"], ["Scorpions", "45"], ["Iron Cross", "30"], ["Bridge & Left Leg Lift", "60"], ["Bridge & Right Leg Lift", "60"], ["Running V-Sit", "60"], ["Swimmers", "60"], ["Praying Sit-Ups", "60"], ["Supermans", "60"], ["3 Position Leg Lift (10 reps)", "-1"], ["Rowers", "60"], ["V-Ups", "60"], ["Bicycle", "60"]]
    
    let gs4Array = [["Praying Sit-Ups", "60"], ["Leg Lift & Roll Up", "60"], ["Bicycle", "60"], ["Russian Twist", "60"], ["Front Plank", "90"], ["Side Plank", "90"], ["Side Plank", "90"], ["Back Plank", "90"], ["Flutter", "60"], ["Toe Taps", "45"], ["Supermans", "60"], ["Bridge & Left Leg Lift", "45"], ["Bridge & Right Leg Lift", "45"], ["Scissors", "60"], ["Rowers", "60"], ["Push ups", "60"], ["Leg Lifts", "60"], ["Front Plank", "60"], ["Side Plank", "60"], ["Side Plank", "60"], ["Back Plank", "60"], ["V-Ups", "60"], ["Leg Swings (10 each side)", "-1"]]
    
    let gs5Array = [["Push ups", "60"], ["Flutter", "60"], ["Russian Twist", "90"], ["Front Plank", "120"], ["Side Plank", "120"], ["Side Plank", "120"], ["Side Crunches (right)", "30"], ["Side Crunches (left)", "30"], ["Single Leg Popdowns (right)", "45"], ["Single Leg Popdowns (left)", "45"], ["Bridge & Left Leg Lift", "45"], ["Bridge & Right Leg Lift", "45"], ["Push ups", "60"], ["Full Depth Squats", "60"], ["Leg Raises", "60"], ["Front Plank", "45"], ["Side Plank", "45"], ["Side Plank", "45"], ["Burpies", "45"], ["Hurdle Seat Exchange", "45"], ["Push ups", "60"],  ["Russian Twist", "90"], ["Side Crunches (right)", "30"], ["Side Crunches (left)", "30"], ["Single Leg Popdowns (right)", "45"], ["Single Leg Popdowns (left)", "45"], ["Bridge & Left Leg Lift", "45"], ["Bridge & Left Leg Lift", "45"], ["Push ups", "60"], ["Full Depth Squats", "60"], ["Hurdle Seat Exchange", "45"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.red
        self.tableView.rowHeight = UIScreen.main.bounds.height / 8
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    

    

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.tableView.rowHeight = UIScreen.main.bounds.height / 8
        lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        timer.invalidate()
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item: String
                if indexPath.section == 0{
                   item = objects[indexPath.row]
                }
                else{
                   item = moreOptions[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = item
                controller.gs = indexPath.row + 1
                controller.isPDF = false
                controller.isVideo = false
                
                switch controller.gs {
                case 1:
                    controller.currArray = gs1Array
                case 2:
                    controller.currArray = gs2Array
                case 3:
                    controller.currArray = gs3Array
                case 4:
                    controller.currArray = gs4Array
                case 5:
                    controller.currArray = gs5Array
                default:
                    break
                }
                
                if indexPath.row == 0 && indexPath.section == 1{
                    controller.isPDF = true
                    controller.gs = 0
                }
                if indexPath.row == 1 && indexPath.section == 1{
                    controller.isVideo = true
                    controller.gs = 0
                }
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 5
        }
        else{
            return 2
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Brown Women's XC General Strength"
        }
        else{
            return "More Options"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let title: String
        if indexPath.section == 0{
            title = objects[indexPath.row]
        }
        else{
            title = moreOptions[indexPath.row]
        }
        cell.textLabel!.text = title.description
        
        switch [indexPath.section, indexPath.row] {
        case [0,0]:
            cell.backgroundColor = UIColor.brown.withAlphaComponent(0.5)
        case [0,1]:
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        case [0,2]:
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        case [0,3]:
            cell.backgroundColor = UIColor.brown.withAlphaComponent(0.5)
        case [0,4]:
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        case [1,0]:
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        case [1,1]:
            cell.backgroundColor = UIColor.brown.withAlphaComponent(0.5)
        default:
            cell.backgroundColor = UIColor.clear
        }
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }



}

