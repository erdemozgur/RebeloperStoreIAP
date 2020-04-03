//
//  RootViewController.swift
//  RebeloperStore5
//
//  Created by Alex Nagy on 31/07/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import DuckUI
import ReactiveKit
import Bond
import Layoutless

class RootViewController: D_ListController<RootCell, InAppPurchase> {
    
    // MARK:- Dependencies
    
    // MARK:- Properties
    
    let buttonSize = CGSize(width: 210, height: 30)
    
    // MARK:- Navigation Items
    
    lazy var exchangeBarButtonItem = UIBarButtonItem(title: "Virtual Good Exchange", style: .done, target: self, action: nil)
    
    // MARK:- Views
    
    let titleLabel = UILabel().font(UIFont.boldSystemFont(ofSize: 28)).text("Rebeloper Store Pro")
    let subitleLabel = UILabel().font(UIFont.systemFont(ofSize: 16)).text(D_InfoPlistParser.getStringValue(forKey: "CFBundleShortVersionString")).text(D_Color.Xcode11.Light.gray4)
    
    let topViewDivider = UIView().setBackground(color: D_Color.Xcode11.Light.gray4).setHeight(0.4)
    
    lazy var button0 = UIButton()
        .text("RESTORE PURCHASES")
        .text(D_Color.Xcode11.Light.green)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    let bottomViewDivider = UIView().setBackground(color: D_Color.Xcode11.Light.gray4).setHeight(0.4)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        viewDidLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK:- Setup Navigation
    
    fileprivate func setupNavigation() {
        self.navigationItem.setRightBarButton(exchangeBarButtonItem, animated: false)
    }
    
    // MARK:- View Did Load Setup
    
    fileprivate func viewDidLoadSetup() {
        
        self.addTopView(height: 84)
        self.addBottomView(height: 64)
        self.view.addStatusBarCover()
        self.view.addHomeIndicatorCover()
        
        setupTopView()
        setupBottomView()
        
    }
    
    fileprivate func setupTopView() {
        stack(.vertical)(
            Divider().vertical(.normal),
            stack(.horizontal)(
                Divider().horizontal(.normal),
                titleLabel
            ),
            Divider().vertical(.extraSmall),
            stack(.horizontal)(
                Divider().horizontal(.normal),
                subitleLabel
            ),
            Spacer()
        ).fillingParent().layout(in: topView)
        
        stack(.vertical)(
            Spacer(),
            topViewDivider.insetting(by: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
            ).fillingParent().layout(in: topView)
    }
    
    fileprivate func setupBottomView() {
        stack(.vertical)(
            bottomViewDivider.insetting(by: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)),
            Spacer()
        ).fillingParent().layout(in: bottomView)
        
        stack(.vertical)(
            button0
            ).centeringInParent().layout(in: bottomView)
    }
    
    // MARK:- Setup Views
    override func setupViews() {
        super.setupViews()
    }
    
    // MARK:- Observe
    override func observe() {
        super.observe()
        
        // MARK:- Populate with in-app purchases
        RebeloperStore.inAppPurchases.observeNext { (inAppPurchases) in
            self.items = inAppPurchases
        }.dispose(in: bag)
        
        // MARK:- Restore in-app purchases
        button0.reactive.tap.observeNext { [weak self] in
            guard let strongSelf = self else { return }
            
            Hud.handle(strongSelf.hud, with: HudInfo(type: .show, text: "Working", detailText: "Restoring purchases..."))
            RebeloperStore.restorePurchases(completion: { (success) in
                Hud.handle(strongSelf.hud, with: HudInfo(type: .close, text: "", detailText: ""))
                guard let success = success else {
                    D_AlertController.showAlert(style: .alert, title: "Error", message: "Nothing to Restore")
                    return
                }
                
                if success {
                    D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully Restored")
                } else {
                    D_AlertController.showAlert(style: .alert, title: "Error", message: "Restore Failed")
                }
            })
            }.dispose(in: bag)
        
        // MARK:- Go to Virtual Good Exchange
        exchangeBarButtonItem.reactive.tap.observeNext { [weak self] in
            guard let strongSelf = self else { return }
            let controller = VirtualGoodExchangeViewController()
            strongSelf.navigationController?.pushViewController(controller, animated: true)
            }.dispose(in: bag)
    }
    
    // MARK:- Bind
    override func bind() {
        super.bind()
    }
    
    // MARK:- Fetch Data Manually
    override func fetchData() {
        super.fetchData()
    }
    
    override func setupCell(_ cell: RootCell) {
        super.setupCell(cell)
        // set up your cell with custom behavior
        cell.delegate = self
    }
    
}

extension RootViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return .init(width: width, height: 160)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        log.ln("Did tap row: \(indexPath.row)")/
    }
}

