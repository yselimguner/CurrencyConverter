//
//  ViewController.swift
//  CurrencyConverter19
//
//  Created by Yavuz Güner on 23.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var nzdLabel: UILabel!
    @IBOutlet weak var audLabel: UILabel!
    @IBOutlet weak var aedLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        //3 adımda yapacağız bütün işlerimizi.
        
        //1. Request & Session. Bulduğumuz web adresine gitmek öncelikli işimiz.
        //2. Response & Data . Bu gittiğimiz sitedeki datayı almak.
        //3. Parsing & JSON Serialization. Buradan aldığımız verileri işlemek.
        
        
        //1'inci Adımımız....
        let url = URL(string: "https://v6.exchangerate-api.com/v6/11f3b76f8347c3c48214cf36/latest/USD")
        
        let session = URLSession.shared
        //URLSession objesi oluşturucaz ve sınırsız işlem yapmamızı sağlar shared ile
        
        let task = session.dataTask(with: url!) { (data, response, error ) in
            //with url ile nereden aldığımızı. Completionhadler: Data'yı aldığı sonucu. Eğer hata varsa hatayı gösterir bize.
            if error != nil{
                //Eğer hata verirse uygulamamız
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                //2nci Adımımız
                //Eğer hata mesajımız yoksa....
                if data != nil{
                    //Eğer data boş değilse
                    
                    //Json result objesi oluşturucaz. Çünkü biz bu veriyi json formatında alıcaz ve işlememiz lazım..
                    do{
                        
                    
                   let jsonResponse = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any> //mutablecontainers'ı seçmemiz lazım
                    //try etmemizi istiyor. Bu kendi hali ile olmuyor.
                        
                        //ARKA PLANDA İŞLER YÜRÜSÜN DİYE BU ALTTAKİ İŞLEMİ YAPIYORUZ. FACE RECOGNIZE BÖLÜMÜNÜ İZLEYECEĞİM.
                        //async
                        DispatchQueue.main.async {
                            //print(jsonResponse)//Böyle yazınca jsonResponse any objedi geliyor. Biz bunu sözlük haline getireceğiz. Yukarıda dictionary olarak cast edicez.
                            //Burada yapacağımız şey rates bölümünden AUD,USD gibi net değerleri çekmek olacak. //142.DersTe2'nci dkda anlatıyor.
                            if let  rates = jsonResponse["conversion_rates"] as? [String : Any]{ //conversion_rates adını çektiğim veri dosyasından alacağız.
                               // print(rates)
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let eur = rates["EUR"] as? Double{
                                    self.eurLabel.text = "EUR: \(eur)"
                                }
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let aed = rates["AED"] as? Double{
                                    self.aedLabel.text = "AED: \(aed)"
                                }
                                if let aud = rates["AUD"] as? Double{
                                    self.audLabel.text = "AUD: \(aud)"
                                }
                                if let nzd = rates["NZD"] as? Double{
                                    self.nzdLabel.text = "NZD: \(nzd)"
                                }
                                if let trz = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(trz)"
                                }
                                    
                            }
                        }
                        
                    } catch {
                        print("Error")
                    }
                }
            }
        }
        
        
        
        task.resume()
    }
    
}

