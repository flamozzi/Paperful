import SwiftUI

struct SelectFormView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var globalData: GlobalData
    
    @ObservedObject var selectFormViewModel: SelectFormViewModel = .init()
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("닫기")
    }
    }
    
    init() {
        self.selectFormViewModel.setFormList()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("글 유형 선택")
                                .font(.title)
                                .bold()
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                        
                        HStack {
                            Text("작성할 글에 맞는 폼을 선택하세요.")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                    
                    ScrollView {
                        VStack (spacing: -4){
                            ForEach(0..<self.selectFormViewModel.formViewList.count, id: \.self) { iterator in
                                if self.selectFormViewModel.formViewList[iterator].formViewModel.id == 1 {
                                    NavigationLink(
                                        destination: EditTitleView_General()
                                    ) {
                                        self.selectFormViewModel.formViewList[iterator]
                                    }
                                }
                                //                            else if self.selectFormViewModel.formViewList[iterator].formViewModel.id == 2 {
                                //                                NavigationLink(
                                //                                    destination: EditTitleView_General() // 바꿔야함
                                //                                ) {
                                //                                    self.selectFormViewModel.formViewList[iterator]
                                //                                }
                                //                            }
                                //                            else if self.selectFormViewModel.formViewList[iterator].formViewModel.id == 3 {
                                //                                NavigationLink(
                                //                                    destination: EditTitleView_General() // 바꿔야함
                                //                                ) {
                                //                                    self.selectFormViewModel.formViewList[iterator]
                                //                                }
                                //                            }
                            }
                        }
                    }
                    .onAppear {
                        globalData.resetEditContent()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    btnBack
                }
            }
        }
    }
}

//struct SelectFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectFormView()
//    }
//}
