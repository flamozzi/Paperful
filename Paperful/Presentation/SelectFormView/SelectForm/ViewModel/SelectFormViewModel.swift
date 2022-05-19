import Foundation
import SwiftUI


class SelectFormViewModel: ObservableObject {
    @Published var formViewList: [FormView] = []
    
    func setFormList() {
        
        //MARK: - 기본 글쓰기 폼 (empty)
        let form_general = FormModel(
            image: "paperfulTestImage_1",
            title: "기본",
            intro: "제목과 내용으로 이루어진 심플한 기본적인 형태의 폼 입니다. 어떤 글이든 자유롭게 작성하세요.",
            id: 1
        )
        
        let formView_general: FormView = .init()
        
        formView_general.formViewModel.setForm(form: form_general)
        
        self.formViewList.append(formView_general)
        
        //MARK: - 글귀 및 시 (short_text)
        let form_short_text = FormModel(
            image: "paperfulTestImage_2",
            title: "글귀 및 시",
            intro: "글귀 및 시와 같은 짧은 글에 최적화된 글쓰기 폼 입니다. 가운데 정렬을 기본으로 하며, 명언을 적어두기에도 적합합니다.",
            id: 2
        )
        
        let formView_short_text: FormView = .init()
        
        formView_short_text.formViewModel.setForm(form: form_short_text)
        
        self.formViewList.append(formView_short_text)
        
        //MARK: - 일기 (diary)
        let form_diary = FormModel(
            image: "paperfulTestImage_3",
            title: "일기",
            intro: "일기에 최적화된 글쓰기 폼 입니다. 여러분의 소중한 하루를 빠짐없이 기록해보세요.",
            id: 3
        )
        
        let formView_diary: FormView = .init()
        
        formView_diary.formViewModel.setForm(form: form_diary)
        
        self.formViewList.append(formView_diary)
    }
}
