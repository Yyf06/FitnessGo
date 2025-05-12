# FITNESS GO
              
## Overview
Fitness Go is an innovative IOS mobile gacha game designed to promote physical activity through engaging gameplay. The app integrates daily physical activities(steps) with a gaming experience where players can earn equipments and automatically battle against with CPU(running race) by achieving real-world fitness goals. It's built with Swift and uses Apple's SpriteKit for rendering the game scenes.

## Features
- **Coin Exchange:** Converts daily steps into in-game currency.
- **Equipment Drawing:** Use currency to draw equipment that enhances your game win rate from the spinswheel.
- **Competitions:** Compete in running race against CPU based on your equipments, game will auto-battle after player chose their equipments.
- **Health Integration:** Syncs with Apple Health to track your walking steps, distance and sleeping time .etc.
- **Community:** Players are able to send friends requirment in the game rank page and chat with them.
- **UserLogin:** Players can sign up and sign in their accounts and able to switch the account. 

## Installation
Download Xcode from :- https://developer.apple.com/xcode/

```
git clone https://github.com/PPcatttt/DECO3801GIT.git
```

## Tools
xcode 15.4
Apple Swift version 5.10 

## Set Up
STEP 1 Open our FitnessGo.xcodeproj >> FitnessGo project >> Targets>> FitnessGo>> Signing & Capabilities >> Bundle Identifier >> Under Team, click add an account >> Log in with your apple ID 
STEP 2 Go to File under Navigation >> New>> Project >> new APP >> make sure team is your personal team >> create a bundle id >> Take note of this id 
STEP 3 Go to our FitnessGo.xcodeproj >> Project Target >> Change Team to Your ID and Bundler id to your bundler id
STEP 4 Click Manage run desitination >> Usb connects laptop to your phone >> trust computer >> 
    follow instructions on Xcode >> finish pairing 
STEP 5 Make sure your phone is selected as desitination >> click the play button to build
STEP 6 It should now open a fitnessgo app on your phone


## Usage
Once open FitnessGo.xcodeproj. On the top left, there is a play button. 

here are four buttons on the nav bar represents four main features, the first one is game. You can click the red spinswheel button the start your first draw. Also the Game Rule can direct you to the game rule page. The Play Game button can let you start to select you equipment. Once you selected your equipment and click the Start button, the run competition would automatically processing and show the result.

The second button on nav bar is health data, it will tracking all your health data from Apple Health. The Exchange button on the top right corner navigate you to the steps-coins exchange page.

The third button on the nav bar is the Coummnity, you can search and chat with your friends. You can even add new friends on the rankings.

The last button on the nav bar is User Profile, you can find your ID and all your user infomation here. When you meet some problems, you can click Help button and send an email to our customer serive. If you want to switch your account, you can also log out and back to the login page.

## Privacy and Data Security

- Apple Health Integration: Fitness Go requests access to Apple Health data, such as step count, running distance, and sleep hours, to enhance gameplay. This data is used solely for in-game purposes and is not shared with any third-party services.

- Data Usage: The health data is used locally to track progress, convert steps into in-game currency (coins), and display health stats within the app. Fitness Go does not store or transmit health data externally.

- Data Storage: All health data is processed and stored locally on the device. Fitness Go does not store any health data in cloud services or share it with external parties.

- User Consent: Users are required to grant permission to access Apple Health data. Permissions can be managed in the Apple Health app settings at any time.

- No Third-Party Sharing: Fitness Go does not share user data or health information with third parties. All health data remains private to the user and is used only for the gameplay experience.






# FitnessGo
