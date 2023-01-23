//
//  DynamicURL.swift
//  MarvelApp
//
//  Created by Ali Merhie on 21/11/2022.
//

import Foundation
import FirebaseRemoteConfig

class DynamicURL {
    //MARK: - Properties
    static var shared = DynamicURL()
    var currentURL: Data {
        let allConfigs = RemoteConfig.remoteConfig().allKeys(from: .remote)
        if let versionKey = allConfigs.first(where: {$0 == "ONLY" + DeviceHelper.configAppVersion}) {
            return RemoteConfig.remoteConfig().configValue(forKey: versionKey).dataValue
        }else if let rangeKey = allConfigs.first(where: {$0.currentVersionContained}) {
            return RemoteConfig.remoteConfig().configValue(forKey: rangeKey).dataValue
        }
        return RemoteConfig.remoteConfig().configValue(forKey: "defaultURL").dataValue
    }
    //MARK: - Initializer
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleConnection), name: .internetConnectionBack, object: nil)
    }
    //MARK: - Functions
    func getURL() -> SchemeURL {
        guard let url = AppSettings.baseURL else {
            check()
            return getURL()
        }
        return url
    }
    func check() {
        guard NetworkReachability.isReachable else {return}
        let config = RemoteConfigSettings()
        config.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = config
        RemoteConfig.remoteConfig().fetch { status, error in
            guard status == .success else {return}
            RemoteConfig.remoteConfig().activate { _, _ in
                do {
                    let object = try JSONDecoder().decode(SchemeURL.self, from: self.currentURL)
                    AppSettings.baseURL = object
                }catch {
                    print(String(describing: error))
                }
            }
        }
    }
    @objc func handleConnection() {
        check()
    }
}

struct SchemeURL: Codable {
    var release: String
    var debug: String
}
