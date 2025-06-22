//
//  TopViewCategoryVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 22/11/2023.
//

import SwiftUI


@available(iOS 16.0, *)
struct TopViewCategoryView: View {
    
    @StateObject var topListViewModel : TopViewCategoryVm = TopViewCategoryVm()
    @StateObject var educationalGroupsVm : EducationalGroupsVm = EducationalGroupsVm()
    @StateObject var teacherGroupsVm : TeacherGroupsVm = TeacherGroupsVm()
    var userProviderToken = UserDefaultss().restoreString(key: "userProviderToken")

    let row = GridItem(.fixed(50), spacing: 5, alignment: .center)
    @State private var selectedToken: String? = nil


    var body: some View {
     
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHGrid(rows: [row]) {
                ForEach(topListViewModel.userEducationalCategoryInfoInterest ,id: \.educationalCategoryToken) { top in
                    HStack {
                        
                        CustomImageUrl(url: top.educationalCategoryThumbnailImageUrl ?? "")
                       
                            .frame(width: 20)
                            .clipShape(Circle())
                        
                        Text("\(top.educationalCategoryFullNameCurrent ?? "")")
                            .foregroundColor(Color(red: 0.18, green: 0.16, blue: 0.62))
                       
                    }
                    .onTapGesture {
                        selectedToken = top.educationalCategoryToken ?? ""
                        teacherGroupsVm.categoryToken = selectedToken ?? ""
                        teacherGroupsVm.getAllTeachersGroups(userServiceProviderToken: self.userProviderToken,categoryToken:selectedToken ?? "")

                }
                    .padding()
                    .background(selectedToken == top.educationalCategoryToken ? Color.yellow : Color(red: 0.88, green: 0.87, blue: 1))
                    .cornerRadius(30)
                }
            }
            .onAppear {
                topListViewModel.getUserDetails(userToken: self.userProviderToken)
            }
            .refreshable{
                topListViewModel.getUserDetails(userToken: self.userProviderToken)
            }
        }
        .frame(height: 100)
        .padding()
    }
}

