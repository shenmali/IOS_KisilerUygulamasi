//
//  ViewController.swift
//  KisilerUygulamasi
//
//  Created by MaSheN on 9.08.2022.
//

import UIKit

class AnasayfaVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var kisilerTableView: UITableView!
    
    var kisilerListe = [Kisiler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let k1 = Kisiler(kisi_id: 1, kisi_ad: "ahmet", kisi_tel: "11111")
        let k2 = Kisiler(kisi_id: 2, kisi_ad: "mehmet", kisi_tel: "22222")
        let k3 = Kisiler(kisi_id: 3, kisi_ad: "zeynep", kisi_tel: "33333")
        
        kisilerListe.append(k1)
        kisilerListe.append(k2)
        kisilerListe.append(k3)
    }


  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let kisi = sender as? Kisiler
            let gidilecekVC = segue.destination as! KisiDetayVC
            gidilecekVC.kisi = kisi
        }
    }
    

}

extension AnasayfaVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("Arama Sonucu: \(searchText)")
    }
}

extension AnasayfaVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListe[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "kisilerHucre", for: indexPath) as! TableViewHucre
        
        hucre.kisiBilgiLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        return hucre
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kisi = kisilerListe[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: kisi)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){(contextualAction,view,bool) in
            let kisi = self.kisilerListe[indexPath.row]
            
            let alert = UIAlertController(title: "Silme Islemi", message: "\(kisi.kisi_ad!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "Iptal", style: .cancel) {
                action in }
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){
                action in
                print("\(kisi.kisi_ad!) silindi")
                //self.kisilerListe.remove(at: indexPath.row)
                //tableView.reloadData()
            }
            
            alert.addAction(evetAction)
            
            alert.addAction(iptalAction)
            self.present(alert, animated: true)
            
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}

