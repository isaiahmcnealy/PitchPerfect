//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Isaiah McNealy on 4/10/20.
//  Copyright © 2020 isaiahmcnealy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let TAG = "ViewController"

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearcalled")
    }
 

    @IBAction func recordAudio(_ sender: Any) {
        print("\(TAG): record button pressed")
        recordingLabel.text = "recording in progress"
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("\(TAG): stopRecording button pressed")
        recordingLabel.text = "Tap to Record"
    }
}

