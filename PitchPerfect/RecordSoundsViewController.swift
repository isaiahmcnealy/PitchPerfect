//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Isaiah McNealy on 4/10/20.
//  Copyright © 2020 isaiahmcnealy. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {
    
    // MARK: Properties
    
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
        
        stopRecordingButton.isEnabled = false  // start with stopRecordingButton disabled
    }
 

    @IBAction func recordAudio(_ sender: Any) {
        
        // disable record button and enable stop button while recording
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        recordingLabel.text = "Stop Recording"
    }

    @IBAction func stopRecording(_ sender: Any) {
        
        // enable record button and disable stop button while recording
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
    }
}

