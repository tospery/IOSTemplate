//
//  ActivityViewController.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/26.
//

import UIKit
import SwiftUI
import HiSwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    let model: ShareModel

    func makeUIViewController(context: Context) -> some UIViewController {
        UIActivityViewController(activityItems: model.items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
}
