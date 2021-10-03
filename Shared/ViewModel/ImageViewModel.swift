//
//  ImageViewModel.swift
//  Signal Messenger (iOS)
//
//  Created by Yuan on 03/10/2021.
//

import SwiftUI
import Photos

class ImagePickerViewModel: ObservableObject {
    
    @Published var showImagePicker: Bool = true
    @Published var library_status: LibraryStatus = LibraryStatus.denied
    @Published var fetchedPhotos: [Asset] = []
    
    func openImagePicker() -> Void {
        
        // Đóng bàn phím khi mở
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        withAnimation { 
            showImagePicker.toggle()
        }
        
    }
    
    func setUP() -> Void {
        
        // Hỏi quyên truy cập
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            
            DispatchQueue.main.async {
                switch status {
                    
                case .denied: self.library_status = .denied
                case .authorized: self.library_status = .approved
                case .limited: self.library_status = .limited
                default: self.library_status = .denied
                    
                }
            }
            
        }
        
    }
    
    func fetchPhotos() -> Void {
        
        // Fetching all photo
        let option = PHFetchOptions()
        
        option.sortDescriptors = [
            
            NSSortDescriptor(key: "creationDate", ascending: false)
            
        ]
        
        option.includeHiddenAssets = false
        
        let fetchRequest = PHAsset.fetchAssets(with: option)
        
        fetchRequest.enumerateObjects { [self] asset, index, _ in
            
            // getting image
            getImage(asset: asset) { image in
                // appen image
                fetchedPhotos.append(Asset(asset: asset, image: image))
            }
            
        }
        
    }
    
    func getImage(asset: PHAsset, completion: @escaping (UIImage) -> ()) -> Void {
        
        // To caching image
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .highQualityFormat
        imageOptions.isSynchronous = false
        
        
        let size = CGSize(width: 150, height: 150)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions) { image, _ in
            
            guard let resizedImage = image else { return }
            completion(resizedImage)
            
        }
        
    }
    
}
