//
//  DetailViewController.swift
//  Brown GS
//
//  Created by Jillian Turner on 6/27/18.
//  Copyright © 2018 Jillian Turner. All rights reserved.
//

import UIKit
import AVKit
import PDFKit
import AVFoundation
import UserNotifications

var timer = Timer()
let center = UNUserNotificationCenter.current()


class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var isPDF = false
    var isVideo = false
    var gs = 0
    var currArray = [[""]]
    var currIndex = 0
    var time: Double = 0
    let synth = AVSpeechSynthesizer()
    var player = AVAudioPlayer()
    var cont = false
    let nextWidthLabel = UILabel()
    var constraint = NSLayoutConstraint()
    var dateStamp: Date? = nil
    

    

    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currEx: UILabel!
    @IBOutlet weak var rewindButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var nextLabel: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var table: UITableView!
    let options = ["Straight Through", "Grouped by Repititions"]
    
    let gs2GroupedArray = [["Single Leg Squat (8 each leg)", "-1"], ["Mountain Climbers (12 each leg)", "-1"], ["Scorpions", "45"], ["Iron Cross", "45"], ["Quick Lateral Shuffle", "-1"], ["Single Leg Squat (8 each leg)", "-1"], ["Mountain Climbers (12 each leg)", "-1"], ["Full Depth Squats (20)", "-1"], ["Rowers", "60"], ["Swimmers", "60"], ["Lower Body Crawl", "45"], ["Full Depth Squats (20)", "-1"], ["Rowers", "60"], ["Swimmers", "60"], ["Burpies", "30"], ["Russian Hamstring (left)", "30"], ["Russian Hamstring (right)", "30"], ["Front Plank", "90"], ["Side Plank", "90"], ["Side Plank", "90"], ["Back Plank", "90"], ["V-Ups", "60"], ["Burpies", "30"],["Front Plank", "90"], ["Side Plank", "90"], ["Side Plank", "90"], ["Back Plank", "90"], ["V-Ups", "60"]]
    
    
    let gs5GroupedArray = [["Push ups", "60"], ["Flutter", "60"], ["Russian Twist", "90"], ["Push ups", "60"],  ["Russian Twist", "90"], ["Front Plank", "120"], ["Side Plank", "120"], ["Side Plank", "120"], ["Side Crunches (right)", "60"], ["Side Crunches (left)", "60"], ["Single Leg Popdowns (right)", "45"], ["Single Leg Popdowns (left)", "45"], ["Bridge & Left Leg Lift", "45"], ["Bridge & Left Leg Lift", "45"], ["Push ups", "60"], ["Full Depth Squats", "60"], ["Single Leg Popdowns (right)", "45"], ["Single Leg Popdowns (left)", "45"], ["Bridge & Left Leg Lift", "45"], ["Bridge & Right Leg Lift", "45"], ["Push ups", "60"], ["Full Depth Squats", "60"], ["Leg Raises", "60"], ["Front Plank", "45"], ["Side Plank", "45"], ["Side Plank", "45"], ["Burpies", "45"], ["Hurdle Seat Exchange", "90"]]
    var gs2StraightArray = [[""]]
    var gs5StraightArray = [[""]]
    
    
    func setUpVideo(){
        if let path = Bundle.main.path(forResource: "gs", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = VideoViewController()
            videoPlayer.player = video
            present(videoPlayer, animated: true) {
                video.play()
            }
        }
    }
    
    func setUpPDF(){
        startButton.isHidden = true
        self.hideBarButtons(hide: true)
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.rightBarButtonItems = nil
        
        let pdfView = PDFView()
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        guard let path = Bundle.main.url(forResource: "1617.XC - GS1-5", withExtension: "pdf") else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = options[indexPath.row]
        if indexPath.row == 0{
           cell.accessoryType = .checkmark
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType = .none
        table.cellForRow(at: IndexPath(row: 1, section: 0))?.accessoryType = .none
        table.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if indexPath.row == 1{
            if gs == 2{
                currArray = gs2GroupedArray
            }
            else if gs == 5{
                currArray = gs5GroupedArray
            }
        }
        else{
            if gs == 2{
                currArray = gs2StraightArray
            }
            else if gs == 5{
                currArray = gs5StraightArray
            }
        }
    }
    


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            self.title = detail
        }
        else{
            table.isHidden = true
            self.title = "GS"
            startButton.isHidden = true
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(enterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
        constraint = nextWidthLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100)
        
        // Do any additional setup after loading the view, typically from a nib.
        if UIScreen.main.bounds.width < 340{
            timeLabel.font = timeLabel.font.withSize(75)
            let timeContraint = timeLabel.widthAnchor.constraint(equalToConstant: 300)
            timeContraint.isActive = true
            let exContraint = currEx.widthAnchor.constraint(equalToConstant: 300)
            exContraint.isActive = true
        }
        table.isHidden = true
        hideLabels(hide: true)
        hideBarButtons(hide: true)
        pauseButton.isEnabled = false
        configureView()
        if let detail = detailItem{
            startButton.setTitle("Start \(detail)", for: UIControl.State.normal)
        }
        if gs == 2{
            gs2StraightArray = currArray
            table.isHidden = false
        }
        else if gs == 5{
            gs5StraightArray = currArray
            table.isHidden = false
        }
        if isPDF{
            self.setUpPDF()
        }
        if isVideo{
            setUpVideo()
            startButton.setTitle("Play", for: UIControl.State.normal)
            self.hideBarButtons(hide: true)
            self.navigationItem.leftBarButtonItems = nil
            self.navigationItem.rightBarButtonItems = nil
        }
        if gs != 0{
            lockOrientation(UIInterfaceOrientationMask.portrait)
            currEx.isHidden = false
            var startSec = ""
            if Int(currArray[currIndex][1])! > 0{
                startSec = "(\(currArray[currIndex][1]) sec)"
            }
            currEx.text = "First Exercise: \(currArray[0][0]) \(startSec)"
            currEx.font = currEx.font.withSize(25)
        }
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//    }
//    @objc func enterForeground(){
//        print("FOREGROUND")
//        //let currDate = Date()
//        let timeDif = Date(timeInterval: 0, since: dateStamp!)
//        let calendar = Calendar.current
//
//        let hour = calendar.component(.hour, from: timeDif)
//        let minutes = calendar.component(.minute, from: timeDif)
//        let seconds = calendar.component(.second, from: timeDif)
//        print(timeDif)
//    }
    
//    @objc func appMovedToBackground() {
//        print("App moved to background!")
//        if timer.isValid{
//
//            dateStamp = Date()
//            let calendar = Calendar.current
//
//            let hour = calendar.component(.hour, from: dateStamp!)
//            let minutes = calendar.component(.minute, from: dateStamp!)
//            let seconds = calendar.component(.second, from: dateStamp!)
//            print("hours = \(hour):\(minutes):\(seconds)")
//
//            print(time)
//
//            let category = UNNotificationCategory(identifier: "UYLReminderCategory",
//                                                  actions: [],
//                                                  intentIdentifiers: [], options: [])
//            center.setNotificationCategories([category])
//            let options: UNAuthorizationOptions = [.alert, .sound, .badge];
//            center.requestAuthorization(options: options) {
//                (granted, error) in
//                if !granted {
//                    print("Something went wrong")
//                }
//                else{
//                    let content = UNMutableNotificationContent()
//                    content.categoryIdentifier = "UYLReminderCategory"
//                    content.title = self.currArray[self.currIndex + 1][0]
//                    //content.body = "Buy some milk"
//                    content.sound = UNNotificationSound.default()
//                    let date = Date(timeIntervalSinceNow: self.time)
//                    let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
//                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
//                                                                repeats: false)
//                    let identifier = "UYLLocalNotification"
//                    let request = UNNotificationRequest(identifier: identifier,
//                                                        content: content, trigger: trigger)
//                    center.add(request, withCompletionHandler: { (error) in
//                        if let error = error {
//                            // Something went wrong
//                        }
//
//
//                    })
//                }
//            }
//        }
//    }
//
//    func runInBackground(){
//
//    }
//
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func hideBarButtons(hide: Bool){
        toolBar.isHidden = hide
        playButton.isEnabled = !hide
        pauseButton.isEnabled = hide
    }
    
    func hideLabels(hide: Bool){
        remainLabel.isHidden = hide
        timeLabel.isHidden = hide
        currEx.isHidden = hide
    }

    
    func timeString(time: Double) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time - Double(minutes) * 60)
        let tenths = Int(round((time - Double(minutes) * 60 - Double(seconds)) * 100))
        return String(format:"%02i:%02i.%02i", minutes, seconds, tenths)
    }
    
    @objc func countDown(){
        time -= 0.01
        timeLabel.text = "\(timeString(time: time))"
        var sound = ""
        var string = ""
        if Int(time * 100) < 300{
            timeLabel.textColor = UIColor.red
        }
        else{
            timeLabel.textColor = UIColor.white
        }
        switch  Int(time * 100){
        case 525:
            if forwardButton.isEnabled{
                string = "\(currArray[currIndex + 1][0]) in"
            }
            else{
                string = "Finished in"
            }
        case 300:
            string = "three"
            //sound = "low_beep"
        case 200:
            string = "two"
            sound = "low_beep"
        case 100:
            string = "one"
            //sound = "low_beep"

        default:
            break
        }
//        if sound != ""{
//            let audioPath = Bundle.main.path(forResource: sound, ofType: "mp3")
//            do{
//                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
//                player.play()
//            }
//            catch{
//                print("ERROR")
//            }
//        }
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
        if Int(time * 100) == 0{
            currIndex += 1
            newEx()
        }
    }

    
    internal func newEx(){
//        let audioPath = Bundle.main.path(forResource: "high_beep", ofType: "mp3")
//        do{
//            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
//            player.play()
//        }
//        catch{
//            print("ERROR")
//        }
        if currIndex > 0{
            rewindButton.isEnabled = true
        }
        var utt = ""
        if currIndex < currArray.count{
            currEx.text = currArray[currIndex][0]
            utt = currArray[currIndex][0]
            if currArray.count - 1 - currIndex != 1{
                remainLabel.text = "\(currArray.count - 1 - currIndex) exercises remaining"
            }
            else{
                remainLabel.text = "1 exercise remaining"
            }
            if Int(currArray[currIndex][1])! > 0{
               time = Double(currArray[currIndex][1])!
                if cont{
                    cont = false
                    timeLabel.isHidden = false
                    startButton.isHidden = true
                    startButton.setTitle("Start", for: UIControl.State.normal)
                    playButton.isEnabled = true
                    pauseButton.isEnabled = false
                    self.navigationItem.setHidesBackButton(true, animated: true)
                }
            }
            else{
                timer.invalidate()
                timeLabel.isHidden = true
                startButton.isHidden = true
                startButton.setTitle("Continue", for: UIControl.State.normal)
                playButton.isEnabled = false
                pauseButton.isEnabled = false
                self.navigationItem.setHidesBackButton(false, animated: true)
                cont = true
                startButton.isHidden = false
                forwardButton.isEnabled = false
            }
            if currIndex + 1 < currArray.count{
                if !cont{
                   forwardButton.isEnabled = true
                }
                var seconds = ""
                if Int(currArray[currIndex + 1][1])! > 0{
                    seconds = "(\(currArray[currIndex + 1][1]) sec)"
                }
                
                
                nextWidthLabel.text = "Next: \(currArray[currIndex + 1][0]) \(seconds)"
                setNextWidth()
                nextWidthLabel.textAlignment = NSTextAlignment.center
                nextLabel.customView = nextWidthLabel
                nextLabel.customView?.setNeedsLayout()
            }
            else{
                forwardButton.isEnabled = false
                nextLabel.title = ""
            }
        }
        else{
            utt = "Done!"
           done()
        }
        let utterance = AVSpeechUtterance(string: utt)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
    }
    
    internal func setNextWidth(){
        if UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown{
            constraint.isActive = true
        }
        else{
            constraint.isActive = false
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        setNextWidth()
    }
    
    internal func done(){
        timer.invalidate()
        currEx.text = "Done!"
        self.navigationItem.setHidesBackButton(false, animated: true)
        hideBarButtons(hide: true)
        pauseButton.isEnabled = false
        remainLabel.isHidden = true
    }
    
    @IBAction func play(_ sender: AnyObject? = nil) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(DetailViewController.countDown), userInfo: nil, repeats: true)
        playButton.isEnabled = false
        pauseButton.isEnabled = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
        pauseButton.isEnabled = false
        playButton.isEnabled = true
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    
    
    @IBAction func start(_ sender: Any) {
        if cont{
            cont = false
            timeLabel.isHidden = false
            startButton.isHidden = true
            startButton.setTitle("Start", for: UIControl.State.normal)
            playButton.isEnabled = false
            pauseButton.isEnabled = true
            self.navigationItem.setHidesBackButton(true, animated: true)
            if currIndex + 1 < currArray.count{
              forward(nil)
            }
            else{
                timeLabel.isHidden = true
                currIndex += 1
                newEx()
            }
        }
        else{
            if isVideo{
                setUpVideo()
            }
            else{
                self.navigationItem.setHidesBackButton(true, animated: true)
                table.isHidden = true
                startButton.isHidden = true
            }
            
            if gs != 0{
                self.view.backgroundColor = UIColor.black
                timeLabel.textColor = UIColor.white
                currEx.textColor = UIColor.white
                remainLabel.textColor = UIColor.white
                hideBarButtons(hide: false)
                hideLabels(hide: false)
                rewindButton.isEnabled = false
                startGS()
            }
        }
        
    }
    
    func startGS(){
        self.play(nil)
        time = Double(currArray[currIndex][1])!
        hideLabels(hide: false)
        if UIScreen.main.bounds.width < 340{
           currEx.font = currEx.font.withSize(50)
        }
        else{
            currEx.font = currEx.font.withSize(60)
        }
        currEx.text = currArray[currIndex][0]
        timeLabel.text = "\(timeString(time: time))"
        newEx()
    }
    
    @IBAction func rewind(_ sender: Any) {
        timer.invalidate()
        currIndex -= 1
        forwardButton.isEnabled = true
        if currIndex == 0{
            rewindButton.isEnabled = false
        }
        resume()
    }
    
    
    @IBAction func forward(_ sender: AnyObject? = nil) {
        timer.invalidate()
        currIndex += 1
        rewindButton.isEnabled = true
        if currIndex + 1 == currArray.count{
            forwardButton.isEnabled = false
        }
        resume()
    }
    
    internal func resume(){
        if Double(currArray[currIndex][1])! > 0{
            time = Double(currArray[currIndex][1])!
        }
        else{
            timeLabel.isHidden = true
            cont = true
            timer.invalidate()
        }
        newEx()
        timeLabel.text = "\(timeString(time: time))"
        if !playButton.isEnabled && !cont{
            play()
        }
        else{
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }
    

}

