//
//  ViewController.swift
//  TestEncoding
//
//  Created by Paul Pearson on 3/24/20.
//  Copyright © 2020 RPM Consulting. All rights reserved.
//

import UIKit

class Setting: Codable {
    var name: String
    var image: UIImage? {
        get {
            guard imageData != nil else { return nil }
            return UIImage(data: imageData!)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 100.0) ?? nil
        }
    }
    var imageData: Data? = nil
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}

class ViewController: UIViewController {

    private let key = "setting-key"
    private var currentImage: Int = 0
    private var images = [UIImage]()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.append(UIImage(named: "animal1")!)
        images.append(UIImage(named: "animal2")!)
        images.append(UIImage(named: "animal3")!)
        images.append(UIImage(named: "animal4")!)
        images.append(UIImage(named: "animal5")!)
        images.append(UIImage(named: "animal6")!)
        perform(#selector(changeImage), with: nil, afterDelay: TimeInterval(1.5))
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else { return }
        let setting = Setting(name: "Chart Image", image: image)
        MyUserDefautls.saveSetting(value: setting, key: key)
    }
    
    @IBAction func load(_ sender: Any) {
        if let setting: Setting = MyUserDefautls.loadSetting(key: key) {
            showNew(image: setting.image)
        }
    }
    
    @IBAction func change(_ sender: Any) {
        changeImage()
    }
    
    @objc private func changeImage() {
        currentImage = (currentImage + 1) % images.count
        displayImage()
    }
    
    private func displayImage() {
        showNew(image: images[currentImage])
    }
    
    private func showNew(image: UIImage?) {
        UIView.transition(with: imageView, duration: 0.75, options: .transitionCrossDissolve, animations: {
            self.imageView.image = image
        },
        completion: nil)
    }
    
}

