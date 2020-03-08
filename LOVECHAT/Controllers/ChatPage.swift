//
//  ChatPage.swift
//  LOVECHAT
//
//  Created by kittawat phuangsombat on 2020/3/1.
//  Copyright © 2020 kittawat phuangsombat. All rights reserved.
//


import UIKit
import Firebase


class ChatPage: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
        messageTextField.delegate = self
        
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
                self.messages = []
            
                if let e = error{
                    print("There was an issue retriving a data from firestore \(e)")
                }else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments{
                            let data = doc.data()
                            print(data)
                            
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                    
                                }
                               
                            }
                            
                        }
                        
                    }
                }
//
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        uploadData()
    }
    func uploadData() {
        if let messagebody = messageTextField.text, let messagesender = Auth.auth().currentUser?.email{
            messageTextField.text = ""
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messagesender,
                                                                      K.FStore.bodyField: messagebody,
                                                                      K.FStore.dateField: Date().timeIntervalSince1970])
            { (error) in
                if let e = error {
                    print("there was an issue saving data to firestore, \(e )")
                }else{
                    print("successfully save data")
                    
                    //reset the text field to make it empty after the data has been send off to cloud
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                        
                        
                    }
                }
                
            }
        }
    }
    
}

extension ChatPage : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        as! MessageCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.systemPink

        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor.red
            cell.label.textColor = UIColor.white
            
        }
     
        return cell 
    }
    
    
}
extension ChatPage: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       
        print(messageTextField.text!)
        uploadData()
        return true
    }
}
