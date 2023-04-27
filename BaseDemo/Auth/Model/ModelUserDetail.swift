//
//  ModelUserDetail.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 26/04/23.
//

import Foundation

// MARK: - ModelUserDetail
struct ModelUserDetail:Codable {
    let accessToken, backupFile, backupFile2, backupDateTime: String?
    let backupTo, createdAt: String?
    let customerID: Int?
    let deviceToken, deviceType, email, groupCallSound: String?
    let groupSound: String?
    let id: Int?
    let image: String?
    let isBackupUploaded, isNotification: Int?
    let jabberID: String?
    let jabberPassword: String?
    let licenceActivation, licenceExpiry, licenceID, licenceKey: String?
    let licenceKeyExpired: Bool?
    let licenceType: String?
    let otp: String?
    let permanentAppUUID, photoURL: String?
    let pin: String?
    let pinSet: Int?
    let profileCallSound, profileSound, ptcBusyStatus: String?
    let ptcBusyWith: Int?
    let ptcOnlineStatus, refreshToken, status: String?
    let uniqueID: Int?
    let userStatus, username: String?
}

