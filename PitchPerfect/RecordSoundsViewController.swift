//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Isaiah McNealy on 4/10/20.
//  Copyright © 2020 isaiahmcnealy. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: Properties
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    enum RecordingState {
        case recording
        case notRecording
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        stopRecordingButton.isEnabled = false  // start with stopRecordingButton disabled
    }

    // called when the record button is pressed
    @IBAction func recordAudio(_ sender: Any) {
        
        // create an alert
        let alertError = UIAlertController(title: "Warning!", message: "I'm sorry there was a problem trying to record your audio. Please try again", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
    
        // update ui on button press
        updateUI(.recording)
        
        // record and save audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        } catch {
            print("There was an error recording")
            self.present(alertError, animated: true)
        }
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    // called when the stop button is pressed
    @IBAction func stopRecording(_ sender: Any) {
        
        // update the ui
        updateUI(.notRecording)
        
        // stop the recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // when the audio finishes recording
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not sucessful")
        }
    }
    
    // send the data to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioUrl
        }
    }
    
    // update UI
    func updateUI(_ recordingState: RecordingState){
        switch recordingState {
            case .recording:
                stopRecordingButton.isEnabled = true
                recordButton.isEnabled = false
                recordingLabel.text = "Stop Recording"
                
            case .notRecording:
                recordButton.isEnabled = true
                stopRecordingButton.isEnabled = false
                recordingLabel.text = "Tap to Record"
        }
    }
}

