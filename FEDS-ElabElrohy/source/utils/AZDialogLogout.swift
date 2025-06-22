//
//  AZDialogLogout.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 03/04/2024.
//

import SwiftUI

import AZDialogView // Import the AZDialogView library

struct AZDialogLogout : UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    @Binding var isPresented: Bool
    @Binding var showLogout: Bool
    var dismissAzDialogActions: Bool = false
    var dismissAzDialogDirection: AZDialogDismissDirection = .none
    var title: String
    var message: String
    var imageTop: String
    
    var buttonClick: String = NSLocalizedString("logout", comment: "")
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Create a dummy UIViewController to host the dialog
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard isPresented else { return }
        
        let dialog = AZDialogViewController(title: title, message: message)
        // Configure your dialog here (e.g., add buttons, customize appearance)
        
        //set the title color
        dialog.titleColor = isDark ? Helper.convertColorToUIColor(swiftUIColor: Color(Colors().darkBodyText)) : Helper.convertColorToUIColor(swiftUIColor: Color(Colors().lightBodyText))
        
        //set the message color
        dialog.messageColor = isDark ? Helper.convertColorToUIColor(swiftUIColor: Color(Colors().darkBodyText)) : Helper.convertColorToUIColor(swiftUIColor: Color(Colors().lightBodyText))
        
        //set the dialog background color
        dialog.alertBackgroundColor =  isDark ? Helper.convertColorToUIColor(swiftUIColor: Color(Colors().darkBodyBg)) : Helper.convertColorToUIColor(swiftUIColor: Color(Colors().lightBodyBg))
        
        
        //set the gesture dismiss direction
        dialog.dismissDirection = dismissAzDialogDirection
        
        
        //allow dismiss by touching the background
        dialog.dismissWithOutsideTouch = dismissAzDialogActions
        
        //show seperator under the title
        dialog.showSeparator = true
        
        //set the seperator color
        dialog.separatorColor = UIColor.gray
        
        //enable/disable drag
        dialog.allowDragGesture = true
        
        //enable rubber (bounce) effect
        dialog.rubberEnabled = true
        
        //enable/disable backgroud blur
        dialog.blurBackground = true
        
        //set the background blur style
        dialog.blurEffectStyle = isDark ? .light : .dark
        
        
        //set dialog image
        dialog.imageHandler = { (imageView) in
            imageView.image = UIImage(named: imageTop)
            imageView.contentMode = .scaleAspectFill
            return true //must return true, otherwise image won't show.
        }
        
        dialog.buttonStyle = { (button,height,position) in
            if position == 0 {
                button.setTitleColor(UIColor.black, for: .normal)
                button.layer.masksToBounds = true
                button.layer.borderColor = UIColor.green.cgColor
                button.layer.backgroundColor = UIColor.green.cgColor
                
            }else{
                button.setTitleColor(UIColor.white, for: .normal)
                button.layer.masksToBounds = true
                button.layer.borderColor = UIColor.red.cgColor
                button.layer.backgroundColor = UIColor.red.cgColor
            }
            button.layer.shadowColor = UIColor.gray.cgColor
        }
        
        
        // Configure the dialog buttons and actions
        dialog.addAction(AZDialogAction(title: buttonClick, handler: { (dialog) -> (Void) in
            // Call the action provided for Button 1
                Helper.removeUserDefaultsAndCashes()
                dialog.dismiss()
                
        }))
         
        
        // Present the dialog
        uiViewController.present(dialog, animated: true, completion: {
            // This closure is called after the dialog is dismissed
            self.isPresented = false
        })
    }
        
}

