//
//  WaypointEditViewController.swift
//  Trax
//
//  Created by Laura Calinoiu on 06/09/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class EditWaypointViewController: UIViewController, UITextFieldDelegate {
  
  var waypointToEdit: EditableWaypoint? { didSet { updateUI()}}
  @IBOutlet weak var nameTextField: UITextField! { didSet {nameTextField.delegate = self} }
  @IBOutlet weak var infoTextField: UITextField! { didSet {infoTextField.delegate = self} }
  
  private func updateUI(){
    nameTextField?.text = waypointToEdit?.title
    infoTextField?.text = waypointToEdit?.info
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    nameTextField.becomeFirstResponder()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    listenToTextFields()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    stopListeningToTextFileds()
  }
  
  @IBAction func donePressed(sender: UIBarButtonItem) {
    presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  private var ntfObserver: NSObjectProtocol?
  private var itfObserver: NSObjectProtocol?
  
  private func listenToTextFields(){
    let center = NSNotificationCenter.defaultCenter()
    let mainQueue = NSOperationQueue.mainQueue()
    
    ntfObserver = center.addObserverForName(UITextFieldTextDidChangeNotification,
                              object: nameTextField,
                              queue: mainQueue) { notification in
                                if let waypoint = self.waypointToEdit {
                                  waypoint.name = self.nameTextField.text
                                }
                              }
    
    itfObserver = center.addObserverForName(UITextFieldTextDidChangeNotification,
                              object: infoTextField,
                              queue: mainQueue) { notification in
                                if let waypoint = self.waypointToEdit {
                                  waypoint.info = self.infoTextField.text
                                }
    }
  }
  
  private func stopListeningToTextFileds(){
    if let observer = ntfObserver{
      NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    if let observer = itfObserver{
      NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
