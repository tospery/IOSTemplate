//
//  NewsCell.swift
//  IOSTemplate
//
//  Created by 杨建祥 on 2026/3/29.
//

import SwiftUI
import Kingfisher
import HiLog
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import SwifterSwift
internal import SwiftUIKit_Hi

struct NewsCell: View {
    
    let model: Domain.News
    let action: (String) -> Void
    
    init(_ model: Domain.News, action: @escaping (String) -> Void) {
        self.model = model
        self.action = action
    }
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text(model.title ?? "")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.primary)
                    .lineLimit(3)
                    .padding(.top, 4)
                Spacer()
                HStack {
                    Text(model.src ?? "")
                        .font(.system(size: 9))
                        .foregroundStyle(Color.primary.opacity(0.8))
                    Spacer()
                    Text(model.time ?? "")
                        .font(.system(size: 9))
                        .foregroundStyle(Color.primary.opacity(0.8))
                }
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
            Spacer(minLength: 8)
            KFImage.url(model.pic?.url)
                .placeholder {
                    R.image.loading_icon.swiftUIImage
                        .resizable()
                        .frame(width: 160, height: 90)
                }
                .resizable()
                .roundCorner(radius: .heightFraction(0.08))
                .serialize(as: .PNG)
                .loadDiskFileSynchronously()
                .frame(width: 160, height: 90)
                .padding(.trailing, 8)
                .padding(.vertical, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        
//        HStack {
//            Text("Cell")
//                .foregroundColor(.black)
//            Spacer()
//        }
//        .padding(.horizontal, 16)
//        .frame(height: 60)
//        .frame(maxWidth: .infinity)
        
//        .background(Color.white)
//        .cornerRadius(12)
        
        // .roundCorner(radius: .heightFraction(0.12))
        
//        HStack {
//            
//        }
//        .frame(width: screenWidth - 12, height: 80)
//        .background(Color.red)
        
        
        
        /// .cornerRadius(<#T##style: CornerRadiusStyle##CornerRadiusStyle#>)
        
//        VStack(alignment: .leading, spacing: 10) {
//            HStack(alignment: .top, spacing: 20) {
//                
//            }
//            .frame(minWidth: screenWidth - 20)
//            .frame(minHeight: 80)
//
//        }
        
//        HStack {
//            KFImage.url(model.pic?.url)
//                .placeholder {
//                    R.image.default_icon.swiftUIImage
//                        .resizable()
//                        .frame(width: 107, height: 60)
//                }
//                .resizable()
//                .roundCorner(radius: .heightFraction(0.12))
//                .serialize(as: .PNG)
//                .loadDiskFileSynchronously()
//                .frame(width: 107, height: 60)
//                .padding(.trailing, 4)
//            VStack {
//                
//            }
//            Spacer()
//        }
        
//        VStack(spacing: 0) {
//            HStack {
//                Text(model.title ?? "")
//                    .font(.system(size: 16, weight: .bold))
//                    .foregroundStyle(Color.primary)
//                Spacer()
//            }
//            .padding(.top, 10)
//            HStack {
//                KFImage.url(model.pic?.url)
//                    .placeholder {
//                        R.image.default_icon.swiftUIImage
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                    }
//                    .resizable()
//                    .roundCorner(radius: .heightFraction(0.12))
//                    .serialize(as: .PNG)
//                    .loadDiskFileSynchronously()
//                    .frame(width: 40, height: 40)
//                    .padding(.trailing, 4)
//                Spacer()
//            }
//            .padding(.top, 10)
//            HStack {
//                Spacer()
//                Text(model.time ?? "")
//                    .font(.system(size: 11))
//                    .foregroundStyle(Color.primary.opacity(0.8))
//            }
//            .padding(.bottom, 4)
//        }
//        .padding(.horizontal)
//        .contentShape(.rect)
//        .onTapGesture {
////            var array = model.repo?.name?.components(separatedBy: "/") ?? []
////            array = array.removeAll("/")
////            guard array.count == 2 else { return }
////            action(HiNav.shared.deepLink(host: .repo, parameters: [
////                Parameter.owner: array.first!,
////                Parameter.repo: array.last!
////            ]))
//        }
    }
    
}

