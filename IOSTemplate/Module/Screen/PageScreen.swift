//
//  PageScreen.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/11/23.
//

import SwiftUI
import ComposableArchitecture

import SFSafeSymbols
import SwifterSwift
import Parchment
import HiBase
import HiCore
import HiNav
import HiSwiftUI
import Domain
import HiLog

struct PageScreen: View {
    
    @Perception.Bindable var store: StoreOf<PageReducer>

    var pagingMenuItemSize: PagingMenuItemSize {
        var size = PagingMenuItemSize.selfSizing(estimatedWidth: 50, height: 44)
        if store.pages.count == 2 || store.preference.localization == .chinese {
            let width = deviceWidth / store.pages.count.f
            size = .sizeToFit(minWidth: width, height: 44)
        }
        return size
    }
    
    var pagingIndicatorOptions: PagingIndicatorOptions {
        var options = PagingIndicatorOptions.visible(height: 2, zIndex: .max, spacing: .zero, insets: .zero)
        if store.pages.count == 2 || store.preference.localization == .chinese {
            let width = deviceWidth / store.pages.count.f
            options = .visible(
                height: 2,
                zIndex: .max,
                spacing: .init(horizontal: width - 50, vertical: 0),
                insets: .zero
            )
        }
        return options
    }
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                NavigationBar(store.title)
                PageView(store.pages, selectedIndex: $store.selectedIndex) { page in
                    Page(page.description.localizedStringKey) {
                        childView(page)
                    }
                }
                .foregroundColor(.primary)
                .selectedColor(.accentColor)
                .menuBackgroundColor(.container)
                .menuHorizontalAlignment(.center)
                .borderOptions(.hidden)
                .menuItemLabelSpacing(12)
                .indicatorColor(.accentColor)
                .menuItemSize(self.pagingMenuItemSize)
                .indicatorOptions(self.pagingIndicatorOptions)
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .ignoresSafeArea(.all, edges: .vertical)
            .onAppear {
                stats(.beginPageView(name: self.className))
            }
            .onDisappear {
                stats(.endPageView(name: self.className))
            }
        }
    }
    
    // swiftlint:disable function_body_length
    @ViewBuilder
    func childView(_ page: PageType) -> some View {
        if page.forRepo {
            RepoListScreen.init(
                store: Store(
                    initialState: RepoListReducer.State.init(
                        url: HiNav.shared.deepLink(
                            host: .repoList,
                            parameters: [
                                Parameter.owner: store.owner,
                                Parameter.repo: store.repo,
                                Parameter.page: page.rawValue
                            ]
                        )
                    ),
                    reducer: { RepoListReducer() }
                )
            ) { store.send(.target($0)) }
        } else if page.forState {
//            if store.url.isIssuesURLString {
//                IssueListScreen.init(
//                    store: Store(
//                        initialState: IssueListReducer.State.init(
//                            url: HiNav.shared.deepLink(
//                                host: .issueList,
//                                parameters: [
//                                    Parameter.owner: store.owner,
//                                    Parameter.repo: store.repo,
//                                    Parameter.page: page.rawValue
//                                ]
//                            )
//                        ),
//                        reducer: { IssueListReducer() }
//                    )
//                ) { store.send(.target($0)) }
//            } else {
//                PullListScreen.init(
//                    store: Store(
//                        initialState: PullListReducer.State.init(
//                            url: HiNav.shared.deepLink(
//                                host: .pullList,
//                                parameters: [
//                                    Parameter.owner: store.owner,
//                                    Parameter.repo: store.repo,
//                                    Parameter.page: page.rawValue
//                                ]
//                            )
//                        ),
//                        reducer: { PullListReducer() }
//                    )
//                ) { store.send(.target($0)) }
//            }
        } else {
            UserListScreen.init(
                store: Store(
                    initialState: UserListReducer.State.init(
                        url: HiNav.shared.deepLink(
                            host: .userList,
                            parameters: [
                                Parameter.owner: store.owner,
                                Parameter.repo: store.repo,
                                Parameter.page: page.rawValue
                            ]
                        )
                    ),
                    reducer: { UserListReducer() }
                )
            ) { store.send(.target($0)) }
        }
    }
    // swiftlint:enable function_body_length
    
}
