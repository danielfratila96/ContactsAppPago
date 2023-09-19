//
//  UITableViewMock.swift
//  ContactsAppTests
//
//  Created by Daniel Fratila on 9/19/23.
//

import UIKit

final class UITableViewMock: UITableView {
    private(set) var getIndexPathsForVisibleRowsWasCalled = 0
    var indexPathsForVisibleRowsAtStub: [IndexPath]?

    override var indexPathsForVisibleRows: [IndexPath]? {
        getIndexPathsForVisibleRowsWasCalled += 1
        return indexPathsForVisibleRowsAtStub
    }

    // MARK: - Lifecycle

    required init(frame _: CGRect = .zero) {
        super.init(frame: .zero, style: .plain)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - DataSource

    private(set) var setDataSourceWasCalled = 0
    override var dataSource: UITableViewDataSource? {
        get {
            super.dataSource
        }
        set {
            setDataSourceWasCalled += 1
            super.dataSource = newValue
        }
    }

    // MARK: - Delegate

    private(set) var setDelegateWasCalled = 0
    override var delegate: UITableViewDelegate? {
        get {
            super.delegate
        }
        set {
            setDelegateWasCalled += 1
            super.delegate = newValue
        }
    }

    // MARK: - isHidden

    private(set) var getIsHiddenWasCalled: Int = 0
    var isHiddenStub: Bool!

    override var isHidden: Bool {
        get {
            getIsHiddenWasCalled += 1
            return isHiddenStub
        }
        set {
            isHiddenStub = newValue
        }
    }

    // MARK: setContentOffset

    private(set) var setContentOffsetWasCalled: Int = 0
    private(set) var setContentOffsetReceivedArguments: (contentOffset: CGPoint, animated: Bool)?
    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        defer { setContentOffsetWasCalled += 1 }
        setContentOffsetReceivedArguments = (contentOffset, animated)
    }

    // MARK: - isEditing

    private(set) var getIsEditingWasCalled: Int = 0
    var isEditingStub: Bool!

    override var isEditing: Bool {
        get {
            getIsEditingWasCalled += 1
            return isEditingStub
        }
        set {
            isEditingStub = newValue
        }
    }

    // MARK: - setEditing

