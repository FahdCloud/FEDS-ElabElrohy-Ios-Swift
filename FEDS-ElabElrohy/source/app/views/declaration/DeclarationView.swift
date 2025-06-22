import SwiftUI

@available(iOS 16.0, *)
struct DeclarationView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var declarationP1 :String = ""
    @State private var showStudentMainFromDec :Bool = false
    @State private var showFamilyFromDec :Bool = false
    @State private var showLoginFromDec :Bool = false
    @State private var showAZDialogAlert :Bool = false
    @State private var toast: Toast? = nil
    @State private var isChecked: Bool = false
    
    var userName = UserDefaultss().restoreString(key: "userNameCurrent")
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    .frame(height: 200) // Adjust height as needed
                    .edgesIgnoringSafeArea(.top)
                    .cornerRadius(40, corners: [.allCorners])
                
                
                Text(NSLocalizedString("declaration", comment: ""))
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 30).weight(.bold))
                    .foregroundColor(Color.white)
                    .padding(.top, 44)
                
                VStack {
                    Spacer()
                    CircleImage(logo: Constants().PROJECT_LOGO
                                , width: 100
                                , height: 100
                                , bgColor: genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg)
                                , offestY: -40)
                }
                .frame(height: 250) // Adjust this height so the image is half in and out of the purple area
            }
            
            // Main content
            VStack(spacing: 4){
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                      
                      
                        Text(declarationP1)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .font(Font.custom(Fonts().getFontLight(), size: 18))
                        .lineSpacing(5)
                        
                        Text(NSLocalizedString("declaration_p3", comment: ""))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            .font(Font.custom(Fonts().getFontLight(), size: 18))
                            .lineSpacing(5)

                        
                        Button(action: {
                            self.isChecked.toggle()
                        }) {
                            HStack(alignment: .center, spacing: 10) {
                                
                                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                                    .foregroundColor(isChecked ? .green : .gray)
                                Text(NSLocalizedString("msg_agree_the_declaration", comment: ""))
                                    .font(Font.custom(Fonts().getFontBold(), size: 18))
                                    .foregroundColor(isChecked ? .green : .red)
                                    .lineSpacing(3)
                                
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }.padding(.top, -50)
            
            // Bottom buttons
            HStack {
                ButtonAction(text: NSLocalizedString("logout", comment: ""), color: .red) {
                    if let bundleID = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                    }
                    // Clear URLCache
                    URLCache.shared.removeAllCachedResponses()
                    clearStatesWithAction(valueState: &showLoginFromDec)
                }
                
                ButtonAction(text:NSLocalizedString("home", comment: ""), color: .green) {
                    
                    
                    if isChecked {
                        if genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY {
                            clearStatesWithAction(valueState: &showFamilyFromDec)
                        } else {
                            clearStatesWithAction(valueState: &showStudentMainFromDec)
                        }
                        UserDefaultss().saveBool(value: true, key: "declarationAccepted")
                    }else{
                        showAZDialogAlert.toggle()
                    }
                }
            }
            .padding()
        }
        .ipad()
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ignoresSafeArea(.all)
        .background(AZDialogAlert(isPresented: $showAZDialogAlert,
                                  title: NSLocalizedString("alert", comment: ""),
                                  message: NSLocalizedString("msg_agree_declaration_toast", comment: ""),
                                  imageTop: "3d-lock"))
        .fullScreenCover(isPresented: $showStudentMainFromDec, content: {
            StudentMainTabView()
        })
        .fullScreenCover(isPresented: $showLoginFromDec, content: {
            RegistrationView()
        })
        .fullScreenCover(isPresented: $showFamilyFromDec, content: {
            FamilyView()
        })
        .toastView(toast: $toast)
        .onAppear(perform: {
            if genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR  {
                declarationP1 = Helper.appendMultiStrings(words: "\(NSLocalizedString("declaration_p1", comment: ""))\(userName) \(NSLocalizedString("declaration_p2", comment: ""))")
                
            }else {
                declarationP1 = "\(NSLocalizedString("declaration_p1", comment: "")) \(userName) \(NSLocalizedString("declaration_p2", comment: ""))"
            }
        })
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromDec = false
        showFamilyFromDec = false
        showLoginFromDec = false
    }
}
