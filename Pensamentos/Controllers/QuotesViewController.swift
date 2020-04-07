//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Glayce on 06/04/20.
//  Copyright © 2020 Glayce. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {
    //Controles da view
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var ivPhotobg: UIImageView!
    @IBOutlet weak var lbQuotes: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lcTop: NSLayoutConstraint!
    
    //Variaveis
    let quotesManager = QuotesManager()
    var timer: Timer?
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        formatView()
        prepareQuote()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        lbQuotes.textColor = config.colorScheme == 0 ? .black : .white
        lbAuthor.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
    }
    
    func prepareQuote() {
        //Interrompe qualquer execucao do timer que esteja acontecendo
        timer?.invalidate()
        
        //Se estiver configurado para o auto refresh
        if config.autoreRefresh {
            //Constroi o timer
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true) { (timer) in
                self.showRandomQuote()
            }
        }
        
        showRandomQuote()
    }
    
    func showRandomQuote() {
        //Recupera o quote
        let quote = quotesManager.getRandomQuote()
        
        //Apresenta os dados na view
        lbQuotes.text = quote.quote
        lbAuthor.text = quote.author
        ivPhoto.image = UIImage(named: quote.image)
        ivPhotobg.image = UIImage(named: quote.image)
        
        //Para a animacao, deixa os controles incialmente transparentes
        lbQuotes.alpha = 0.0
        lbAuthor.alpha = 0.0
        ivPhoto.alpha = 0.0
        ivPhotobg.alpha = 0.0
        lcTop.constant = 50
        view.layoutIfNeeded()
        
        //Apos a animacao com 2.5 segundos, deixa os controles visiveis
        UIView.animate(withDuration: 2.5) {
            self.lbQuotes.alpha = 1.0
            self.lbAuthor.alpha = 1.0
            self.ivPhoto.alpha = 1.0
            self.ivPhotobg.alpha = 0.25
            self.lcTop.constant = 10
            self.view.layoutIfNeeded()
        }
    }
}
