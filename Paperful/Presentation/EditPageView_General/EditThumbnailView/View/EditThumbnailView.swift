import SwiftUI
import Foundation
import Mantis

struct EditThumbnailView: View {
    
    // MARK: - global Data
    @EnvironmentObject var globalData: GlobalData
    
    // MARK: - VM
    @ObservedObject var editThumbnailViewModel: EditThumbnailViewModel = .init()
    
    // MARK: - enter_string and placeholder
    @State private var enter_intro: String = ""
    @State private var placeholder_intro: String = "소개글을 작성해주세요."
    
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
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    ZStack {
                        VStack {
                            Rectangle()
                                .fill(Color.backgroundColor)
                                .frame(minWidth: 0, idealWidth: 350, maxWidth: .infinity, minHeight: 0, idealHeight: 350, maxHeight: .infinity, alignment: .center)
                                .border(Color.borderColor)
                                .padding(.horizontal, 8)
                        }
                        VStack (spacing: 8) {
                            VStack (spacing: 8){
                                //title
                                Text(globalData.editContent.title)
                                    .font(.title2)
                                    .lineLimit(1)
                                
                                VStack {
                                    Rectangle()
                                        .frame(height: 1, alignment: .center)
                                    
                                    ZStack {
                                        if self.checkChange == false {
                                            Text("이곳을 클릭해서 사진을 추가해주세요.")
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                                .frame(minWidth: 320, idealWidth: 320, maxWidth: .infinity, minHeight: 180, idealHeight: 180, maxHeight: .infinity, alignment: .center)
                                                .border(Color.gray)
                                        }

                                        Image(uiImage: self.image!)
                                            .resizable()
                                            .frame(minWidth: 320, idealWidth: 320, maxWidth: .infinity, minHeight: 180, idealHeight: 180, maxHeight: .infinity, alignment: .center)
                                            .onTapGesture {
                                                self.reset()
                                                presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 16.0 / 9.0)
                                                isShowing = true
                                            }
                                            .onChange(of: self.image, perform: { _ in
                                                self.checkChange = true
                                                self.isCrop.toggle()
                                                globalData.editContent.thumbnailData = self.image?.jpegData(compressionQuality: 1)
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
                                    .padding(.vertical, 8)
                                    
                                    HStack {
                                        Spacer()
                                        //writer nickname
                                        Text(globalData.currentUserProfile.nickname)
                                            .font(.subheadline)
                                            .bold()
                                            .lineLimit(1)
                                    }
                                    
                                    Rectangle()
                                        .frame(height: 1, alignment: .center)
                                }
                            }
                            
                            // 인트로 작성 텍스트에디터
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
                            
                            if self.checkOverText == true {
                                Text("너무 긴 소개글은 썸네일 화면에서 전체가 반영되지 않을 수 있습니다.")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .padding(32)
                    }
                }
            }
        }
        Spacer()
    }
    
    func reset() {
        cropShapeType = .rect
        presetFixedRatioType = .canUseMultiplePresetFixedRatio()
    }
}

//struct EditThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditThumbnailView()
//    }
//}
