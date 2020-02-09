//
//  ViewController.swift
//  HelloWorld
//
//  Created by Praveen Bhaskar on 2/9/20.
//  Copyright © 2020 Praveen Bhaskar. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
    }

    @IBAction func openFlutterButtonAction(_ sender: Any) {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController =
            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        self.initFlutterCalls(controller: flutterViewController)
        self.navigationController?.pushViewController(flutterViewController, animated: true)
    }
}

extension ViewController {
    func initFlutterCalls(controller: FlutterViewController) {
        let serviceChannel = FlutterMethodChannel(name: "flutter.native/helper",
                                                  binaryMessenger: controller.binaryMessenger)
        
        serviceChannel.setMethodCallHandler { (methodCall: FlutterMethodCall, result: FlutterResult) in
            switch methodCall.method {
            case "onBackPressed":
                self.navigationController?.popViewController(animated: true)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
