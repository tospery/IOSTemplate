//
//  LocationManager.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/28.
//

import Foundation
import CoreLocation
import HiLog

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager() // 单例实例
    
    private let locationManager = CLLocationManager()
    private var locationCallback: ((CLLocationCoordinate2D?, Error?) -> Void)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // 请求授权
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // 获取当前位置
    func startUpdatingLocation(completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        locationCallback = completion
        let status = locationManager.authorizationStatus
        
        // 检查权限
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else if status == .notDetermined {
            requestAuthorization()
        } else {
            completion(nil, APPError.locateFailure)
        }
    }
    
    // 停止定位
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation() // 获取到一次位置后停止更新
        locationCallback?(location.coordinate, nil)
        locationCallback = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        locationCallback?(nil, error)
        locationCallback = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        log("权限变化了：\(status)")
        if status == .denied || status == .restricted {
            locationCallback?(nil, APPError.locateRefused)
            locationCallback = nil
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
}
