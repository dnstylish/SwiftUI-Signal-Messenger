//
//  Home.swift
//  Signal Messenger (iOS)
//
//  Created by Yuan on 03/10/2021.
//

import SwiftUI

struct Home: View {
    
    @State var message: String = ""
    @StateObject var imagePicker: ImagePickerViewModel = ImagePickerViewModel()
    
    var body: some View {
        
        NavigationView {
            
            // Sample Signal Chap View
            
            VStack {
                
                ScrollView {
                    
                    
                }
                
                VStack {
                    HStack(spacing: 15) {
                        
                        Button(action: imagePicker.openImagePicker) {
                            Image(systemName: imagePicker.showImagePicker ? "xmark" : "plus")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        TextField("New Message", text: $message, onEditingChanged: { opened in
                            // đóng image picker khi mở bàn phím
                            if opened && imagePicker.showImagePicker {
                                withAnimation { 
                                    imagePicker.showImagePicker.toggle()
                                }
                            }
                        })
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.primary.opacity(0.06))
                            .clipShape(Capsule())
                        
                        Button(action: {}) {
                            Image(systemName: "camera")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "mic")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 4)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            
                            //images...
                            
                            // Hỏi quyền truy cập
                            
                            if [.denied, .limited].contains(imagePicker.library_status) {
                                
                                VStack(spacing: 10) {
                                    
                                    Text(imagePicker.library_status == .denied ? "Allow Access For Photos" : "Select More Photos")
                                        .foregroundColor(.gray)
                                    
                                    Button(
                                        action: {
                                            // Goto setting
                                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                                            
                                        }
                                    ) {
                                        Text(imagePicker.library_status == .denied ? "Allow Access" : "Select Mmore")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal)
                                            .background(Color.blue)
                                            .cornerRadius(5)
                                    }
                                    
                                }
                                .frame(width: 150)
                                
                            }
                        }
                        .padding()
                        
                    }
                    .frame(height: imagePicker.showImagePicker ? 200 : 0)
                    .background(Color.primary.opacity(0.04))
                    .opacity(imagePicker.showImagePicker ? 1 : 0)
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { 
                // back button
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {}) {
                        
                        Image(systemName: "chevron.left")
                            .font(.title2)
                        
                    }
                    
                }
                
                // Profile
                ToolbarItem(id: "PROFILE", placement: .navigationBarLeading, showsByDefault: true) {
                    
                    HStack(spacing: 8) {
                        
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Text("K")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            )
                        
                        Text("Yuan")
                            .fontWeight(.semibold)
                        
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {}) {
                        
                        Image(systemName: "camera")
                            .font(.title2)
                        
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {}) {
                        
                        Image(systemName: "phone")
                            .font(.title2)
                        
                    }
                    
                }
            }
            
            
        }
        .accentColor(.primary)
        .onAppear(perform: imagePicker.setUP)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
