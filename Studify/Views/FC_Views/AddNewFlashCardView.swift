//
//  TableViewTextFieldCellTableViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

class AddNewFlashCardView: UIView {
    
    var activeTextField: UITextView?
    
    let defaultTFFront = "Enter Term"
    
    let defaultTFBack = "Enter Definition"
    let addFlashCardViewmodel:AddNewFlashCardViewModel
    
 


    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
       // stack.backgroundColor = UIColor.systemBackground
        stack.spacing = 20
        return stack
    }()
    lazy var stackScrollView: UIScrollView = {
        let stackScrollView = UIScrollView()
        stackScrollView.translatesAutoresizingMaskIntoConstraints = false
        return stackScrollView
        
    }()
    
    lazy var frontStringlabel: UILabel = configureLabel(text: "Term:")
    lazy var backStringLabel: UILabel = configureLabel(text: "Definition:")
    lazy var frontStringTextField: UITextView = configureTextField(placeholder: "Enter Term")
    lazy var backStringTextField: UITextView = configureTextField(placeholder: "Enter Definition")
    
   
    
    init(addFlashCardViewmodel:AddNewFlashCardViewModel, frame: CGRect){
        self.addFlashCardViewmodel = addFlashCardViewmodel
        super.init(frame: frame)
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AddNewFlashCardView{
    private func setup(){
        backgroundColor = .clear
//        frontStringlabel .attributedText = NSAttributedString(string: "Term: ",
//                                                                                      attributes: [.foregroundColor: addFlashCardViewmodel.fontColor,
//                                                                                                   .font: addFlashCardViewmodel.titleFont])
//        backStringLabel.attributedText = NSAttributedString(string: "Definition: ",
//                                                                                  attributes: [.foregroundColor: addFlashCardViewmodel.fontColor,
//                                                                                               .font: addFlashCardViewmodel.titleFont])
        
        
        

        
        
        addSubview(stackScrollView)
        verticalStack.addArrangedSubview(frontStringlabel)
        verticalStack.addArrangedSubview(frontStringTextField)
        verticalStack.addArrangedSubview(backStringLabel)
        verticalStack.addArrangedSubview(backStringTextField)
        stackScrollView.addSubview(verticalStack)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            stackScrollView.topAnchor.constraint(equalTo: topAnchor),
                  stackScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                  stackScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                  stackScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                 
                  verticalStack.topAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.topAnchor),
                  verticalStack.leadingAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.leadingAnchor, constant: 10),
                  verticalStack.trailingAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.trailingAnchor, constant: -10),
                  // Ensure the vertical stack stretches sufficiently to determine the scroll view's content height
                  verticalStack.bottomAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.bottomAnchor, constant: -10),
                  // Width of verticalStack should match the width of the scrollView frame, minus the constant adjustments
                  verticalStack.widthAnchor.constraint(equalTo: stackScrollView.frameLayoutGuide.widthAnchor, constant: -20)
        ])
    }
}

extension AddNewFlashCardView{
    private func configureTextField(placeholder: String) -> UITextView{
        //let defaultText = placeholder
        let textView = UITextView()
        textView.font = addFlashCardViewmodel.regularFont
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 2
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.isScrollEnabled = false // Start with no scrolling
        textView.text = placeholder
        textView.textColor = addFlashCardViewmodel.fontColor
        textView.backgroundColor = addFlashCardViewmodel.backGroundColor
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        textView.textAlignment = .left
        textView.delegate = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))  // Example height

        toolbar.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask

        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))

        toolbar.setItems([flexSpace, doneButton], animated: false)
        textView.inputAccessoryView = toolbar  // Set the toolbar as input accessory view
        return textView
    }
    
    private func configureLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: text,
                                                  attributes: [.foregroundColor: addFlashCardViewmodel.fontColor,
                                                               .font: addFlashCardViewmodel.titleFont])
        return label
    }
}

extension AddNewFlashCardView: UITextViewDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        stackScrollView.contentInset = contentInsets
        stackScrollView.scrollIndicatorInsets = contentInsets
        
        if let activeField = self.activeTextField {
            let contentRect = stackScrollView.convert(activeField.frame, from: activeField.superview)
            stackScrollView.scrollRectToVisible(contentRect, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        stackScrollView.contentInset = .zero
        stackScrollView.scrollIndicatorInsets = .zero
    }
    
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeTextField = textView  // Assuming `activeTextField` is a property of your view controller
        
        if textView.text == "Enter Term" || textView.text == "Enter Definition" {
            // Clear the placeholder text and update the style for user input
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "HelveticaNeue", size: 15)
        } else {
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "HelveticaNeue", size: 15)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.text = textView == frontStringTextField ? "Enter Term" : "Enter Definition"
            //textView.textColor = UIColor.darkGray // Placeholder color
            textView.textColor = addFlashCardViewmodel.fontColorSecondary.withAlphaComponent(0.5)
            textView.font = UIFont(name: "HelveticaNeue", size: 12)
        }
        
        textView.textColor = addFlashCardViewmodel.fontColor // Placeholder color
        textView.font = UIFont(name: "HelveticaNeue", size: 12)
    }
}
   


