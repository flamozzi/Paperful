import Foundation
import SwiftUI
import Mantis

struct ImageCropper: UIViewControllerRepresentable {
    typealias Coordinator = ImageCropperCoordinator
    
    @Binding var theimage: UIImage?
    @Binding var isShowing: Bool
    @Binding var isCrop: Bool
    
    // 형태 고정
    @Binding var cropShapeType: Mantis.CropShapeType
    @Binding var presetFixedRatioType: Mantis.PresetFixedRatioType
    
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> ImageCropperCoordinator {
        return ImageCropperCoordinator(image: $theimage, isShowing: $isShowing, isCrop: $isCrop, self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageCropper>) -> Mantis.CropViewController {
        var config = Mantis.Config()
        config.cropShapeType = cropShapeType
        config.presetFixedRatioType = presetFixedRatioType
        
        let Cropper = Mantis.cropViewController(image: theimage!, config: config)
        
        Cropper.delegate = context.coordinator
        return Cropper
    }
}

class ImageCropperCoordinator: NSObject, CropViewControllerDelegate {
    @Binding var theimage: UIImage?
    @Binding var isShowing: Bool
    @Binding var isCrop: Bool
    
    var parent: ImageCropper
    
    init(image: Binding<UIImage?>, isShowing: Binding<Bool>, isCrop: Binding<Bool>, _ parent: ImageCropper) {
        self.parent = parent
        _theimage = image
        _isShowing = isShowing
        _isCrop = isCrop
    }
    
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        theimage = cropped
        // EditThumbnailView 에의 onChanged를 통해 toggle로 isCrop을 바꾸기 때문에 여기서는 isCrop 조작하면 안됨
//        isCrop = false
    }
    
    func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
        
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        isCrop = false
    }
    
    func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
        
    }
    
    func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
        
    }
    
    
}
