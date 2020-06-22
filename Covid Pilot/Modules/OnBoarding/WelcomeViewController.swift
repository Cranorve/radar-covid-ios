//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var router: AppRouter?
    
    @IBOutlet weak var bulletTextView: UITextView!
    
    @IBAction func onContinue(_ sender: Any) {
        router?.route(to: .OnBoarding, from: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loadText()
    }
    
    private func loadText() {
        let bullet1 = "Conoce en todo momento si te expones al coronavirus, ayudándote a protegerte y proteger a los demás.\n"
        
        let bullet2 = "Comunica de forma anónima tu diagnóstico Covid positivo.\n"
        let bullet3 = "Si tu estuvieras afectado, comunicaremos la exposición de forma anonima a las personas con las que has estado en contacto."
        let strings = [bullet1, bullet2, bullet3]
        
        let fullAttributedString = NSMutableAttributedString()
        for text: String in strings {
            let bulletAttributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font : bulletTextView.font!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.5410000086, green: 0.4860000014, blue: 0.7179999948, alpha: 1)]
            let bodyAttributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font : bulletTextView.font!]
            
            let bulletPoint: String = "\u{2022}"
            let attributedString = NSMutableAttributedString(string: bulletPoint, attributes: bulletAttributes)
            
            attributedString.append(NSAttributedString(string: " \(text) \n", attributes: bodyAttributes))
            let indent:CGFloat = 15
            let paragraphStyle = createParagraphAttribute(tabStopLocation: indent, defaultTabInterval: indent, firstLineHeadIndent: indent - 10, headIndent: indent)
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
        }
        bulletTextView.attributedText = fullAttributedString
    }
    
    private func createParagraphAttribute(tabStopLocation:CGFloat, defaultTabInterval:CGFloat, firstLineHeadIndent:CGFloat, headIndent:CGFloat) -> NSParagraphStyle {
         let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
         let options:[NSTextTab.OptionKey:Any] = [:]
         paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: tabStopLocation, options: options)]
         paragraphStyle.defaultTabInterval = defaultTabInterval
         paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
         paragraphStyle.headIndent = headIndent
         return paragraphStyle
     }

}
