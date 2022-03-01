//
//  HomeView.swift
//  ROTProject
//
//  Created by Hackman Adu Gyamfi on 01/03/2022.
//

import UIKit

class HomeView: UIViewController,UITextViewDelegate {
    
    var selectedROTValue:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
        title = "ROT 13"
        self.initViews()
        self.registerNotificationForSelectingROT()
        self.selectedROTValue = HomeViewModel.initialROT
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.SetUpLayouts()
        self.PageScrollView.scrollViewSizeFit()
    }
    
    private func registerNotificationForSelectingROT(){
        NotificationCenter.default.addObserver(self, selector: #selector(onSelectionObserverMethod), name: .init(rawValue: "ROTSelection"), object: nil)
    }
    
    @objc func onSelectionObserverMethod(sender:Notification){
        let info = sender.userInfo!
        guard let infoDictionary = info as? [String:String]else {return}
        if let selectedValue = infoDictionary["selected"]{
            self.selectedROTValue = selectedValue
            self.SelectionField.configuration?.title = self.selectedROTValue
            self.DisplayTextView.text = HomeViewModel.calculate(text: InputTextView.text ?? "", ROTType: self.selectedROTValue)
        }
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.DisplayTextView.text = HomeViewModel.calculate(text: textView.text ?? "", ROTType: self.selectedROTValue)
    }
    
    private func initViews(){
        view.addSubview(PageScrollView)
    }
    
    private func SetUpLayouts(){
        PageScrollView.position(top: view.layoutMarginsGuide.topAnchor,left: view.leftAnchor,bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor, paddingTop:15, paddingLeft: 16, paddingRight: 16)
        Heading2.position(top: PageScrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 25)
        InputTextView.position(top: Heading2.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8.5, paddingLeft: 16, paddingRight: 16, height: 130)
        SelectionField.position(top: InputTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 55)
        Heading1.position(top: SelectionField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 45, paddingLeft: 16, paddingRight: 16, height: 25)
        DisplayTextView.position(top: Heading1.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8.5, paddingLeft: 16, paddingRight: 16, height: 130)
       
    }
    
    lazy var PageScrollView:UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.addSubview(Heading2)
        scrollView.addSubview(InputTextView)
        scrollView.addSubview(SelectionField)
        scrollView.addSubview(Heading1)
        scrollView.addSubview(DisplayTextView)
        return scrollView
    }()
    lazy var DisplayTextView:UITextView = {
        var textView = CustomTextView()
        textView.isEditable = false
        return textView
    }()
    lazy var InputTextView:UITextView = {
        var textView = CustomTextView()
        let toolBar = UIToolbar()
        textView.delegate = self
        toolBar.sizeToFit()
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DismissKeyBoard))], animated: true)
        textView.inputAccessoryView = toolBar
        return textView
    }()
    
    @objc func DismissKeyBoard(){
        view.endEditing(true)
    }
    
    lazy var Heading1:UILabel = {
        var heading = self.FieldHeading(text: "Results")
        return heading
    }()
    
    lazy var Heading2:UILabel = {
        var heading = self.FieldHeading(text: "Enter Text Here")
        return heading
    }()
    
    func FieldHeading(text:String)->UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = .black.withAlphaComponent(0.85)
        label.font = .systemFont(ofSize: 15, weight:.light)
        return label
        
    }
    
    lazy var SelectionField:UIButton = {
        var selectionField = UIButton(type: .system)
        selectionField.configuration = .filled()
        selectionField.configuration?.title = HomeViewModel.initialROT
        selectionField.configuration?.image = UIImage(systemName: "arrowtriangle.down")
        selectionField.configuration?.imagePlacement = .trailing
        selectionField.configuration?.imagePadding = 7
        selectionField.imageView?.layer.transform = CATransform3DMakeScale(0.75, 0.75, 0.75)
        selectionField.addAction(UIAction(handler: { action in
            let selectionView = SelectROTView()
            selectionView.selectedROTValue = self.selectedROTValue
            self.present(UINavigationController(rootViewController: selectionView), animated: true)
        }), for: .touchUpInside)
        selectionField.configuration?.baseBackgroundColor = .systemPink
        selectionField.configuration?.baseForegroundColor = .white
        return selectionField
    }()
    
}


