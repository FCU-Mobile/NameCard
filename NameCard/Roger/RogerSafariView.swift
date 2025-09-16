//
//  RogerSafariView.swift
//  NameCard
//
//  Created by Roger on 12/30/24.
//

import SwiftUI
import SafariServices

struct RogerSafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let safariVC = SFSafariViewController(url: url, configuration: config)
        safariVC.preferredControlTintColor = UIColor.systemBlue
        safariVC.preferredBarTintColor = UIColor.systemBackground
        
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No updates needed
    }
}
