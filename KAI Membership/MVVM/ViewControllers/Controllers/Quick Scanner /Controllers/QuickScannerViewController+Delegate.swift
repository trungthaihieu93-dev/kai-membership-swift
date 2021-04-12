//
//  QuickScannerViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/04/2021.
//

import AVFoundation

// MARK: AVCaptureMetadataOutputObjectsDelegate
extension QuickScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            detectQRString = nil
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if let stringValue = metadataObj.stringValue {
                Helper.launchApp(from: self, decodedURL: stringValue)
                messageLabel.text = stringValue
                detectQRString = stringValue
                completion?(stringValue)
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
