//
//  ViewController.swift
//  SaveToiCloud
//
//  Created by 🅐🅝🅐🅢 on 16/10/18.
//  Copyright © 2018 nfnlabs. All rights reserved.
//

import UIKit

//IMPORTANT:
//You need to have `NSUbiquitousContainerIsDocumentScopePublic=true` in Info.plist before you run the app for the first time

class ViewController: UIViewController {

    let file = "file.txt" //Text file to save to iCloud
    let text = "sample text" //Text to write into the file
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Save file to local directory
        self.saveToDirectory()
    }

    //Create iCloud Drive directory
    func createDirectory(){
        if let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") {
            if (!FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: nil)) {
                do {
                    try FileManager.default.createDirectory(at: iCloudDocumentsURL, withIntermediateDirectories: true, attributes: nil)
                }
                catch {
                    //Error handling
                    print("Error in creating doc")
                }
            }
        }
    }
    
    //Copy files from local directory to iCloud Directory
    func copyDocumentsToiCloudDirectory() {
        guard let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last else { return }
        
        let fileURL = localDocumentsURL.appendingPathComponent(file)
        
        guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").appendingPathComponent("file.txt") else { return }
        
        var isDir:ObjCBool = false
        
        if FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir) {
            do {
                try FileManager.default.removeItem(at: iCloudDocumentsURL)
            }
            catch {
                //Error handling
                print("Error in remove item")
            }
        }
        
        do {
            try FileManager.default.copyItem(at: fileURL, to: iCloudDocumentsURL)
        }
        catch {
            //Error handling
            print("Error in copy item")
        }
    }
    
    //Save text file to local directory
    func saveToDirectory(){
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent(file)
        
        print(directory)
        //Writing
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            /* error handling here */
            print("Error in writing")
        }
        
        //Reading
        do {
            let getText = try String(contentsOf: fileURL, encoding: .utf8)
            print(getText)
        }
        catch {
            /* error handling here */
            print("Error in reading")
        }
        
    }
    
    // MARK: - Actions
    @IBAction func btnCreateDiredtory(_ sender: UIButton) {
        self.createDirectory()
    }
    
    @IBAction func btnCopyFiles(_ sender: UIButton) {
        self.copyDocumentsToiCloudDirectory()
    }
    
    
}

