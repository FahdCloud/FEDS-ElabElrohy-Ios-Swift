//
//  FamilyView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/11/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct FamilyView: View {
    @StateObject var childrenVm : ChildrenVm = ChildrenVm()

    @State private var showApp : Bool = false
    @State private var backFromFamily : Bool = false
    @State private var dissapearView : Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            
            Color(Helper.hexStringToUIColor(hex: "#F5F5F5"))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack{
                    Text(NSLocalizedString("family", comment: ""))
                        .font(
                            Font.custom("Cairo", size: 30)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0.26, green: 0.25, blue: 0.69))
                    
                }
                .frame(alignment: .top)
                
                ZStack {
                    HStack(alignment: .center, spacing: 0) {
                        VStack {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(childrenVm.childrenData , id: \.userInfoData?.userToken) { childreen in
                                        ChildrenCardView(children:childreen)
                                            .onTapGesture {
                                                UserDefaultss().saveStrings(value: childreen.userInfoData?.userToken ?? "", key: "userToken")
                                                UserDefaultss().saveStrings(value: childreen.userInfoData?.userNameCurrent ?? "", key: "userNameCurrent")
                                                UserDefaultss().saveStrings(value: childreen.userInfoData?.userImageUrl ?? "", key: "userImageUrl")
                                                clearStatesWithAction(valueState: &showApp)
                                            }
                                    }
                                }
                                .padding()
                            }
                          
                        }
                    }
                    .padding()
                    .frame(width: 450, height: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(29)
                    .fullScreenCover(isPresented: $showApp, content: {
                        StudentMainTabView()
                    })
                }
            }
        }
        .onAppear(perform: {
            childrenVm.getdata()
        })
        .refreshable {
            childrenVm.getdata()
        }
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &dissapearView)
        })
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was towards the left
                    if value.translation.width < 0 {
                        // Perform your action here
                        self.backFromFamily.toggle()
                    }else if value.translation.width > 0 {
                        self.backFromFamily.toggle()
                    }
                }
        )
        .fullScreenCover(isPresented: $backFromFamily, content: {
            MoreView()
        })
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromFamily = false
        showApp = false
    }
}
