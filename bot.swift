import UIKit

class ViewController: UIViewController {

    var scoreLabel: UILabel!
    var timerLabel: UILabel!
    var score = 0
    var timer: Timer?
    var timeLeft = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        scoreLabel = UILabel(frame: CGRect(x: 20, y: 40, width: 100, height: 30))
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        timerLabel = UILabel(frame: CGRect(x: view.frame.width - 120, y: 40, width: 100, height: 30))
        timerLabel.textAlignment = .right
        timerLabel.text = "Time: 30"
        view.addSubview(timerLabel)
        
        startGame()
    }
    
    func startGame() {
        score = 0
        timeLeft = 30
        updateScoreLabel()
        updateTimerLabel()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        createCircle()
    }
    
    @objc func updateTimer() {
        timeLeft -= 1
        updateTimerLabel()
        
        if timeLeft == 0 {
            endGame()
        }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }
    
    func updateTimerLabel() {
        timerLabel.text = "Time: \(timeLeft)"
    }
    
    func createCircle() {
        let circleSize: CGFloat = 100
        let x = CGFloat.random(in: circleSize...(view.frame.width - circleSize))
        let y = CGFloat.random(in: 120...(view.frame.height - circleSize))
        
        let circle = UIView(frame: CGRect(x: x, y: y, width: circleSize, height: circleSize))
        circle.layer.cornerRadius = circleSize / 2
        circle.backgroundColor = randomPastelColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped(_:)))
        circle.addGestureRecognizer(tapGesture)
        circle.isUserInteractionEnabled = true
        
        view.addSubview(circle)
    }
    
    @objc func circleTapped(_ sender: UITapGestureRecognizer) {
        guard let circle = sender.view else { return }
        
        circle.removeFromSuperview()
        score += 1
        updateScoreLabel()
        
        createCircle()
    }
    
    func randomPastelColor() -> UIColor {
        let hue = CGFloat.random(in: 0...1)
        let saturation = CGFloat.random(in: 0.3...0.7)
        let brightness = CGFloat.random(in: 0.6...1.0)
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    func endGame() {
        timer?.invalidate()
        timer = nil
        
        let alertController = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default) { _ in
            self.startGame()
        }
        alertController.addAction(restartAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
