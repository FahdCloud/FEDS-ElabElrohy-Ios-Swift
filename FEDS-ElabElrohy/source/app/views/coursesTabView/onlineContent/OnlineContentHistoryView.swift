//
//  OnlineContentHistoryView.swift
//  FEDS-Dev-1.1
//
//  Created by Omar Pakr on 19/09/2024.
//

import SwiftUI

struct OnlineContentHistoryView: View {
    @StateObject var educationCourseDetailsVm : EducationCourseDetailsVm = EducationCourseDetailsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack{
            ScrollView{
                if educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.educationalCourseStudentToken != nil {
                    if  educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.subscriptionIsValid ??  false == true {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image("book")
                                    .resizable()
                                    .frame(width: 15,height: 15)
                                    .foregroundStyle(.blue)
                                Text(educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.courseSubscriptionPlanNameCurrent ?? "")
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 15)
                                            .weight(.bold)
                                    )
                                    .foregroundStyle(.primary)
                            }
                            .padding(.top,10)
                            Divider()
                            
                            HStack {
                                HStack {
                                    Image("information-2")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .foregroundStyle(.blue)
                                    
                                    Text(NSLocalizedString("subscriptionStatus", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(.primary)
                                }
                                Spacer()
                                
                                Image(educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.subscriptionIsValid ?? false ? "right" : "rejected_icon")
                                    .resizable()
                                    .frame(width: 20,height: 20)
                                
                                
                            }
                            .padding(.bottom,10)
                            .padding(.top,10)
                            
                            Divider()
                            
                            HStack {
                                HStack{
                                    Image("event")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .foregroundStyle(.red)
                                    
                                    Text(NSLocalizedString("susbscriptionEnd", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(.primary)
                                }
                                
                                Spacer()
                                HStack {
                                    
                                    
                                    Text("\(educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.endSupscriptionRelativeTimeText ?? "")")
                                    
                                    if educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.courseSubscriptionTypeToken == genralVm.constants.countTimes {
                                        Text(NSLocalizedString("remaining", comment: ""))
                                        
                                        Text(educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.countRemainingOpenTime ?? 0 > 1 ? NSLocalizedString("times", comment: "") : NSLocalizedString("time", comment: "") )
                                        
                                    }
                                }
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 15)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.primary)
                            }
                            .padding(.bottom,10)
                            .padding(.top,10)
                            
                            Divider()
                            
                            VStack {
                                HStack {
                                    Image("award")
                                        .resizable()
                                        .frame(width: 15,height: 15)
                                        .foregroundStyle(.red)
                                    
                                    Text(NSLocalizedString("progressLevel", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    Text("\(educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.courseProgressPercentage ?? 0.0)" + "%")
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(.primary)
                                }
                                ProgressView(value: educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.courseProgressPercentage ?? 0.0, total: 100)
                                
                            }
                            .padding(.bottom,10)
                            .padding(.top,10)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.5), radius: 8, x: 0, y: 5)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack  {
                        HStack{
                            Image("subscriptions")
                                .resizable()
                                .frame(width: 35,height: 35)
                            
                            Text(NSLocalizedString("avaliableSubs", comment: ""))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 20)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                        
                        ForEach(0..<(educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?.count ?? 0), id: \.self) { index in
                            VStack {
                                if self.genralVm.lang == self.genralVm.constants.APP_LANGUAGE_AR {
                                    Text(" - " + (educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPlanNameAr ?? ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(.primary)
                                } else {
                                    Text(" - " + (educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPlanNameEn ?? ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundStyle(.primary)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        
                    }
                
                    
                }
                .padding()
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(color: colorScheme == .dark ? .white.opacity(0.3) : .black.opacity(0.5), radius: 8, x: 0, y: 5)          
            }
            
        }
        .onAppear(perform: {
            if let savedData = UserDefaults.standard.data(forKey: "educationalCourseInfoData") {
                do {
                    let decodedData = try JSONDecoder().decode(EducationalCourseInfoData.self, from: savedData)
                    educationCourseDetailsVm.educationalCourseData = decodedData
                   
                } catch {
                    print("Error decoding or encoding APIAppData:", error)
                }
            } else {
                print("No data found for key 'appData' in UserDefaults")
            }
            
        })
        
    }
}
