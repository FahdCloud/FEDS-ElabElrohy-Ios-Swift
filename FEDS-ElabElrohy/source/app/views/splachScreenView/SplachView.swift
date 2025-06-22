//
//  SplachScreen.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/07/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct SplachView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var calendarManager = StudentHomeScheduleCalenderView()
    
    @State var animated : Bool = false
    @State private var isAnimating = false
    @State private var zoomed = false
    @State private var rotationAngle: Double = 180.0
    @State private var showRegistrtionFromSplash : Bool = false
    @State private var showStudentMainFromSplash : Bool = false
    @State private var showFamilyFromSplash : Bool = false
    @State private var showDecFromSplash : Bool = false
    @State private var displayedText = ""
    @State private var fullText = NSLocalizedString("copyRight", comment: "")
    @State private var currentIndex = 0
    @State private var timer: Timer?
    @State private var toast: Toast? = nil
    
    let rememberMe : Bool = UserDefaultss().restoreBool(key: "rememberMe")
    var userTypeToken = UserDefaultss().restoreString(key: "userTypeToken")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    var userAuth = UserDefaultss().restoreString(key: "userAuth")
    
    var body: some View {
        ZStack {
            background
            
            _body
        }
    }
}

//MARK: - Variables
@available(iOS 16.0, *)
extension SplachView {
    
    var background : some View {
        VStack {
            Image("backgroun-Splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    var _body : some View {
        VStack {
            if animated {
                Image(genralVm.constants.PROJECT_LOGO)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                    .offset(y: 200) // Initial position (above the screen)
                    .transition(.move(edge: .top))
                    .animation(.easeIn)
            }
            
            HStack {
                GeometryReader { geometry in
                    HStack{
                        Image("icon_splash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: zoomed ? 100 : 50 , height: zoomed ? 100 : 50)
                        //   .scaleEffect(zoomed ? 0 : 1.0)
                            .rotationEffect(.degrees(rotationAngle))
                            .animation(.easeInOut(duration: 1.0)) // Adjust duration as needed
                            .onAppear {
                                withAnimation {
                                    rotationAngle += 180
                                }
                                
                                // Delay the rotation animation by 1 second
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation {
                                        zoomed.toggle()  // Rotate the image by 45 degrees
                                    }
                                }
                                
                                // Delay the zoom out animation by 2 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    withAnimation {
                                        zoomed.toggle()
                                    }
                                }
                            }
                        ZStack{
                            Text(NSLocalizedString("welcome", comment: ""))
                                .background(Color(Colors().whiteColorWithTrans))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 26)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black.opacity(0.9))
                        }
                        .animation(isAnimating ? Animation.easeInOut(duration: 1.0) : .none)
                        .opacity(isAnimating ? 1.0 : 0.0)
                    }
                }
                .offset(x: 100,y: 300)
            }
            
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        animated = true
                    }
                }
            }
            .overlay(
                Text(displayedText)
                    .background(Color(Colors().whiteColorWithTrans))
                    .multilineTextAlignment(.center)
                    .font(Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                    .foregroundColor(.black.opacity(0.9))
                    .padding()
                    .frame(maxHeight: .infinity,alignment: .bottom)
                
                ,alignment: .center
            )
            .onDisappear{
                UserDefaultss().removeObject(forKey: "selectedTag")
                clearStatesWithAction(state: &genralVm.dissapearView)

            }
            
            
        }
        .onAppear {
            startTyping()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isAnimating = true
                }
            }
            //            UserDefaultss().removeObject(forKey: "selectedTag")
        }
        .fullScreenCover(isPresented: $showRegistrtionFromSplash, content: {
            RegistrationView()
        })
        .fullScreenCover(isPresented: $showDecFromSplash, content: {
            DeclarationView()
                .preferredColorScheme(genralVm.isDark ? .dark : .light)
        })
        .fullScreenCover(isPresented: $showStudentMainFromSplash, content: {
            StudentMainTabView()
                .environmentObject(calendarManager)
                .preferredColorScheme(genralVm.isDark ? .dark : .light)
        })
        .fullScreenCover(isPresented: $showFamilyFromSplash, content: {
            FamilyView()
                .environmentObject(calendarManager)
                .preferredColorScheme(genralVm.isDark ? .dark : .light)
        })
    }
    
    func startTyping() {
        currentIndex = 0
        displayedText = ""
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.0677, repeats: true) { _ in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText.append(fullText[index])
                currentIndex += 1
            } else {
                timer?.invalidate()
                
                if (rememberMe && !userToken.isEmpty && !userAuth.isEmpty){
                    if genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY {
                        clearStatesWithAction(state: &showFamilyFromSplash)
                        
                    } else {
                        if  genralVm.declarationAccepted{
                            clearStatesWithAction(state: &showStudentMainFromSplash)
                        }else{
                            clearStatesWithAction(state: &showDecFromSplash)
                            
                        }
                    }
                }else{
                    clearStatesWithAction(state: &showRegistrtionFromSplash)
                }
            }
        }
    }
    
    private func clearStatesWithAction (state : inout Bool){
        state.toggle()
        UserDefaultss().removeObject(forKey: "selectedTag")
        showDecFromSplash = false
        showFamilyFromSplash = false
        showRegistrtionFromSplash = false
        showStudentMainFromSplash = false
    }
}
