import SwiftUI
import Photos
import MobileCoreServices
import CountryPicker

@available(iOS 16.0, *)
struct SignUp: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var signUpViewModel : SignUpViewModel = SignUpViewModel()
    var constants = Constants()

    var body: some View {
        ZStack{
            background
            if signUpViewModel.showSignIn {
                LoginView()
            } else {
                VStack {
                    Spacer()
                    ZStack {
                        ScrollView(showsIndicators: false){
                            contentStack
                        }
                    }
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                    .background(Color.white)
                    .cornerRadius(40)
                    .edgesIgnoringSafeArea(.bottom)
                    .toastView(toast: $signUpViewModel.toast)
                    .onAppear {
                        self.signUpViewModel.selectedUserEducationSystemType = self.signUpViewModel.selectedEduSystemTypeOption
                        self.signUpViewModel.getConstantList()
                        self.signUpViewModel.getAcademicYears()
                        self.signUpViewModel.getGovernmentsData()
                        self.signUpViewModel.getCenterPlacesData()
                    }
                }
            }
            
          
            if signUpViewModel.showLoading {
                LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if abs(value.translation.width) > abs(value.translation.height) {
                        if value.translation.width < 0 {
                            signUpViewModel.clearStatesWithAction(valueState: &signUpViewModel.backFromSignup)
                        } else if value.translation.width > 0 {
                            signUpViewModel.clearStatesWithAction(valueState: &signUpViewModel.backFromSignup)
                        }
                    }
                }
        )
        .fullScreenCover(isPresented: $signUpViewModel.backFromSignup, content: {
            RegistrationView()
        })
        .onDisappear {
            signUpViewModel.clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
    }
    
    var background: some View {
        VStack {
            Image("backgroun-Splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    var contentStack : some View  {
        VStack {
            signUpForm
            signUpButton
            signInLink
        }
        .padding()
        .background(Color.white)
        .cornerRadius(40)
        .padding()
        
    }
    var signUpForm: some View {
        VStack(spacing: -10) {
            usernameField
            studentPhoneNum
            fatherPhoneNum
            motherPhoneNum
            if AppConstantStatus.isEducationSystem {
                eduSystemField
            }
            
            if !signUpViewModel.showMenuAcadmicYears  {
                AcadmicYearDropdownIfFailed
            }else{
                AcadmicYearDropdown
            }
            
            if !signUpViewModel.showMenuGovrnorate {
                governmentDropDownIfFailed
            }else{
                governmentDropDown
            }
            cityNameField
            schoolNameField
            emailField
            passwordField
        }
    }
    
    var imagePicker: some View {
        Image(uiImage: self.signUpViewModel.image)
            .resizable()
            .cornerRadius(50)
            .frame(width: 150, height: 150)
            .background(Image("avatar").resizable())
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .padding(8)
            .onTapGesture {
                signUpViewModel.showImagePicker.toggle()
            }
            .sheet(isPresented: $signUpViewModel.showImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$signUpViewModel.image)
            }
    }
    
    var usernameField: some View {
        TextField("", text: $signUpViewModel.user)
            .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("userName", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "auth_user_png", isPassword: false, isEditing: !self.signUpViewModel.user.isEmpty, isTapped: $signUpViewModel.showPassword))
            .padding()
    }
    
    var emailField: some View {
        TextField("", text: $signUpViewModel.email)
            .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("userEmail", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "general_email", isPassword: false, isEditing: !self.signUpViewModel.email.isEmpty, isTapped: $signUpViewModel.showPassword))
            .padding()
    }
    
    var studentPhoneNum: some View {
        HStack {
            HStack {
                Image(uiImage: signUpViewModel.countryClient.flag ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32.0, height: 32.0)
                Text("\(signUpViewModel.countryClient.dialingCode!)")
            }.onTapGesture {
                signUpViewModel.isShowingCountryPicker.toggle()
            }
            TextField("", text: $signUpViewModel.studentPhoneNum)
                .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("userPhone", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "phone", isPassword: false, isEditing: !self.signUpViewModel.studentPhoneNum.isEmpty, isTapped: $signUpViewModel.showPassword))
        }
        .sheet(isPresented: $signUpViewModel.isShowingCountryPicker) {
            CountryPickerViewProxy { choosenCountry in
                signUpViewModel.countryClient = choosenCountry
            }
        }
        .padding()
    }
    var fatherPhoneNum: some View {
        HStack {
            HStack {
                Image(uiImage: signUpViewModel.countryFather.flag ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32.0, height: 32.0)
                Text("\(signUpViewModel.countryFather.dialingCode!)")
            }.onTapGesture {
                signUpViewModel.isShowingCountryPickerFather.toggle()
            }
            TextField("", text: $signUpViewModel.fatherPhoneNum)
                .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("fatherPhoneNum", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "phone", isPassword: false, isEditing: !self.signUpViewModel.fatherPhoneNum.isEmpty, isTapped: $signUpViewModel.showPassword))
        }
        .sheet(isPresented: $signUpViewModel.isShowingCountryPickerFather) {
            CountryPickerViewProxy { choosenCountry in
                signUpViewModel.countryFather = choosenCountry
            }
        }
        .padding()
    }
    
    var motherPhoneNum: some View {
        HStack {
            HStack {
                Image(uiImage: signUpViewModel.countryMother.flag ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32.0, height: 32.0)
                Text("\(signUpViewModel.countryMother.dialingCode!)")
            }.onTapGesture {
                signUpViewModel.isShowingCountryPickerMother.toggle()
            }
            TextField("", text: $signUpViewModel.motherPhoneNum)
                .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("motherPhoneNum", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "phone", isPassword: false, isEditing: !self.signUpViewModel.motherPhoneNum.isEmpty, isTapped: $signUpViewModel.showPassword))
        }
        .sheet(isPresented: $signUpViewModel.isShowingCountryPickerMother) {
            CountryPickerViewProxy { choosenCountry in
                signUpViewModel.countryMother = choosenCountry
            }
        }
        .padding()
    }
    
    //    var genderPicker: some View {
    //        Picker(selection: $signUpViewModel.selectedGender, label: Text(NSLocalizedString("selectGender", comment: ""))) {
    //            Text(NSLocalizedString("male", comment: "")).tag(1)
    //            Text(NSLocalizedString("female", comment: "")).tag(2)
    //        }
    //        .pickerStyle(.automatic)
    //    }
    
    var passwordField: some View {
        Group {
            if signUpViewModel.showPassword {
                TextField("", text: $signUpViewModel.password)
            } else {
                SecureField("", text: $signUpViewModel.password)
            }
        }
        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("userPasswordFiled", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "auth_password_png", isPassword: true, isEditing: !self.signUpViewModel.password.isEmpty, isTapped: $signUpViewModel.showPassword))
        .padding()
    }
    
    var signUpButton: some View {
        HStack(alignment: .center, spacing: 5) {
            Button {
                signUpViewModel.getFiledsData()
            } label: {
                Text(NSLocalizedString("signUpBtn", comment: ""))
                    .frame(width: 234, height: 58)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 24)
                            .weight(.bold)
                        
                    )
                    .foregroundColor(Color(red: 0.9, green: 0.88, blue: 0.91))
            }
            .frame(width: 234, height: 58, alignment: .center)
            .fullScreenCover(isPresented: $signUpViewModel.showDecFromSignup, content: {
                DeclarationView()
            })
            
        }
        
        .padding(.horizontal, 82)
        .padding(.vertical, 16)
        .frame(width: 234, height: 58, alignment: .center)
        .background(Color(Colors().mainButtonColor.cgColor))
        .cornerRadius(10)
    }
    
    var signInLink: some View {
        HStack(spacing: 6){
            Text(NSLocalizedString("alreadyHaveAccount", comment: ""))
                .font(
                    Font.custom(Fonts().getFontLight(), size: 20)
                        .weight(.light)
                )
                .foregroundColor(.black.opacity(0.6))
            
            Button {
                withAnimation(Animation
                    .default
                ) {
                    signUpViewModel.showSignIn.toggle()
                }
            } label: {
                Text(NSLocalizedString("signIn", comment: ""))
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 20)
                            .weight(.bold)
                    )
            }
        }
    }
    
    var eduSystemField: some View {
        
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                CustomRadioButton(text: NSLocalizedString("online", comment: ""), isSelected: self.signUpViewModel.selectedEduSystemTypeOption == self.genralVm.constants.EDUCATION_SYSTEM_TYPE_ONLINE) {
                    withAnimation {
                        self.signUpViewModel.selectedEduSystemTypeOption = self.genralVm.constants.EDUCATION_SYSTEM_TYPE_ONLINE
                        self.signUpViewModel.selectedUserEducationSystemType = self.genralVm.constants.EDUCATION_SYSTEM_TYPE_ONLINE
                    }
                }
                CustomRadioButton(text: NSLocalizedString("center", comment: ""), isSelected: self.signUpViewModel.selectedEduSystemTypeOption == self.genralVm.constants.EDUCATION_SYSTEM_TYPE_CENTER) {
                    withAnimation {
                        self.signUpViewModel.selectedEduSystemTypeOption = self.genralVm.constants.EDUCATION_SYSTEM_TYPE_CENTER
                        self.signUpViewModel.selectedUserEducationSystemType = self.genralVm.constants.EDUCATION_SYSTEM_TYPE_CENTER
                    }
                }
            }
            .padding()
            
            if self.signUpViewModel.selectedEduSystemTypeOption == self.genralVm.constants.EDUCATION_SYSTEM_TYPE_CENTER {
                if !signUpViewModel.showMenuCenters {
                    eduSystemDropdownIfFailed
                }else{
                    eduSystemDropdown
                }
            }
            
            Spacer()
        }
        .padding()
    }

    var eduSystemDropdownIfFailed: some View {
        VStack {
                Button {
                    self.signUpViewModel.showLoading = true
                    self.signUpViewModel.getCenterPlacesData()
            } label: {
                HStack {
                    TextField("", text: $signUpViewModel.selectedPlaceName)
                        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("centerName", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "centerIcon", isPassword: false, isEditing: !self.signUpViewModel.selectedPlaceName.isEmpty, isTapped: $signUpViewModel.showPassword))
                        .disabled(true)
                    
                    Spacer()

                    Image("refreshIcon")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 8)
                }
            }
        }
    }
    

    var eduSystemDropdown: some View {
        VStack {
            Menu {
                ForEach(signUpViewModel.centerPlacesDataList, id: \.itemToken) { center in
                    Button(action: {
                        signUpViewModel.selectedPlaceToken = center.itemToken ?? ""
                        self.signUpViewModel.selectedPlaceName = self.genralVm.lang == self.genralVm.constants.APP_IOS_LANGUAGE_AR ? (center.itemNameAr ?? "") : (center.itemNameEn ?? "")
                    }) {
                        Text(self.genralVm.lang == self.genralVm.constants.APP_IOS_LANGUAGE_AR ? (center.itemNameAr ?? "") : (center.itemNameEn ?? ""))
                    }
                }
            }  label: {
                HStack {
                    TextField("", text: $signUpViewModel.selectedPlaceName)
                        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("centerName", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "centerIcon", isPassword: false, isEditing: !self.signUpViewModel.selectedPlaceName.isEmpty, isTapped: $signUpViewModel.showPassword))
                        .disabled(true)
                    
                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
    }

    
    var AcadmicYearDropdownIfFailed: some View {
        VStack {
                Button {
                    self.signUpViewModel.showLoading = true
                    self.signUpViewModel.getAcademicYears()
            } label: {
                HStack {
                    TextField("", text: self.$signUpViewModel.selectedAcadmicYearName)
                        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("academicYear", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "acadmicIcon", isPassword: false, isEditing: !self.signUpViewModel.selectedAcadmicYearName.isEmpty, isTapped: $signUpViewModel.showPassword))
                        .disabled(true)
                    
                    Spacer()

                    Image("refreshIcon")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding()
    }
    var AcadmicYearDropdown: some View {
        VStack {
            Menu {
                ForEach(signUpViewModel.academicYearsDataList, id: \.itemToken) { acadimcYear in
                    Button(action: {
                        self.signUpViewModel.selectedAcadmicYearToken = acadimcYear.itemToken ?? ""
                        self.signUpViewModel.selectedAcadmicYearName = self.genralVm.lang == self.genralVm.constants.APP_IOS_LANGUAGE_AR ? (acadimcYear.itemNameAr ?? "") : (acadimcYear.itemNameEn ?? "")
                    }) {
                        Text(self.genralVm.lang == self.genralVm.constants.APP_IOS_LANGUAGE_AR ? (acadimcYear.itemNameAr ?? "") : (acadimcYear.itemNameEn ?? ""))
                    }
                }
            } label: {
                HStack {
                    TextField("", text: self.$signUpViewModel.selectedAcadmicYearName)
                        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("academicYear", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "acadmicIcon", isPassword: false, isEditing: !self.signUpViewModel.selectedAcadmicYearName.isEmpty, isTapped: $signUpViewModel.showPassword))
                        .disabled(true)
                    
                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding()
    }
    
    var governmentDropDown: some View {
        VStack {
            Menu {
                ForEach(signUpViewModel.governmentsDataList, id: \.itemToken) { government in
                    Button(action: {
                        self.signUpViewModel.selectedGovenmentToken = government.itemToken ?? ""
                        self.signUpViewModel.selectedGovenmentName = self.genralVm.lang == self.genralVm.constants.APP_IOS_LANGUAGE_AR ? (government.itemNameAr ?? "") : (government.itemNameEn ?? "")
                    }) {
                        Text(self.genralVm.lang == self.genralVm.constants.APP_IOS_LANGUAGE_AR ? (government.itemNameAr ?? "") : (government.itemNameEn ?? ""))

                    }
                }
            } label: {
                HStack {
                    TextField("", text: self.$signUpViewModel.selectedGovenmentName)
                        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("selectGov", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "governmentIcon", isPassword: false, isEditing: !self.signUpViewModel.selectedGovenmentName.isEmpty, isTapped: $signUpViewModel.showPassword))
                        .disabled(true)
                    
                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding()
    }
    
    var governmentDropDownIfFailed: some View {
        VStack {
                Button {
                        self.signUpViewModel.showLoading = true
                        self.signUpViewModel.getConstantList()
            } label: {
                HStack {
                    TextField("", text: self.$signUpViewModel.selectedGovenmentName)
                        .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("selectGov", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "governmentIcon", isPassword: false, isEditing: !self.signUpViewModel.selectedGovenmentName.isEmpty, isTapped: $signUpViewModel.showPassword))
                        .disabled(true)
                    
                    Spacer()

                    Image("refreshIcon")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding()
    }

        
    
    var cityNameField: some View {
        TextField("", text: $signUpViewModel.city)
            .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("city", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "cityIcon", isPassword: false, isEditing: !self.signUpViewModel.city.isEmpty, isTapped: $signUpViewModel.showPassword))
            .padding()
    }
    
    var schoolNameField: some View {
        TextField("", text: $signUpViewModel.school)
            .textFieldStyle(CustomTextFieldStyle(placeholder: NSLocalizedString("school", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "schoolIcon", isPassword: false, isEditing: !self.signUpViewModel.school.isEmpty, isTapped: $signUpViewModel.showPassword))
            .padding()
    }
}


struct CountryPickerViewProxy: UIViewControllerRepresentable {
    
    let onSelect: (( _ chosenCountry: Country) -> Void)?
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: CountryPickerController.create {
            onSelect?($0)}
        )
    }
}
