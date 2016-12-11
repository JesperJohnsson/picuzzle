//
//  LobbyViewController.swift
//  picuzzle
//
//  Created by Dennis Rojas on 2016-12-10.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class LobbyViewController: UIViewController, MCSessionDelegate,MCBrowserViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBAction func testAct(_ sender: Any) {
        print("************************")
        //print(self.mcSession.connectedPeers)
        //self.test = "dsa"
        //self.messageCl.setMessage(message: "bajskorv")
        print(self.messageCl?.getMessage())
        
        //self.player1.text = self.peerID.displayName
        //self.player2.text = String(describing: self.mcSession.connectedPeers[0].displayName)
    }
    
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    
    var messageCl: Message?{
        willSet(newValue){
            print("--------------JAPP--------------------")
            print(newValue)
        }
        didSet{
            print("fuckt his shit")
        }
    }
    
    var test: String?{
        willSet(newValue) {
            print("--------------NYTT VÄRDE--------------------")
            print(newValue)
        }
        didSet{
            print("--------------OLD VÄRDE--------------------")
            print(oldValue)
        }
    }
    
    
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    
    @IBAction func sendMessageAction(_ sender: Any) {
        self.sendMessages(message: "Hej")
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        let observerKeyLocation = "message"
        //self.messageCl.message.addObserver(self, forKeyPath: observerKeyLocation, options: .new, context: nil)
        var mes = self.messageCl?.copy() as! Message
        self.messageCl = Message()
        self.messageCl = mes
    }
    
    func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
        print("-------------------------------")
        print("JAPPPP")
        let observerKeyLocation = "message"
        if keyPath == observerKeyLocation {
            print("HEJEJJJEJEJEJEJE")
        }
    }
    
    /* START SESSION */
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
    
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
            case MCSessionState.connected:
                    print("Connected: \(peerID.displayName)")
            case MCSessionState.connecting:
                    print("Connecting: \(peerID.displayName)")
            case MCSessionState.notConnected:
                    print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        //let dictionary: [String: AnyObject] = ["data": data as AnyObject, "fromPeer": peerID]
        
        let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: data) as! [String : Any]
        print(dictionary)
        
        print(dictionary)
        if (data != nil) {
            DispatchQueue.main.async { [unowned self] in
                // do something with the image
                print(data)
            }
        }
    }
    
    
    func sendMessages(message: String) {
        print("INSIDE MESSAGE FUNCTION")
        print(mcSession.connectedPeers.count)
        var hej = NSArray(objects: "Time Attack", "Time Trial", "Multiplayer")
        
        var dictionaryExample : [String:AnyObject] = ["user":"UserName" as AnyObject, "pass":"password" as AnyObject, "token":"0123456789" as AnyObject, "image":0 as AnyObject]
        
        let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: dictionaryExample)
        //let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: dataExample) as! [String : Any]
        
        
        
        if mcSession.connectedPeers.count > 0 {
            
            //let json = try? JSONSerialization.data(withJSONObject: message, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            do {
                try mcSession.send(dataExample, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch let error as NSError {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
        
    }
}
