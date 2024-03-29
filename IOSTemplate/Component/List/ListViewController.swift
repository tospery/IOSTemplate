//
//  ListViewController.swift
//  SWHub
//
//  Created by 杨建祥 on 2022/10/3.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import URLNavigator_Hi
import Rswift
import HiIOS
import ReusableKit_Hi
import ObjectMapper_Hi
import Kingfisher
import RxDataSources
import RxGesture

// swiftlint:disable type_body_length file_length
class ListViewController: GeneralViewController {
    
    struct Reusable {
        static let simpleCell = ReusableCell<SimpleCell>()
        static let appInfoCell = ReusableCell<AppInfoCell>()
        static let checkCell = ReusableCell<CheckCell>()
        static let labelCell = ReusableCell<LabelCell>()
        static let buttonCell = ReusableCell<ButtonCell>()
        static let textFieldCell = ReusableCell<TextFieldCell>()
        static let textViewCell = ReusableCell<TextViewCell>()
        static let imageViewCell = ReusableCell<ImageViewCell>()
        static let baseHeader = ReusableView<BaseCollectionHeader>()
        static let baseFooter = ReusableView<BaseCollectionFooter>()
    }
    
    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<Section> = {
        return .init(
            configureCell: { [weak self] dataSource, collectionView, indexPath, sectionItem in
                guard let `self` = self else { return collectionView.emptyCell(for: indexPath)}
                return self.cell(dataSource, collectionView, indexPath, sectionItem)
            },
            configureSupplementaryView: { [weak self] _, collectionView, kind, indexPath in
                guard let `self` = self else { return collectionView.emptyView(for: indexPath, kind: kind) }
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    return self.header(collectionView, for: indexPath)
                case UICollectionView.elementKindSectionFooter:
                    let footer = collectionView.dequeue(Reusable.baseFooter, kind: kind, for: indexPath)
                    footer.theme.backgroundColor = themeService.attribute { $0.lightColor }
                    return footer
                default:
                    return collectionView.emptyView(for: indexPath, kind: kind)
                }
            }
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.simpleCell)
        self.collectionView.register(Reusable.appInfoCell)
        self.collectionView.register(Reusable.labelCell)
        self.collectionView.register(Reusable.buttonCell)
        self.collectionView.register(Reusable.textFieldCell)
        self.collectionView.register(Reusable.textViewCell)
        self.collectionView.register(Reusable.imageViewCell)
        self.collectionView.register(Reusable.checkCell)
        self.collectionView.register(Reusable.baseHeader, kind: .header)
        self.collectionView.register(Reusable.baseFooter, kind: .footer)
        self.collectionView.rx.itemSelected(dataSource: self.dataSource)
            .subscribeNext(weak: self, type(of: self).tapItem)
            .disposed(by: self.rx.disposeBag)
    }

    override func bind(reactor: GeneralViewReactor) {
        super.bind(reactor: reactor)
//        reactor.state.map { $0.user as? User }
//            .distinctUntilChanged()
//            .skip(1)
//            .subscribeNext(weak: self, type(of: self).handleUser)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.configuration as? Configuration }
//            .distinctUntilChanged()
//            .skip(1)
//            .subscribeNext(weak: self, type(of: self).handleConfiguration)
//            .disposed(by: self.disposeBag)
        // swiftlint:disable:next force_cast
        reactor.state.map { $0.sections as! [Section] }
            .distinctUntilChanged()
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - cell/header/footer
    // swiftlint:disable cyclomatic_complexity function_body_length
    func cell(
        _ dataSource: CollectionViewSectionedDataSource<Section>,
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ sectionItem: Section.Item
    ) -> UICollectionViewCell {
        switch sectionItem {
        case let .simple(item):
            let cell = collectionView.dequeue(Reusable.simpleCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            return cell
        case let .appInfo(item):
            let cell = collectionView.dequeue(Reusable.appInfoCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            cell.rx.tapLogo
                .subscribeNext(weak: self, type(of: self).tapLogo)
                .disposed(by: cell.disposeBag)
            return cell
        case let .check(item):
            let cell = collectionView.dequeue(Reusable.checkCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            return cell
        case let .label(item):
            let cell = collectionView.dequeue(Reusable.labelCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            cell.rx.click
                .subscribeNext(weak: self, type(of: self).handleTarget)
                .disposed(by: cell.disposeBag)
            return cell
        case let .button(item):
            let cell = collectionView.dequeue(Reusable.buttonCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            cell.rx.tapButton
                .map { Reactor.Action.execute(value: nil, active: true, needLogin: false) }
                .bind(to: self.reactor!.action)
                .disposed(by: cell.disposeBag)
            return cell
        case let .imageView(item):
            let cell = collectionView.dequeue(Reusable.imageViewCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            return cell
        case let .textField(item):
            let cell = collectionView.dequeue(Reusable.textFieldCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            cell.rx.text
                .asObservable()
                .distinctUntilChanged()
                .map(Reactor.Action.data)
                .observe(on: MainScheduler.asyncInstance)
                .bind(to: self.reactor!.action)
                .disposed(by: cell.disposeBag)
            return cell
        case let .textView(item):
            let cell = collectionView.dequeue(Reusable.textViewCell, for: indexPath)
            item.parent = self.reactor
            cell.reactor = item
            cell.rx.text
                .asObservable()
                .distinctUntilChanged()
                .map(Reactor.Action.data)
                .observe(on: MainScheduler.asyncInstance)
                .bind(to: self.reactor!.action)
                .disposed(by: cell.disposeBag)
            return cell
        }
    }
    // swiftlint:enable cyclomatic_complexity function_body_length
    
    func header(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeue(
            Reusable.baseHeader,
            kind: UICollectionView.elementKindSectionHeader,
            for: indexPath
        )
        header.theme.backgroundColor = themeService.attribute { $0.lightColor }
        return header
    }
    
    // MARK: - handle
    override func handleUser(user: UserType?) {
        guard let user = user as? User else { return }
        if User.current == user {
            return
        }
        MainScheduler.asyncInstance.schedule(()) { _ -> Disposable in
            log("handleUser(\(self.reactor?.host ?? ""), \(self.reactor?.path ?? "")) -> 更新用户，准备保存")
            User.update(user, reactive: true)
            return Disposables.create {}
        }.disposed(by: self.disposeBag)
    }
    
    override func handleConfiguration(configuration: ConfigurationType?) {
        super.handleConfiguration(configuration: configuration)
        guard let configuration = configuration as? Configuration else { return }
        MainScheduler.asyncInstance.schedule(()) { _ -> Disposable in
            Subjection.update(Configuration.self, configuration, true)
            return Disposables.create {}
        }.disposed(by: self.disposeBag)
    }
    
    // MARK: - tap
    // swiftlint:disable cyclomatic_complexity function_body_length
    func tapItem(sectionItem: SectionItem) {
        let username = (self.reactor as? IOSTemplate.ListViewReactor)?.username ?? ""
        let reponame = (self.reactor as? IOSTemplate.ListViewReactor)?.reponame ?? ""
        switch sectionItem {
        case let .simple(item):
            guard let simple = item.model as? Simple else { return }
            if let target = simple.target, target.isNotEmpty {
                self.navigator.jump(target)
                return
            }
        default:
            break
        }
    }
    // swiftlint:enable cyclomatic_complexity function_body_length
    
    func tapUser(username: String) {
        self.navigator.jump(Router.shared.urlString(host: .user, path: username))
    }

    func tapLogo(_: Void? = nil) {
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    override func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case let .simple(item): return Reusable.simpleCell.class.size(width: width, item: item)
        case let .appInfo(item): return Reusable.appInfoCell.class.size(width: width, item: item)
        case let .check(item): return Reusable.checkCell.class.size(width: width, item: item)
        case let .label(item): return Reusable.labelCell.class.size(width: width, item: item)
        case let .button(item): return Reusable.buttonCell.class.size(width: width, item: item)
        case let .textField(item): return Reusable.textFieldCell.class.size(width: width, item: item)
        case let .textView(item): return Reusable.textViewCell.class.size(width: width, item: item)
        case let .imageView(item): return Reusable.imageViewCell.class.size(width: width, item: item)
        }
    }
    
}
