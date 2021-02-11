//
//  ViewController.swift
//  QR Code Scanner & Barcode Reader
//
//  Created by Yaman Boztepe on 30.01.2021.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {

    var captureSession = AVCaptureSession()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    let scanView = ScanView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInput()
        setLayout()
        setMetaDataOutput()
        
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession.isRunning == false {
            captureSession.startRunning()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning == true {
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
        
        [scanView].forEach(view.addSubview(_:))
        _ = scanView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
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

}

extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard let metadataObject = metadataObjects.first, let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject, let stringValue = readableObject.stringValue else { return }
        
        if let url = URL(string: stringValue) {
            UIApplication.shared.open(url, options: [:])
        } else {
            captureSession.stopRunning()
            let vc = OutputTextController()
            vc.outputText = stringValue
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
