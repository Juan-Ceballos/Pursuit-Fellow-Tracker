//
//  PanZoomView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/22/21.
//

import UIKit
import SnapKit

class PanZoomImageView: UIScrollView {
    
    private var imageName: String? {
        didSet {
            guard let imageName = imageName else {
                return
            }
            imageView.image = UIImage(named: imageName)
        }
    }
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init(named: String) {
        self.init(frame: .zero)
        self.imageName = named
    }
    
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        imageView.image = image
    }
    
    private func commonInit() {
        // Setup image view
        setupImageViewConstrainsts()
        
        // Setup scroll view
        setupScrollView()
        
        // Setup tap gesture
        setTapGesture()
    }
    
    private func setupImageViewConstrainsts(){
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { mkr in
            mkr.width.equalToSuperview()
            mkr.height.equalToSuperview()
            mkr.center.equalToSuperview()
        }
    }
    
    private func setupScrollView(){
        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
    }
    
    private func setTapGesture(){
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if zoomScale == 1 {
            setZoomScale(2, animated: true)
        } else {
            setZoomScale(1, animated: true)
        }
    }
    
}

extension PanZoomImageView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
