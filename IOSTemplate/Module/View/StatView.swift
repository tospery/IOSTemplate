//
//  StatView.swift
//  WillHub
//
//  Created by 杨建祥 on 2025/1/4.
//

import SwiftUI
import SFSafeSymbols
import HiBase
import HiCore
import HiSwiftUI
import SwifterSwift
import Domain

struct StatView: View {
    
    let user: User?
    let repo: Repo?
    let pages: [PageType]
    let forPersonal: Bool
    let action: (PageType) -> Void
    
    init(user: User?, repo: Repo?, pages: [PageType], forPersonal: Bool, action: @escaping (PageType) -> Void) {
        self.user = user
        self.repo = repo
        self.pages = pages
        self.forPersonal = forPersonal
        self.action = action
    }
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: screenWidth * (forPersonal ? 0.06 : 0.1))
            let last = pages.last
            ForEach(pages) { page in
                VStack {
                    Text(count(page))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.primary)
                    Text(title(page))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.primary.opacity(0.5))
                }
                .onTapGesture {
                    action(page)
                }
                if page != last {
                    Spacer()
                }
            }
            Spacer()
                .frame(width: screenWidth * (forPersonal ? 0.06 : 0.1))
        }
    }
    
    func count(_ page: PageType) -> String {
        switch page {
        case .repositories: return (user?.publicRepos ?? 0).decimalText
        case .followers: return (user?.followers ?? 0).decimalText
        case .following: return (user?.following ?? 0).decimalText
        case .subscribers: return (repo?.subscribers ?? 0).decimalText
        case .stars: return (repo?.stars ?? 0).decimalText
        case .forks: return (repo?.forks ?? 0).decimalText
        default: return ""
        }
    }
    
    func title(_ page: PageType) -> LocalizedStringKey {
        switch page {
        case .repositories: return R.string.localizable.repositories.localizedStringKey
        case .followers: return R.string.localizable.followers.localizedStringKey
        case .following: return R.string.localizable.following.localizedStringKey
        case .subscribers: return R.string.localizable.subscribers.localizedStringKey
        case .stars: return R.string.localizable.stargazers.localizedStringKey
        case .forks: return R.string.localizable.forks.localizedStringKey
        default: return .init("")
        }
    }
    
}