    private(set) var setEditingAnimatedWasCalled = 0
    private(set) var setEditingAnimatedReceivedArguments: (editing: Bool, animated: Bool)?

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        setEditingAnimatedWasCalled += 1
        setEditingAnimatedReceivedArguments = (editing, animated)
    }

    // MARK: - numberOfSections

    private(set) var getNumberOfSectionsWasCalled: Int = 0
    var numberOfSectionsStub: Int!

    override var numberOfSections: Int {
        getNumberOfSectionsWasCalled += 1
        return numberOfSectionsStub
    }

    // MARK: - numberOfRows

    private(set) var numberOfRowsInSectionWasCalled: Int = 0
    private(set) var numberOfRowsInSectionReceivedSection: Int?
    var numberOfRowsInSectionStub: Int!

    override func numberOfRows(inSection section: Int) -> Int {
        numberOfRowsInSectionWasCalled += 1
        numberOfRowsInSectionReceivedSection = section
        return numberOfRowsInSectionStub
    }

    // MARK: - tableFooterView

    private(set) var getTableFooterViewWasCalled = 0
    private(set) var tableFooterViewStub: UIView!

    override var tableFooterView: UIView? {
        get {
            getTableFooterViewWasCalled += 1
            return tableFooterViewStub
        }
        set {
            tableFooterViewStub = newValue
        }
    }

    // MARK: - indexPathForRow

    private(set) var indexPathForRowAtWasCalled: Int = 0
    private(set) var indexPathForRowAtReceivedPoint: CGPoint?
    var indexPathForRowAtStub: IndexPath!

    override func indexPathForRow(at point: CGPoint) -> IndexPath? {
        indexPathForRowAtWasCalled += 1
        indexPathForRowAtReceivedPoint = point
        return indexPathForRowAtStub
    }

    // MARK: - cellForRow

    private(set) var cellForRowWasCalled: Int = 0
    private(set) var cellForRowReceivedIndexPath: IndexPath?
    var cellForRowResponseStub: UITableViewCell?

    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        cellForRowWasCalled += 1
        cellForRowReceivedIndexPath = indexPath
        return cellForRowResponseStub
    }

    // MARK: - registerCellClassForCellReuseIdentifier

    private(set) var registerCellClassForCellReuseIdentifierWasCalled = 0
    private(set) var registerCellClassForCellReuseIdentifierReceivedArguments: (
        cellClass: AnyClass?,
        identifier: String?
    )?

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        registerCellClassForCellReuseIdentifierWasCalled += 1
        registerCellClassForCellReuseIdentifierReceivedArguments = (cellClass, identifier)
    }

    // MARK: - registerClassForHeaderFooterViewReuseIdentifier

    private(set) var registerClassForHeaderFooterViewReuseIdentifierWasCalled = 0
    private(set) var registerClassForHeaderFooterViewReuseIdentifierReceivedArguments: (
        aClass: AnyClass?,
        identifier: String
    )?

    override func register(_ aClass: AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String) {
        registerClassForHeaderFooterViewReuseIdentifierWasCalled += 1
        registerClassForHeaderFooterViewReuseIdentifierReceivedArguments = (aClass, identifier)
    }

    // MARK: - dequeueReusableCellWithIdentifierForIndexPath

    private(set) var dequeueReusableCellWithIdentifierForIndexPathWasCalled = 0
    private(set) var dequeueReusableCellWithIdentifierForIndexPathReceivedArguments: (
        identifier: String?,
        indexPath: IndexPath?
    )?
    var dequeueReusableCellWithIdentifierForIndexPathStub: UITableViewCell!

    override func dequeueReusableCell(
        withIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        dequeueReusableCellWithIdentifierForIndexPathWasCalled += 1
        dequeueReusableCellWithIdentifierForIndexPathReceivedArguments = (identifier, indexPath)
        return dequeueReusableCellWithIdentifierForIndexPathStub
    }

    // MARK: - dequeueReusableCellWithIdentifier

    private(set) var dequeueReusableCellWithIdentifierWasCalled = 0
    private(set) var dequeueReusableCellWithIdentifierReceivedIdentifier: String?
    var dequeueReusableCellWithIdentifierStub: UITableViewCell!

    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        dequeueReusableCellWithIdentifierWasCalled += 1
        dequeueReusableCellWithIdentifierReceivedIdentifier = identifier
        return dequeueReusableCellWithIdentifierStub
    }

    // MARK: - dequeueReusableHeaderFooterView

    private(set) var dequeueReusableHeaderFooterViewWasCalled = 0
    private(set) var dequeueReusableHeaderFooterReceiveIdentifier: String?
    var dequeueReusableHeaderFooterViewStub: UITableViewHeaderFooterView!

    override func dequeueReusableHeaderFooterView(
        withIdentifier identifier: String
    ) -> UITableViewHeaderFooterView? {
        dequeueReusableHeaderFooterViewWasCalled += 1
        dequeueReusableHeaderFooterReceiveIdentifier = identifier
        return dequeueReusableHeaderFooterViewStub
    }

    // MARK: - selectRow

    private(set) var selectRowWasCalled = 0
    private(set) var selectRowReceivedIndexPath: IndexPath?
    private(set) var selectRowReceivedAnimated: Bool?
    private(set) var selectRowReceivedScrollPosition: UITableView.ScrollPosition?

    override func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition) {
        selectRowWasCalled += 1
        selectRowReceivedIndexPath = indexPath
        selectRowReceivedAnimated = animated
        selectRowReceivedScrollPosition = scrollPosition
    }

    // MARK: - deselectRow

    private(set) var deselectRowWasCalled = 0
    private(set) var deselectRowReceivedArguments: (indexPath: IndexPath?, animated: Bool?)?

    override func deselectRow(at indexPath: IndexPath, animated: Bool) {
        deselectRowWasCalled += 1
        deselectRowReceivedArguments = (indexPath, animated)
    }

    // MARK: - scrollPosition

    private(set) var scrollToRowWasCalled = 0
    private(set) var scrollToRowReceivedArguments: (
        indexPath: IndexPath,
        scrollPosition: UITableView.ScrollPosition,
        animated: Bool
    )?

    override func scrollToRow(
        at indexPath: IndexPath,
        at scrollPosition: UITableView.ScrollPosition,
        animated: Bool
    ) {
        scrollToRowWasCalled += 1
        scrollToRowReceivedArguments = (indexPath: indexPath, scrollPosition: scrollPosition, animated: animated)
    }

    // MARK: - reloadData

    private(set) var reloadDataWasCalled = 0

    override func reloadData() {
        reloadDataWasCalled += 1
    }

    // MARK: - reloadRows

    private(set) var reloadRowsWasCalled = 0
    private(set) var reloadRowsReceivedIndexPaths: [IndexPath]?
    private(set) var reloadRowsReceivedAnimation: UITableView.RowAnimation?

    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        reloadRowsWasCalled += 1
        reloadRowsReceivedIndexPaths = indexPaths
        reloadRowsReceivedAnimation = animation
    }

    // MARK: - beginUpdates

    private(set) var isUpdating = false
    private(set) var beginUpdatesWasCalled = 0

    override func beginUpdates() {
        isUpdating = true
        beginUpdatesWasCalled += 1
    }

    // MARK: - endUpdates

    private(set) var endUpdatesWasCalled = 0

    override func endUpdates() {
        isUpdating = false
        endUpdatesWasCalled += 1
    }

    // MARK: - reloadSections

    private(set) var reloadSectionsWasCalled = 0
    private(set) var reloadSectionsReceivedArguments: (sections: IndexSet, animation: UITableView.RowAnimation)?

    override func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        reloadSectionsWasCalled += 1
        reloadSectionsReceivedArguments = (sections, animation)
    }

    // MARK: - moveRowAtIndexPathTo

    private(set) var moveRowAtToWasCalled = 0
    private(set) var moveRowAtToReceivedArguments: (atIndexPath: IndexPath, toIndexPath: IndexPath)?

    override func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveRowAtToWasCalled += 1
        moveRowAtToReceivedArguments = (indexPath, newIndexPath)
    }

    // MARK: - deleteSections

    private(set) var deleteSectionsWasCalled = 0
    private(set) var deleteSectionsReceivedSections: IndexSet?
    private(set) var deleteSectionsReceivedAnimation: UITableView.RowAnimation?

    override func deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        deleteSectionsWasCalled += 1
        deleteSectionsReceivedSections = sections
        deleteSectionsReceivedAnimation = animation
    }

    // MARK: - deleteRows

    private(set) var deleteRowsWasCalled = 0
    private(set) var deleteRowsReceivedIndexPaths: [IndexPath]?
    private(set) var deleteRowsReceivedAnimation: UITableView.RowAnimation?

    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        deleteRowsWasCalled += 1
        deleteRowsReceivedIndexPaths = indexPaths
        deleteRowsReceivedAnimation = animation
    }

    // MARK: - insertRows

    private(set) var insertRowsWasCalled = 0
    private(set) var insertRowsReceivedArguments: (indexPaths: [IndexPath], animation: UITableView.RowAnimation)?
    override func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        insertRowsWasCalled += 1
        insertRowsReceivedArguments = (indexPaths: indexPaths, animation: animation)
    }

    // MARK: - headerView

    private(set) var headerViewForSectionWasCalled = 0
    private(set) var headerViewForSectionReceivedSection: Int?
    var headerViewForSectionStub: UITableViewHeaderFooterView?
    override func headerView(forSection section: Int) -> UITableViewHeaderFooterView? {
        headerViewForSectionWasCalled += 1
        headerViewForSectionReceivedSection = section
        return headerViewForSectionStub
    }

    // MARK: - flashScrollIndicators

    private(set) var flashScrollIndicatorsWasCalled = 0

    override func flashScrollIndicators() {
        flashScrollIndicatorsWasCalled += 1
    }
}


