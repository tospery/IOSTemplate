//
//  PopupManager.swift
//  WillHub
//
//  Created by 杨建祥 on 2024/12/22.
//

import SwiftUI
import HiSwiftUI
import HiLog
import HiNav
import ExytePopupView

class PopupManager {
    
    private var type: String?
//    private var branchListScreen: BranchListScreen?
//    private var shareScreen: ShareScreen?
//    private var clipboardScreen: ClipboardScreen?
    
    static var shared = PopupManager()
    
    init() { }
    
    @ViewBuilder
    func popupView(for state: PopupState) -> some View {
//        if state.type == PopupType.branchList.rawValue {
//            if let screen = self.branchListScreen {
//                screen
//            } else {
//                self.createBranchListScreen(for: state)
//            }
//        } else if state.type == PopupType.share.rawValue {
//            if let screen = self.shareScreen {
//                screen
//            } else {
//                self.createShareScreen(for: state)
//            }
//        } else if state.type == PopupType.clipboard.rawValue {
//            if let screen = self.clipboardScreen {
//                screen
//            } else {
//                self.createClipboardScreen(for: state)
//            }
//        } else {
//            EmptyView()
//        }
        EmptyView()
    }
    
    func popupParameters<PopupContent: View>(
        for state: PopupState?,
        with param: Popup<PopupContent>.PopupParameters
    ) -> Popup<PopupContent>.PopupParameters {
        let type = state?.type == nil ? self.type : state?.type
        if type == PopupType.branchList.rawValue {
            return param
                .appearFrom(.centerScale)
                .closeOnTap(false)
                .backgroundColor(.primary.opacity(0.4))
        } else if type == PopupType.share.rawValue {
            return param
                .type(.floater(verticalPadding: 0, useSafeAreaInset: false))
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.primary.opacity(0.4))
        } else if type == PopupType.clipboard.rawValue {
            return param
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .closeOnTap(false)
                .closeOnTapOutside(false)
        } else {
            return param
        }
    }
    
    func remove(_ state: PopupState) {
        log("开始移除Popup缓存的view")
//        if state.type == PopupType.branchList.rawValue {
//            self.branchListScreen = nil
//        } else if state.type == PopupType.share.rawValue {
//            self.shareScreen = nil
//        } else if state.type == PopupType.clipboard.rawValue {
//            self.clipboardScreen = nil
//        }
    }
    
//    private func createBranchListScreen(for state: PopupState) -> BranchListScreen {
//        self.type = state.type
//        let screen = BranchListScreen(
//            store: .init(
//                initialState: BranchListReducer.State(url: HiNav.shared.popupDeepLink(
//                    state.type,
//                    state.data
//                )),
//                reducer: { BranchListReducer() }
//            )
//        )
//        self.branchListScreen = screen
//        return screen
//    }
//    
//    private func createShareScreen(for state: PopupState) -> ShareScreen {
//        self.type = state.type
//        let screen = ShareScreen(
//            store: .init(
//                initialState: ShareReducer.State(url: HiNav.shared.popupDeepLink(
//                    state.type,
//                    state.data
//                )),
//                reducer: { ShareReducer() }
//            )
//        )
//        self.shareScreen = screen
//        return screen
//    }
//    
//    private func createClipboardScreen(for state: PopupState) -> ClipboardScreen {
//        self.type = state.type
//        let screen = ClipboardScreen(
//            store: .init(
//                initialState: ClipboardReducer.State(url: HiNav.shared.popupDeepLink(
//                    state.type,
//                    state.data
//                )),
//                reducer: { ClipboardReducer() }
//            )
//        )
//        self.clipboardScreen = screen
//        return screen
//    }
    
}
