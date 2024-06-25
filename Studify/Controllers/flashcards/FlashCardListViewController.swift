//
//  FlashCardListViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

class FlashCardListViewController: UIViewController{
    let viewmodel: FlashcardSetViewModel
    
    init(viewmodel: FlashcardSetViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var label:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Congue nisi vitae suscipit tellus mauris a diam maecenas sed. Mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget. Etiam erat velit scelerisque in dictum non consectetur a erat. Aliquet sagittis id consectetur purus ut faucibus pulvinar. Metus vulputate eu scelerisque felis imperdiet. Faucibus vitae aliquet nec ullamcorper sit amet risus nullam eget. Nunc mattis enim ut tellus elementum. Eget magna fermentum iaculis eu non diam phasellus vestibulum lorem. Feugiat vivamus at augue eget arcu dictum varius duis. A scelerisque purus semper eget duis at. Velit aliquet sagittis id consectetur purus ut. Metus dictum at tempor commodo. Quam elementum pulvinar etiam non quam lacus. Vel facilisis volutpat est velit egestas dui. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Dictum varius duis at consectetur lorem donec. Est ullamcorper eget nulla facilisi etiam. Vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra. Mi eget mauris pharetra et ultrices neque ornare aenean euismod." +
        
       " At varius vel pharetra vel. Ac tincidunt vitae semper quis lectus nulla at volutpat. Nam libero justo laoreet sit amet. Nunc scelerisque viverra mauris in aliquam sem fringilla ut morbi. Sodales ut eu sem integer vitae justo eget magna. Nunc vel risus commodo viverra. Aliquet bibendum enim facilisis gravida neque convallis a cras semper. Duis tristique sollicitudin nibh sit amet commodo nulla. Justo eget magna fermentum iaculis eu non diam phasellus. Mauris a diam maecenas sed enim ut sem viverra aliquet. Tellus integer feugiat scelerisque varius morbi. Nulla facilisi etiam dignissim diam quis enim. A lacus vestibulum sed arcu. Bibendum neque egestas congue quisque egestas diam in. Quam adipiscing vitae proin sagittis nisl. Etiam non quam lacus suspendisse faucibus interdum posuere lorem. Eu sem integer vitae justo eget magna fermentum. Eleifend mi in nulla posuere sollicitudin aliquam. Tincidunt tortor aliquam nulla facilisi cras fermentum. Adipiscing bibendum est ultricies integer." +

       " Morbi tristique senectus et netus. Id volutpat lacus laoreet non curabitur gravida arcu ac. Sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu. Morbi tincidunt ornare massa eget egestas. Aliquet enim tortor at auctor urna nunc id cursus metus. Arcu vitae elementum curabitur vitae. Mattis aliquam faucibus purus in. Venenatis urna cursus eget nunc. A cras semper auctor neque vitae tempus quam pellentesque. Erat imperdiet sed euismod nisi porta lorem mollis aliquam ut. Consectetur libero id faucibus nisl tincidunt eget nullam non nisi. Sed augue lacus viverra vitae congue eu consequat ac. Molestie a iaculis at erat pellentesque adipiscing commodo. Vestibulum morbi blandit cursus risus at ultrices mi tempus. Sed faucibus turpis in eu mi bibendum neque. Mauris cursus mattis molestie a iaculis. Enim praesent elementum facilisis leo." +

        "Morbi tincidunt augue interdum velit. Porttitor eget dolor morbi non arcu risus. Enim nunc faucibus a pellentesque. Leo urna molestie at elementum eu facilisis sed. Eget velit aliquet sagittis id consectetur. Scelerisque mauris pellentesque pulvinar pellentesque habitant morbi. Ut tellus elementum sagittis vitae et leo duis ut diam. Rhoncus mattis rhoncus urna neque viverra justo nec. Tempor orci dapibus ultrices in iaculis nunc sed augue. Orci eu lobortis elementum nibh tellus. Tellus in metus vulputate eu scelerisque felis imperdiet proin." +

        "Nunc mattis enim ut tellus elementum sagittis vitae et leo. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. Praesent semper feugiat nibh sed pulvinar. Placerat duis ultricies lacus sed turpis tincidunt id aliquet risus. Morbi blandit cursus risus at. Nisl nunc mi ipsum faucibus vitae. Eget est lorem ipsum dolor sit amet consectetur adipiscing elit. Gravida rutrum quisque non tellus orci. Facilisis volutpat est velit egestas dui. Tortor at risus viverra adipiscing at in tellus. Condimentum lacinia quis vel eros donec ac odio tempor. Ante in nibh mauris cursus mattis. Volutpat consequat mauris nunc congue nisi vitae suscipit tellus. Erat imperdiet sed euismod nisi porta lorem mollis aliquam. Ac felis donec et odio pellentesque diam. In pellentesque massa placerat duis." +
       " label.backgroundColor = UIColor.systemBlue"
        
        //label.numberOfLines = 0
        
        
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        setupConstraints()

        // Do any additional setup after loading the view.
    }

}

extension FlashCardListViewController{
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: scrollView.topAnchor),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            

            
            
            
            
//            label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
    }
    
    
    
}


