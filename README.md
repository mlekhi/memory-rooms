# 🎮 Memory Palace: A Nintendo-Style iOS Game for Your Significant Other!

## 📜 Overview
**Memory Palace** is a customizable, touchpad-controlled game for iOS, where you can create a virtual space filled with interactive objects that represent memories shared with your significant other. Walk around the world like a classic Nintendo-style game and interact with special objects to relive moments together.

## 🕹️ Gameplay
- Use a **touchpad-style controller** (bottom left) to move your character.
- Press the **interaction button** (bottom right) to interact with objects.
- Your **player is bound to the room**—there’s no exit, just a space to explore memories.

## ✨ Customization
You can customize your memory palace by adding **three types of objects**:

### 1️⃣ **Static Objects**
📌 These objects are purely decorative and help build the environment (e.g., furniture, walls, decorations).

#### 🔧 Example:
```swift
addStaticObject(image: "desk", size: CGSize(width: 50, height: 50), position: CGPoint(x: -50, y: 200))
```
➡️ This places a static "desk" in the game.

## 2️⃣ Interactive Objects (Single Image)
🖱️ Objects that display a message when interacted with, allowing you to attach a short memory or note.

#### 🔧 Example:
```swift
addInteractiveObject(image: "bed", size: CGSize(width: 200, height: 220), position: CGPoint(x: 150, y: 380), interactionText: "Hi! This is a bed")
```
➡️ Pressing the interaction button near this bed will show the text: "Hi! This is a bed."

## 3️⃣ Interactive Objects (Multiple Images)
🎞️ Objects that cycle through up to two additional images when interacted with, perfect for adding visual memories.

#### 🔧 Example:
```swift
let additionalImages: [UIImage] = [
    UIImage(named: "plant-1")!,
    UIImage(named: "plant-2")!,
    UIImage(named: "plant-3")!
]
addInteractiveObject(image: "plant", size: CGSize(width: 100, height: 100), position: CGPoint(x: -150, y: 100), interactionText: "This one has images", additionalImages: additionalImages)
```
➡️ Pressing the interaction button near this plant will cycle through images of plant-1, plant-2, and plant-3.

## 🚀 How to Play
Move Around: Use the touchpad (bottom left) to explore the room.

Interact: Press the interaction button (bottom right) near objects.

Explore Memories: Read messages and view images linked to each object.

## 🎨 Personalization Ideas:
- Place a bench where you first met.
- Add an album that shows photos from your favorite trip.
- Include a restaurant table where you had your first date.

Enjoy building your interactive memory palace! 💖
