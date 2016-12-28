//
//  SMSearchBar.swift
//  CustomSearchBar
//
//  Created by Siroson Mathuranga Sivarajah on 16/10/15.
//  Copyright © 2015 Siroson Mathuranga Sivarajah. All rights reserved.
//

typealias SMSearchBarCompletionBlock = (String?, Bool) -> ()

import UIKit

class SMSearchBar: UIView, UITextFieldDelegate {
    
    var completionBlock: SMSearchBarCompletionBlock!
    
    var preferredPlaceHolder: String? = ""
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    
    var parentView: UIView!
    var txtSearchField: UITextField!
    var btnCancel: UIButton!
    
    var hideCancelButton = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, font: UIFont, textColor: UIColor, placeHolder: String?, showCancelButton: Bool, parentView: UIView, completionHandler: SMSearchBarCompletionBlock) {
        super.init(frame: frame)
        
        ////
        self.frame = frame
        self.parentView = parentView
        self.preferredFont = font
        self.preferredTextColor = textColor
        self.preferredPlaceHolder = placeHolder
        self.completionBlock = completionHandler
        self.hideCancelButton = !showCancelButton
        
        ////
        self.addTextField()
        self.addCancelButton()
    }
    
    func addCancelButton() {
        btnCancel = UIButton(frame: CGRect(x: self.frame.size.width-75, y: 4, width: 60, height: self.frame.size.height-8))
        btnCancel.setTitle("Cancel", forState: .Normal)
        btnCancel.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        btnCancel.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        btnCancel.addTarget(self, action: "btnCancelAction", forControlEvents: .TouchUpInside)
        btnCancel.layer.cornerRadius = 5.0
        self.addSubview(btnCancel)
        btnCancel.hidden = self.hideCancelButton
    }
    
    func addTextField() {
        self.txtSearchField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width-70, height: self.frame.size.height))
        self.txtSearchField.delegate = self
        self.txtSearchField.placeholder = self.preferredPlaceHolder
        self.txtSearchField.textColor = self.preferredTextColor
        self.txtSearchField.font = self.preferredFont
        self.txtSearchField.autocapitalizationType = .None
        self.txtSearchField.autocorrectionType = .No
        self.txtSearchField.enablesReturnKeyAutomatically = true
        self.setPadding(self.txtSearchField)
        self.addSubview(self.txtSearchField)
        self.txtSearchField.becomeFirstResponder()
    }
    
    // MARK: - Button Actions
    func btnCancelAction() {
        self.txtSearchField.resignFirstResponder()
        self.completionBlock(nil, true)
    }
    
    // MARK: - Textfield Delegates
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == self.txtSearchField {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            self.completionBlock(newString, false)
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.txtSearchField {
            textField.textAlignment = .Left
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == self.txtSearchField {
            
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.txtSearchField {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // MARK: - Textfield Padding
    func setPadding(txtField:UITextField) {
        let view = UIView(frame: CGRectMake(0, 0, 20, 20))
        txtField.leftViewMode = UITextFieldViewMode.Always
        txtField.leftView = view
    }
}