extension RootViewController: RootCellDelegate {
    open func didTapButton(_ tag: Int, cell: D_ListCell<InAppPurchase>) {
        guard let item = cell.item else { return }
        log.ln("Did tap button with tag: \(tag) in cell with item: \(item)")/
        
        let purchase = item.registeredPurchase
        
        switch tag {
        case 0:
            // MARK:- GET INFO
            Hud.handle(hud, with: HudInfo(type: .show, text: "Working", detailText: "Getting info..."))
            RebeloperStore.getInfo(purchase.sufix) { (product) in
                guard let product = product,
                    let price = product.localizedPrice else {
                        Hud.handle(self.hud, with: HudInfo(type: .error, text: "Error", detailText: "Failed to get info"))
                        return
                }
                Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Info retreived"))
                let id = "\(D_InfoPlistParser.getBundleId()).\(purchase.sufix)"
                let title = product.localizedTitle
                let description = product.localizedDescription
                
                let message = """
                \(description)
                
                Price: \(price)
                
                \(id)
                """
                
                D_AlertController.showAlert(style: .actionSheet, title: title, message: message)
            }
            
        case 1:
            // MARK:- PURCHASE
            Hud.handle(hud, with: HudInfo(type: .show, text: "Working", detailText: "Purchasing..."))
            RebeloperStore.purchase(purchase.sufix) { (success) in
                if success {
                    Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Purchased"))
                    if purchase.sufix == RebeloperStore.consumable.sufix {
//                        VirtualGoodExchange.change(virtualGood: VirtualGoodExchange.coin, amount: 100)
                        print("ABCD")
                    }
                    if purchase.sufix == RebeloperStore.autoRenewableMonthly.sufix {
                        print("AYLIK ABONELIK ALINDI")
                    }
                } else {
                    Hud.handle(self.hud, with: HudInfo(type: .error, text: "Error", detailText: "Failed to purchase"))
                }
            }
            
        case 2:
            // MARK:- VERIFY
            Hud.handle(hud, with: HudInfo(type: .show, text: "Working", detailText: "Verifying..."))
            let purchaseType = purchase.purchaseType
            switch purchaseType {
            case .regular:
                RebeloperStore.verifyRegularPurchase(purchase.sufix) { (result) in
                    switch result {
                    case .success(let result):
                        Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Successfully verified"))
                        switch result {
                        case .purchased(_):
                            D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. It is purchased: Unlocking content!")
                        case .notPurchased:
                            D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. It is not purchased: Locking content!")
                        }
                        
                    case .failure(_):
                        Hud.handle(self.hud, with: HudInfo(type: .success, text: "Error", detailText: "Failed to verify"))
                        D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to verify purchase. Locking content!")
                    }
                }
                
            case .nonRenewing:
                let validDuration: TimeInterval = 60
                RebeloperStore.verifyRenewablePurchase(purchase.sufix, validDuration: validDuration) { (result) in
                    switch result {
                    case .success(let result):
                        Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Successfully verified"))
                        switch result {
                        case .purchased(let expiryDate, _):
                            D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. Expration date: \(expiryDate) It has not expired. Unlocking content!")
                        case .expired(let expiryDate, _):
                            D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. Expration date: \(expiryDate) It has expired. Locking content!")
                        case .notPurchased:
                            D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. It is not purchased: Locking content!")
                        }
                        
                    case .failure(_):
                        Hud.handle(self.hud, with: HudInfo(type: .success, text: "Error", detailText: "Failed to verify"))
                        D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to verify purchase. Locking content!")
                    }
                }
                
                
            case .autoRenewable:
                
                let oneAction = UIAlertAction(title: "Verify only this id", style: .default) { (action) in
                    
                    RebeloperStore.verifyRenewablePurchase(purchase.sufix) { (result) in
                        switch result {
                        case .success(let result):
                            Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Successfully verified"))
                            switch result {
                            case .purchased(let expiryDate, _):
                                D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. Expration date: \(expiryDate) It has not expired. Unlocking content!")
                            case .expired(let expiryDate, _):
                                D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. Expration date: \(expiryDate) It has expired. Locking content!")
                            case .notPurchased:
                                D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. It is not purchased: Locking content!")
                            }
                        case .failure(_):
                            Hud.handle(self.hud, with: HudInfo(type: .success, text: "Error", detailText: "Failed to verify"))
                            D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to verify purchase. Locking content!")
                        }
                    }
                    
                }
                
                let groupAction = UIAlertAction(title: "Verify group", style: .default) { (action) in
                    
                    let sufixes: Set<PurchaseSufix> = ["autoRenewableWeekly",
                                                       "autoRenewableMonthly",
                                                       "autoRenewableYearly"]
                    RebeloperStore.verifySubscriptions(sufixes) { (result) in
                        switch result {
                        case .success(let result):
                            Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Successfully verified"))
                            switch result {
                            case .purchased(let expiryDate, _):
                                D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. Expration date: \(expiryDate) It has not expired. Unlocking content!")
                            case .expired(let expiryDate, _):
                                D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. Expration date: \(expiryDate) It has expired. Locking content!")
                            case .notPurchased:
                                D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully verified purchase. It is not purchased: Locking content!")
                            }
                        case .failure(_):
                            Hud.handle(self.hud, with: HudInfo(type: .success, text: "Error", detailText: "Failed to verify"))
                            D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to verify purchase. Locking content!")
                        }
                    }
                    
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    Hud.handle(self.hud, with: HudInfo(type: .close, text: "", detailText: ""))
                }
                
                D_AlertController.showAlert(style: .actionSheet, title: "Verify", message: "Would you like to verify only this in-app purchse id or the whole subscription group?", actions: [oneAction, groupAction, cancelAction], completion: nil)
                
            }

        default:
            log.warning("No such button tag")/
        }
    }
}

