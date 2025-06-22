//
//  FilterView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 12/10/2023.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject var filterViewModel : FilterVieModel = FilterVieModel()
    @StateObject var joiningApplicationVm : JoiningApplicationVm = JoiningApplicationVm()
    let rows = GridItem(.fixed(50), spacing: 5, alignment: .center)
    @State private var selectedRow: String?


    var body: some View {
        
        VStack {
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHGrid(rows: [rows]) {
                    ForEach(filterViewModel.filterData) { top in
                        HStack {
                            Image(top.image)
                                .resizable()
                                .frame(width: 20,height: 20)
                                .clipShape(Circle())
                            
                            
                            Text("\(top.name)")
                                .foregroundColor(Color(red: 0.18, green: 0.16, blue: 0.62))
                            
                        }
                        .background(top.token == selectedRow! ? Color(Colors().mainColor) : Color(red: 0.88, green: 0.87, blue: 1))
                        .onTapGesture {
                            selectedRow = top.token
                            joiningApplicationVm.approvalToken = top.token
                            joiningApplicationVm.getEducationJoiningApplication()
                        }
                        .padding()
                        .cornerRadius(30)
                        
                    }
                }
            }
            .padding()
        }
        .frame(width: .infinity, height: 66, alignment: .top)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
