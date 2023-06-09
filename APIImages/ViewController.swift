//
//  ViewController.swift
//  APIImages
//
//  Created by DA MAC M1 157 on 2023/06/09.
//

import UIKit

class ViewController: UIViewController {
    
    
    var data = [ToDo]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingAPIData(URL: "https://api.opendota.com/api/herostats") { result in
            print(result)
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
        //guard let url = URL(string: "https://api.opendota.com/api/herostats") else { return }
    }
    
    func fetchingAPIData(URL url:String, completion: @escaping ([ToDo]) -> Void) {
        
        
        let url = URL(string: url)
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            print(data!)
            
            do {
                let parsingData = try? JSONDecoder().decode([ToDo].self, from: data!)
                completion(parsingData!)
               // print(parsingData!)
            } catch {
                print("Error decoding domain")
                print(error)
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let apiData:ToDo
        apiData = data[indexPath.row]
        let string = "https://api.opendota.com"+(apiData.img)
        let url = URL(string: string) 
        cell.apiImage.downloaded(from: url!, contentMode: .scaleToFill)
        
        cell.apiLabel.text = data[indexPath.row].localized_name
      //  cell.apiImage
        return cell
    }
}

//Download API Image
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
