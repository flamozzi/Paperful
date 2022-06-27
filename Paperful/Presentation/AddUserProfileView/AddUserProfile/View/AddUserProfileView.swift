import SwiftUI
import Combine
import Foundation
import Mantis

struct AddUserProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - global Data
    @EnvironmentObject var globalData: GlobalData
    
    // MARK: - VM
    @ObservedObject var addUserProfileViewModel: AddUserProfileViewModel = .init()
    
    // MARK: - enter_string and placeholder
    @State private var enter_nickname: String = ""
    @State private var placeholder_nickname: String = "이름을 작성해주세요. (최대 16자, 필수)"
    
    @State private var enter_intro: String = ""
    @State private var placeholder_intro: String = "소개글을 작성해주세요. (선택)"

    // MARK: - for implementing text on the image
    @State private var checkOverText: Bool = false

    // MARK: - for Image Picker and Cropper
    @State private var image: UIImage? = .init()
    @State private var isShowing = false
    @State private var isCrop = false

    // MARK: - 1:1 rec ratio
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .canUseMultiplePresetFixedRatio()

    // MARK: - image change checker
    @State var checkChange: Bool = false
    
    // MARK: - Max Character Length of Nickname
    let maxCharacterLength = Int(16)
    
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("뒤로")
    }
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 32) {
                    VStack (spacing: 4){
                        HStack {
                            Text("신규 프로필 생성")
                                .font(.title)
                                .bold()
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        
                        HStack {
                            Text("프로필 이미지와 이름, 그리고 소개글을 입력해주세요.")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                    
                    // 이미지 Circle
                    ZStack {
                        if self.checkChange == false {
                            Text("이미지 추가 (선택)")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .bold()
                                .frame(minWidth: 0, idealWidth: 150, maxWidth: 158,
                                       minHeight: 0, idealHeight: 150, maxHeight: 158,
                                       alignment: .center)
                                .border(Color.gray)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black))
                        }

                        Image(uiImage: self.image!)
                            .resizable()
                            .frame(minWidth: 0, idealWidth: 150, maxWidth: 158,
                                   minHeight: 0, idealHeight: 150, maxHeight: 158,
                                   alignment: .center)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.reset()
                                presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1)
                                isShowing = true
                            }
                            .onChange(of: self.image, perform: { _ in
                                self.checkChange = true
                                self.isCrop.toggle()
                            })
                            .fullScreenCover(isPresented: $isShowing) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, isShowing: $isShowing)
                            }
                            .fullScreenCover(isPresented: $isCrop) {
                                if self.checkChange == true {
                                    ImageCropper(theimage: $image, isShowing: $isShowing, isCrop: $isCrop ,cropShapeType: $cropShapeType, presetFixedRatioType: $presetFixedRatioType)
                                        .ignoresSafeArea()
                                }
                            }
                    }
                    
                    // 이름 입력칸
                    VStack {
                        TextField(placeholder_nickname, text: $enter_nickname)
                            .multilineTextAlignment(TextAlignment.center)
                            .onReceive(Just(enter_nickname), perform: { _ in
                                if maxCharacterLength < enter_nickname.count {
                                    enter_nickname = String(enter_nickname.prefix(maxCharacterLength))
                                }
                        })
                        
                        // 밑줄
                        Rectangle()
                             .frame(height: 1)
                    }
                    .padding(.horizontal, 56)
                    
                    // 소개글 입력칸
                    ZStack {
                        // placeholder
                        if self.enter_intro.isEmpty{
                            TextEditor(text: $placeholder_intro)
                                .font(.body)
                                .foregroundColor(.gray)
                                .disabled(true)
                                .padding()
                        }
                        TextEditor(text: $enter_intro)
                            .padding()
                            .font(.body)
                            .opacity(self.enter_intro.isEmpty ? 0.25 : 1)
                            .disableAutocorrection(true)
                            .onChange(of: enter_intro, perform: { _ in
                                globalData.editContent.intro = self.enter_intro
                                if self.enter_intro.count > 64 {
                                    self.checkOverText = true
                                }
                                else {
                                    self.checkOverText = false
                                }
                            })
                        Text(enter_intro).opacity(0).padding(.all, 8)
                    }
                    .padding(.top, -8)
                
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                btnBack
                    .foregroundColor(Color.black)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if self.enter_nickname != "" && self.enter_nickname.trimmingCharacters(in: .whitespaces) != "" {
                    Text("생성")
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            self.addUserProfileViewModel.postNewUserProfile(nickname: self.enter_nickname, image: self.image?.jpegData(compressionQuality: 1), intro: self.enter_intro, globalData: globalData)
                            
                            globalData.currentUserProfile.image = self.image?.toJpegString(compressionQuality: 1)
                            globalData.currentUserProfile.intro = self.enter_intro
                            globalData.currentUserProfile.nickname = self.enter_nickname
                            globalData.currentUserProfile.num_subscribers = 0
                            
                            globalData.isMember = true
                        }
                }
            }
        }
        // navigation bar 공백 없애기 위해 inline style의 공백 명시
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func reset() {
        cropShapeType = .rect
        presetFixedRatioType = .canUseMultiplePresetFixedRatio()
    }
}

struct AddUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserProfileView()
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
