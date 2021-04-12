//
//  Helper.swift
//  KAI Membership
//
//  Created by DAKiet on 09/03/2021.
//

import UIKit

class Helper {
    
    class func toJSONString<T: BaseModel>(_ object: T?) -> String? {
        guard let object = object else { return nil }
        
        do {
            let encodedData = try JSONEncoder().encode(object)
            let jsonString = String(data: encodedData, encoding: .utf8)
            
            return jsonString
        } catch let error {
            debugPrint("JSONEncoder Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    class func toObject<T: BaseModel>(ofType type: T.Type, jsonString: String) -> T? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        
        do {
            let object = try JSONDecoder().decode(type, from: data)
            
            return object
        } catch let error {
            debugPrint("JSONEncoder Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    class func toObjects<T: BaseModel>(ofType type: [T].Type, jsonString: String) -> [T]? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        
        do {
            let objects = try JSONDecoder().decode(type, from: data)
            
            return objects
        } catch let error {
            debugPrint("JSONEncoder Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    class func openSafari(_ link: String? = nil) {
        guard let link = link, let url = URL(string: link) else {
            debugPrint("Error: Invalid link")
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    class func openAppMail(_ email: String) -> Bool {
        guard let url = URL(string: "mailto:\(email)") else { return false }
        
        UIApplication.shared.open(url)
        return true
    }
    
    class func getConfig(forKey key: ConfigKey) -> [ConfigRemote] {
        return AppSetting.configures.first(where: { $0.name == key.rawValue })?.configs ?? []
    }
    
    class func saveImageToLibrary(image: UIImage, destinationURL: URL? = nil) -> URL {
        var destURL: URL!
        
        if let url = destinationURL {
            try? FileManager.default.removeItem(at: url)
            destURL = url
        } else {
            let imageName = "\(UUID().uuidString).png"
            var documentsDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsDirectoryPath.appendPathComponent(imageName)
            destURL = documentsDirectoryPath
        }

        do {
            try image.pngData()?.write(to: destURL)
        } catch let error {
            print(error)
        }
        
        return destURL
    }
    
    class func launchApp(from viewController: UIViewController, decodedURL: String) {
        if viewController.presentedViewController != nil { return }
        
        let alertPrompt = UIAlertController(title: "Open App", message: "You're going to open \(decodedURL)", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            if let url = URL(string: decodedURL) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        
        viewController.present(alertPrompt, animated: true, completion: nil)
    }
    
    class func requestVerifyEmail() {
        if AccountManagement.isLoggedIn, let userID = AccountManagement.userID, !userID.isEmpty {
            QuestServices.checkMissionCompleted(userID: userID, key: .verifyEmail) {
                switch $0 {
                case .success(let result):
                    guard result.data != true else { return }
                    
                    QuestServices.requestUserQuest(with: .verifyEmail) { result in
                        AlertManagement.shared.showToast(with: "🎁 You have 01 free spin", position: .top)
                        NotificationCenter.default.post(name: .requestQuestSuccess, object: QuestKey.verifyEmail)
                    }
                case .failure:
                    QuestServices.requestUserQuest(with: .verifyEmail) { result in
                        AlertManagement.shared.showToast(with: "🎁 You have 01 free spin", position: .top)
                        NotificationCenter.default.post(name: .requestQuestSuccess, object: QuestKey.verifyEmail)
                    }
                }
            }
        }
    }
}

