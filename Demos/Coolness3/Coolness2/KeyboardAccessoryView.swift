import UIKit

class KeyboardAccessoryView: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        observeNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        observeNotifications()
    }
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
    func observeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didUndo(notification:)),
                                               name: NSNotification.Name.NSUndoManagerDidUndoChange,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didRedo(notification:)),
                                               name: NSNotification.Name.NSUndoManagerDidRedoChange,
                                               object: nil)
    }
    
    @objc func didUndo(notification: Notification) {
        guard let undoManager = notification.object as? UndoManager else { return }
        undoButton.isEnabled = undoManager.canUndo
        redoButton.isEnabled = undoManager.canRedo
    }
    @objc func didRedo(notification: Notification) {
        guard let undoManager = notification.object as? UndoManager else { return }
        redoButton.isEnabled = undoManager.canRedo
        undoButton.isEnabled = undoManager.canUndo
    }
}
