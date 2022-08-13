//
//  ViewController.swift
//  Drinks
//
//  Created by igor s on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Private Properties
    private var drink = Drink(drinks: [])
    
    private var link = Link.drinkURL.rawValue + DrinkTypes.daiquiri.rawValue
    
    @IBOutlet weak var drinksTypeLabel: UILabel!
    
    @IBOutlet weak var drinkCollectionView: UICollectionView!
    
    @IBOutlet weak var settingBarButton: UIBarButtonItem!
    
    //var drinksPicker: UIPickerView!
    @IBOutlet weak var drinksPickerView: UIPickerView!
    
    private var drinkTypes: [String] {
        DrinkTypes.allCases.map { $0.rawValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinksPickerView.backgroundColor = .secondarySystemBackground
        drinksPickerView.inputAccessoryViewController?.toolbarItems = createToolBar()
        setPicker()
        fetchDrinks()
        drinkCollectionView.delegate = self
        drinkCollectionView.dataSource = self
        drinksPickerView.delegate = self
        
        
        //drinksPicker = createPickerView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        drinksPickerView.isHidden = true
    }
    
    @IBAction func settingsBarButtonTapped(_ sender: Any) {
        drinksPickerView.isHidden = false
    }
    
    private func setPicker() {
        drinksPickerView.selectRow(0, inComponent: 0, animated: true)
        drinksTypeLabel.text = "Types of " + drinkTypes[drinksPickerView.selectedRow(inComponent: 0)]
    }
    
    private func createToolBar() -> UIBarButtonItem {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        drinksPickerView.inputAccessoryView = toolbar

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(dismissKeyboard)
        )
//        let flexBar = UIBarButtonItem(
//            barButtonSystemItem: .flexibleSpace,
//            target: nil,
//            action: nil
//        )
//        toolbar.items = [flexBar, doneButton]
//        toolbar.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        return toolbar
        return doneButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let coctailVC = segue.destination as? CoctailViewController else { return }
        guard let coctail = sender as? Coctail else { return }
        coctailVC.coctail = coctail
    }
    
    //MARK: - Private Methods
    private func fetchDrinks() {
        NetworkManager.shared.fetch(Drink.self, from: link) { [weak self] result in
            switch result {
            case .success(let drink):
                self?.drink = drink
                self?.drinkCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drink.drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = drinkCollectionView.dequeueReusableCell(
                withReuseIdentifier: "drinkCell",
                for: indexPath
            ) as? DrinkCollectionViewCell else { return UICollectionViewCell() }
        
        let coctail = drink.drinks[indexPath.item]
        cell.configure(with: coctail)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: collectionView.frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coctail = drink.drinks[indexPath.item]
        performSegue(withIdentifier: "showCoctailDetails", sender: coctail)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        drinkTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        drinkTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        link = Link.drinkURL.rawValue + drinkTypes[row]
        drinksTypeLabel.text = "Types of \(drinkTypes[row])"
        fetchDrinks()
    }
}
