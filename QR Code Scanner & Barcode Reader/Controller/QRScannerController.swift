//
//  ViewController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 30.01.2021.
//

import UIKit
import AVFoundation
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
var captureSession = AVCaptureSession()

class QRScannerController: UIViewController {
    
    fileprivate var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    fileprivate let scanView = ScanView()
    fileprivate let historyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "HistoryButton"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInput()
        setLayout()
        setMetaDataOutput()
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
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func setLayout() {
        setPreviewLayer()
        navigationController?.navigationBar.isHidden = true
        
        [scanView,historyButton].forEach(view.addSubview(_:))
        
        _ = scanView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = historyButton.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: view.frame.width/10, left: 0, bottom: 0, right: -5))
        
        historyButton.addTarget(self, action: #selector(historyButtonPressed), for: .touchUpInside)
        
    }
    
    @objc fileprivate func historyButtonPressed() {
        
        let vc = HistoryController()
        navigationController?.pushViewController(vc, animated: true)
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
