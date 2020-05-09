Group Project
===

# APARTLY

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A productivity app that is designed to keep any individual on track of work during quarantine.
Users will be able to join study/work rooms with specific tags with a global productivity timer (Pomodoro method) or rooms with a silent video calling feature. The rooms are designed to create a sense time and community that might be lacking in this time of quarantine.

### App Evaluation

- **Category:** Productivity
- **Mobile:** This app would be primarily developed for mobile but would perhaps be just as viable on a computer as a website. Functionality wouldn't be limited to mobile devices as long as the device contains a built in camera/microphone. However mobile version could potentially have more features.
- **Story:** Connects users who work on similar tasks in break-out rooms.
- **Market:** Any individual who wants to become more productive at home. 
- **Habit:** This app could be used as often or unoften as the user wanted depending on how deep their workload is, and what exactly they’re looking for.
- **Scope:** On register, first we would ask the user to choose tags that they are interested in (subject areas, everyday goals, working tasks), then create a personalized home page for each user based on their interests.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Login page (DONE) http://g.recordit.co/UQtXtzmK8u.gif  (DONE)
* User logs in to access their home page where recommended study rooms are available (DONE)
* User picks their study rooms with a global timer (DONE) http://g.recordit.co/fSfsCjysc1.gif
* User picks their study rooms with a video chat  (SCRAPPED) http://g.recordit.co/u0S8mkzPYw.gif
* Personalized/ default home page for each user. (DONE)
* Profile pages for each user (DONE)
* Settings (Accessibility, Notification, General, etc.) (SCRAPPED)

**Optional Nice-to-have Stories**

* Users can collect points based on their study time/habits and level up; each level up unlocks additional features of the app (create own room)
* Chat rooms inside study rooms
* Star feature where user can save their favourite study room
* Friend feature; users can create personal rooms with friends
* User can make study related posts where other people can like and comment (focuses on the sense of community)

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account 
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their profile information to join study rooms.
   * User will be asked to click on the tags they are interested in to get a more personalized home page.
* Home page - A display of various study rooms where users can choose to join
   * Table view of study rooms with cover picture, title, and description
* Profile Screen
   * Allows user to upload a photo and fill in information and change interest tags
   * Progress bar for point collection
* Study Room with timer
   * At the middle of screen user sees a global timer either in break/study.
   * At the bottom of screen shows a list of users in the same study room.
* Study Room with video chat
   * Table view of users video camera

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home page (room selection)
* Profile
* Settings

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Room Selection -> Popup for timer or video room -> Jumps to Chat
* Profile -> Text field to be modified. 
* Settings -> Toggle settings

## Wireframes
<img src="https://imgur.com/FqsWb9J.png" width=600>
<img src="https://imgur.com/Gbuv6jU.png" width=600>

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]

### Models
Property  |  Type  |          Description  
---------------------------------------------------
email       String          email for login
password    String        password for login
username    String         user's profile name
tags        Array        stores user's interests
profilePic  File            profile picture
description String        profile description
roomUsers   Array         users in the same room

### Networking
Sign up Screen
---------------
  - (Create/Post) - create a new account (save email and password)
  
          var user = PFUser()
          user.username = username.text
          user.password = password.text
          user.signUpInBackground { (success, error) in
              if success{
                  self.performSegue(withIdentifier: "loginSegue", sender: self)
              }
              else{
                  print("Something went wrong signing up \(error?.localizedDescription)")
              }
          }

 Sign in screen:
 ---------------
   - (Read/Get) - user email and possword to sign in
    
          let usernameText = username.text
          let passwordText = password.text
        
          PFUser.logInWithUsername(inBackground: usernameText!, password: passwordText!) { (user, error) in
            if(user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: self)
              }
            else{
                  print("Something went wrong logging in \(error?.localizedDescription)")
             }
           }
         }
 
  
Home Feed Screen
-----------------
  - (Read/Get) - Fetching tags for user's feed
  
        let query = PFQuery(className:"Tag")
        query.whereKey("username", equalTo: currentUser)
        query.order(byDescending: "priority")
        query.findObjectsInBackground { (tags: [PFObject]?, error: Error?) in
           if let error = error { 
              print(error.localizedDescription)
           } else if let tag = tags {
              print("Successfully retrieved \(tags.count) tags.")
          // TODO: Do something with tags...
           }
        }
        
  - (Read/Get) - username and profile pic
  
Time Screen
------------
  - (Read/Get) - usernames appear in study room

Video Screen
------------
  - (Read/Get) - usernames appear in study room
  - (Create/Post) - create a zoom room
  
Profile Screen
--------------
  - (Read/Get) - username, profile pic, and description
  

  
  
