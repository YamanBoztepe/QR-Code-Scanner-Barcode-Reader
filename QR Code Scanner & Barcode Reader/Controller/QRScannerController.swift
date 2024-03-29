//
//  ViewController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 30.01.2021.
//

import UIKit
import AVFoundation
import CoreData
import StoreKit

let appDelegate = UIApplication.shared.delegate as? AppDelegate
var captureSession = AVCaptureSession()

class QRScannerController: UIViewController {
    
    fileprivate var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    fileprivate var isFrontCameraActive = false
    
    fileprivate let scanView = ScanView()
    fileprivate let instructionView = InstructionView()
    
    fileprivate let historyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "clock"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .fill, color: .black)
        return btn
    }()
    
    fileprivate let generatorButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .fill, color: .black)
        return btn
    }()
    
    fileprivate let flashButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bolt.circle"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .fill, color: .black)
        return btn
    }()
    
    fileprivate let flipCameraButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.circle"), for: .normal)
        btn.setDefaultLayout(verticalAlignment: .fill, horizontalAlignment: .fill, color: .black)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAds()
        getInput()
        setLayout()
        setMetaDataOutput()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestReview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    fileprivate func getInput() {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        addInputInCaptureSession(videoCaptureDevice)
    }
    
    fileprivate func requestReview() {
        let appUsageCounter = UserDefaults.standard.integer(forKey: "appUsageCounter")
        
        if appUsageCounter == 3 {
            guard let scene = view.window?.windowScene else { return }
            SKStoreReviewController.requestReview(in: scene)
            UserDefaults.standard.set(-4, forKey: "appUsageCounter")
        }
    }
    
    fileprivate func setLayout() {
        
        setPreviewLayer()
        navigationController?.navigationBar.isHidden = true
        let isInstructionShowed = UserDefaults.standard.bool(forKey: "isInstructionShowed")
        
        [scanView,generatorButton,historyButton,flashButton,flipCameraButton,instructionView].forEach(view.addSubview(_:))
        
        _ = instructionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = scanView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = historyButton.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: view.frame.width/5, left: 0, bottom: 0, right: -5),size: .init(width: view.frame.width/5, height: view.frame.height/9))
        _ = generatorButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: view.frame.width/5, left: 5, bottom: 0, right: 0), size: .init(width: view.frame.width/5, height: view.frame.height/9))
        _ = flashButton.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: historyButton.trailingAnchor,padding: .init(top: 0, left: 0, bottom: -view.frame.width/5, right: 0),size: .init(width: view.frame.width/5, height: view.frame.height/9))
        _ = flipCameraButton.anchor(top: nil, bottom: view.bottomAnchor, leading: generatorButton.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: -view.frame.width/5, right: 0),size: .init(width: view.frame.width/5, height: view.frame.height/9))
        
        //instructionView.isHidden = isInstructionShowed
        instructionView.isHidden = true
        
        historyButton.addTarget(self, action: #selector(historyButtonPressed), for: .touchUpInside)
        generatorButton.addTarget(self, action: #selector(generatorButtonPressed), for: .touchUpInside)
        flashButton.addTarget(self, action: #selector(flashButtonPressed), for: .touchUpInside)
        flipCameraButton.addTarget(self, action: #selector(flipCameraButtonPressed), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(instructionPressed))
        instructionView.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func instructionPressed() {
        
        var isInstructionShowed = UserDefaults.standard.bool(forKey: "isInstructionShowed")
        isInstructionShowed = true
        UserDefaults.standard.set(isInstructionShowed, forKey: "isInstructionShowed")
        
        instructionView.removeFromSuperview()
    }
    
    @objc fileprivate func historyButtonPressed() {
        
        let vc = HistoryController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func generatorButtonPressed() {
        
        let vc = QRGeneratorController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func flashButtonPressed() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if device.torchMode == .off {
                    device.torchMode = .on
                    try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
                    
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc fileprivate func flipCameraButtonPressed() {
        captureSession.inputs.forEach { captureSession.removeInput($0) }
        
        if !isFrontCameraActive {
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
            addInputInCaptureSession(device)
            isFrontCameraActive = true
        } else {
            guard let device = AVCaptureDevice.default(for: .video) else { return }
            addInputInCaptureSession(device)
            isFrontCameraActive = false
        }
        
        flashButton.isEnabled = !isFrontCameraActive
        
    }
    
    fileprivate func setPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        videoPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoPreviewLayer)
    }
    
    fileprivate func setMetaDataOutput() {
        let metaDataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.qr]
        } else {
            
            let alert = UIAlertController(title: "Scanning Error", message: "Scanning is not supported", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    fileprivate func saveData(metadata: String) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let metadataOutput = ScanOutput(context: managedContext)
        
        metadataOutput.metadata = metadata
        metadataOutput.date = Date().getDate()
        
        do {
            
            try managedContext.save()
            print(metadataOutput.metadata!,metadataOutput.date!)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    fileprivate func addInputInCaptureSession(_ videoCaptureDevice: AVCaptureDevice) {
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }

}

extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard let metadataObject = metadataObjects.first, let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject, let stringValue = readableObject.stringValue else { return }
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }

        saveData(metadata: stringValue)
        presentOutput(stringValue: stringValue)
        
    }
    
}
