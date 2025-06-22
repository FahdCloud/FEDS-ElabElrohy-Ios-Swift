//
//  ProviderOfEducationCategory.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 09/10/2023.
//

import SwiftUI

struct ProviderOfEducationCategory: View {
    @StateObject var providerEducationCategoryVm: ProviderEducationCategoryViewModel = ProviderEducationCategoryViewModel()
    
    var educationCategoryToken : String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ZStack {
                if providerEducationCategoryVm.noData {
                    NoContent(message: providerEducationCategoryVm.msg)
                } else {
                    List {
                        ForEach(providerEducationCategoryVm.users,id: \.userToken) { user in
                            HStack (spacing: 10){
                                CustomImageUrl(url: user.userImageUrl ?? "")
                                
                                Text(user.userNameCurrent ?? "")
                                Spacer()
                            }
                            .onTapGesture {
                                
                                UserDefaultss().saveStrings(value: user.userToken ?? "", key: "userProviderToken")
                                UserDefaultss().saveStrings(value: user.userNameCurrent ?? "", key: "userProviderName")
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding()
                        }
                        .listStyle(.insetGrouped)
                    }
                }
                
                if providerEducationCategoryVm.isLoading {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                }
            }
        }
        .onAppear {
            providerEducationCategoryVm.getEducationCategoriesProvider(educationCategoryToken: self.educationCategoryToken)
        }
    }
}

struct ProviderOfEducationCategory_Previews: PreviewProvider {
    static var previews: some View {
        ProviderOfEducationCategory(educationCategoryToken: "")
    }
}
