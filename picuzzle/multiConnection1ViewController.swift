//
//  multiConnection1ViewController.swift
//  picuzzle
//
//  Created by dipt on 2016-12-06.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class multiconnection1ViewController: UIViewController,MCSessionDelegate,MCBrowserViewControllerDelegate,UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    
    
    
    var images = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        title = "Connect"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(multiconnection1ViewController.showConnectionPrompt))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(multiconnection1ViewController.importPicture))
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath) as UICollectionViewCell
        if let imageView = cell.viewWithTag(1000) as? UIImageView  {
            imageView.image = images[indexPath.item]
        }
        return cell
    }
    
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
    func sendImage(img: UIImage) {
        if mcSession.connectedPeers.count > 0 {
            if let imageData = UIImagePNGRepresentation(img) {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let image = UIImage(data: data as Data){
            DispatchQueue.main.async { [unowned self] in
                self.images.insert(image, at: 0)
                //self.collectionView.reloadData()
            }
        }
    }
    func startHosting(action: UIAlertAction!) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "Connection", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
    }
    
    func joinSession(action: UIAlertAction!) {
        let mcBrowser = MCBrowserViewController(serviceType: "Connection", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    func showConnectionPrompt(){
        let ac = UIAlertController(title: "Connect to athoers", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session",style: .default,handler:startHosting))
        ac.addAction(UIAlertAction(title: "Join a session",style: .default,handler:joinSession))
        ac.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler:nil))
        present(ac,animated:true,completion: nil)
    }
    func importPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated:true,completion:nil)
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : Any]) {
        var newImage: UIImage
        /*if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
         newImage = possibleImage
         }else if let possibleImage = info["UIImagePickerControllerOriginalImage"]as UIImage{
         newImage = possibleImage
         }
         else {
         return
         }
         dismiss(animated: true, completion: nil)
         images.insert(newImage,at:0)
         collectionView.reloadData()*/
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismissViewControllerAnimated(true,completion: nil)
    }
    
    
    
    
    
}
