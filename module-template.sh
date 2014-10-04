#!/bin/bash

prefix=$1
module=$2

uppercase=$(echo $(echo ${module:0:1} | tr '[:lower:]' '[:upper:]')$(echo ${module:1}))
lowercase=$(echo $(echo ${module:0:1} | tr '[:upper:]' '[:lower:]')$(echo ${module:1}))

mkdir ${uppercase}
cd ${uppercase}

cat <<EOF > ${prefix}${uppercase}VM.swift
import UIKit

class ${prefix}${uppercase}VM: NSObject {

    weak var delegate: ${prefix}${uppercase}VMDelegate?
    weak var userInterface: ${prefix}${uppercase}ViewController?
    let dataManager: ${prefix}${uppercase}DataManager


    // Initialization

    init(userInterface: ${prefix}${uppercase}ViewController, dataManager: ${prefix}${uppercase}DataManager) {
        self.userInterface = userInterface
        self.dataManager = dataManager
    }

}

@objc protocol ${prefix}${uppercase}VMDelegate {

}
EOF

cat <<EOF > ${prefix}${uppercase}DataManager.swift
import UIKit

class ${prefix}${uppercase}DataManager: NSObject {

}
EOF

cat <<EOF > ${prefix}${uppercase}Wireframe.swift
import UIKit

class ${prefix}${uppercase}Wireframe: NSObject, ${prefix}${uppercase}VMDelegate {

    let ${lowercase}ViewController = ${prefix}${uppercase}ViewController(nibName: "${prefix}${uppercase}ViewController", bundle: nil)
    let applicationWireframe: ${prefix}ApplicationWireframe
    var baseViewController: UIViewController?


    // Initialization

    func viewController() -> UIViewController {
        return ${lowercase}ViewController
     }

    init(applicationWireframe: ${prefix}ApplicationWireframe) {
        self.applicationWireframe = applicationWireframe

        super.init()

        var dataManager = ${prefix}${uppercase}DataManager()
        var vm = ${prefix}${uppercase}VM(userInterface: ${lowercase}ViewController, dataManager: dataManager)
        vm.delegate = self
        ${lowercase}ViewController.eventHandler = vm
    }

    // Public methods

    func routeOntoBaseViewController(baseViewController: UIViewController,
    animated: Bool, completion: (()->())?) {
        if baseViewController.presentedViewController != nil {
            return
        }

        self.baseViewController = baseViewController
        self.baseViewController!.presentViewController(${lowercase}ViewController,
        animated: animated, completion: completion)
    }

    func dismiss(#animated: Bool, completion: (()->())?) {
        baseViewController?.dismissViewControllerAnimated(animated,
        completion: completion)
    }

}
EOF

cat <<EOF > ${prefix}${uppercase}ViewController.swift
import UIKit

class ${prefix}${uppercase}ViewController: UIViewController {

    var eventHandler: ${prefix}${uppercase}VM?

}
EOF

cat <<EOF > ${prefix}${uppercase}ViewController.xib
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="6154.21" systemVersion="13E28" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="6153.13"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="${prefix}${uppercase}ViewController" customModule="OkAlright" customModuleProvider="target">
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
