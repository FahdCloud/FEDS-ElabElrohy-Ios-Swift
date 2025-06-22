//
//  KnownMethodView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 10/10/2023.
//

import SwiftUI

struct KnownMethodView: View {
    @StateObject var knowMethodVm : KnowMethodVm = KnowMethodVm()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ZStack {
                if knowMethodVm.noData {
                    NoContent(message: knowMethodVm.msg)
                } else {
                    List {
                        ForEach(knowMethodVm.knowMethod,id: \.knownMethodToken) { method in
                            HStack (spacing: 10){
                                CustomImageUrl(url: method.knownMethodImageURL ?? "")
                                
                                Text(method.knownMethodNameCurrent ?? "")
                                Spacer()
                            }
                            .onTapGesture {
                                
                                UserDefaultss().saveStrings(value: method.knownMethodToken ?? "", key: "userProviderToken")
                                UserDefaultss().saveStrings(value: method.knownMethodNameCurrent ?? "", key: "knownMethodNameCurrent")
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding()
                        }
                        .listStyle(.insetGrouped)
                    }
                }
                
                if knowMethodVm.isLoading {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                }
            }
        }
        .onAppear {
            knowMethodVm.getKnownMethod(authToken: self.authToken)
        }
    }
}

struct KnownMethodView_Previews: PreviewProvider {
    static var previews: some View {
        KnownMethodView()
    }
}
