//
//  AZDialogTittelAndMessage.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 26/03/2024.
//

import SwiftUI
import AZDialogView // Import the AZDialogView library

struct AZDialogAlert: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    @Binding var isPresented: Bool
    var title: String
    var message: String
    var imageTop: String
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
        dialog.dismissDirection = .both

        //allow dismiss by touching the background
        dialog.dismissWithOutsideTouch = true

        //show seperator under the title
        dialog.showSeparator = false

        //set the seperator color
        dialog.separatorColor = UIColor.gray

        //enable/disable drag
        dialog.allowDragGesture = true

        //enable rubber (bounce) effect
        dialog.rubberEnabled = true

        //set dialog image
        dialog.imageHandler = { (imageView) in
            imageView.image = UIImage(named: imageTop)
            imageView.contentMode = .scaleAspectFill
            return true //must return true, otherwise image won't show.
        }

        
        //enable/disable backgroud blur
        dialog.blurBackground = true

        //set the background blur style
        dialog.blurEffectStyle = isDark ? .light : .dark

        // Present the dialog
        uiViewController.present(dialog, animated: true, completion: {
            // This closure is called after the dialog is dismissed
            self.isPresented = false
        })
    }
}
