#!/bin/bash

module=$1

uppercase=$(echo $(echo ${module:0:1} | tr '[:lower:]' '[:upper:]')$(echo ${module:1}))
lowercase=$(echo $(echo ${module:0:1} | tr '[:upper:]' '[:lower:]')$(echo ${module:1}))

mkdir ${uppercase}
cd ${uppercase}

cat <<EOF > OK${uppercase}VM.swift
import UIKit

class OK${uppercase}VM: NSObject {

    var delegate: ${uppercase}VMDelegate?
    weak var userInterface: OK${uppercase}ViewController?
    let dataManager: OK${uppercase}DataManager


    // Initialization

    init(userInterface: OK${uppercase}ViewController, dataManager: OK${uppercase}DataManager) {
        self.userInterface = userInterface
        self.dataManager = dataManager
    }

}

@class_protocol protocol ${uppercase}VMDelegate {

}
EOF

cat <<EOF > OK${uppercase}DataManager.swift
import UIKit

class OK${uppercase}DataManager: NSObject {
   
}
EOF

cat <<EOF > OK${uppercase}Wireframe.swift
import UIKit

class OK${uppercase}Wireframe: NSObject, ${uppercase}VMDelegate {

    let ${lowercase}ViewController = OK${uppercase}ViewController()
    let applicationWireframe: OKApplicationWireframe
    var baseViewController: UIViewController?


    // Initialization

    init(applicationWireframe: OKApplicationWireframe) {
        self.applicationWireframe = applicationWireframe

        super.init()

        var dataManager = OK${uppercase}DataManager()
        var vm = OK${uppercase}VM(userInterface: ${lowercase}ViewController, dataManager: dataManager)
        vm.delegate = self
        ${lowercase}ViewController.eventHandler = vm
    }

    // Public methods

    func routeOntoBaseViewController(baseViewController: UIViewController) {
        if baseViewController.presentedViewController {
            return
        }

        self.baseViewController = baseViewController
        self.baseViewController!.presentViewController(${lowercase}ViewController, animated: false, completion: nil)
    }

    func dismiss() {
        self.baseViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
   
}
EOF

cat <<EOF > OK${uppercase}ViewController.swift
import UIKit

class OK${uppercase}ViewController: UIViewController {

    var eventHandler: OK${uppercase}VM?

}
EOF

cat <<EOF > OK${uppercase}ViewController.xib
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="6154.21" systemVersion="13E28" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="6153.13"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="OK${uppercase}ViewController" customModule="OkAlright" customModuleProvider="target">
            <connections>
                <outlet property="view" destination="i5M-Pr-FkT" id="sfx-zR-JGt"/>
            </connections>
        </placeholder>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <view clearsContextBeforeDrawing="NO" contentMode="scaleToFill" id="i5M-Pr-FkT">
            <rect key="frame" x="0.0" y="0.0" width="320" height="568"/>
            <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
            <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
            <simulatedStatusBarMetrics key="simulatedStatusBarMetrics"/>
            <simulatedScreenMetrics key="simulatedDestinationMetrics" type="retina4"/>
        </view>
    </objects>
</document>
EOF