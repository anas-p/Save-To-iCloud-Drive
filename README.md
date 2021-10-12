# Save-To-iCloud-Drive
Save a document to iCloud drive

### Steps to follow:
1. Start new Project
2. Enable **iCloud Documents** with Xcode, from tab **Capabilities**
3. Create App Id and enable iCloud feature to your App Id
4. Go to **Info.plist** of you application and add something similar to this.

    **Note:
    You need to have `NSUbiquitousContainerIsDocumentScopePublic=true` in Info.plist before you run the app for the *first time*, Otherwise directory will not be shown in iCloud Drive, It will be a hidden directory.**

    ```swift
    <key>NSUbiquitousContainers</key>
	<dict>
		<key>iCloud.$(PRODUCT_BUNDLE_IDENTIFIER)</key>
		<dict>
			<key>NSUbiquitousContainerIsDocumentScopePublic</key>
			<true/>
			<key>NSUbiquitousContainerName</key>
			<string>Folder_Name</string>
			<key>NSUbiquitousContainerSupportedFolderLevels</key>
			<string>Any</string>
		</dict>
	</dict>
    ```
5. In ViewController **Create Directory**
    ```swift
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
    ```
6. Then put all files inside to this Directory
    ```swift
    func copyDocumentsToiCloudDirectory() {
        guard let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last else { return }
        
        guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents").appendingPathComponent("Subdirectory") else { return }
        
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
            try FileManager.default.copyItem(at: localDocumentsURL, to: iCloudDocumentsURL)
        }
        catch {
            //Error handling
            print("Error in copy item")
        }
    }
    ```
    7: Run the application
    
    
