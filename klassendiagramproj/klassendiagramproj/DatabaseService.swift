//
//  DatabaseService.swift
//  klassendiagramproj
//
//  Created by Nino Vrijman on 10/06/16.
//  Copyright © 2016 River ice tea. All rights reserved.
//

import Foundation

public class DatabaseService {
    
    public static func validateLoginCredentials(username : NSString, password :String) -> Bool {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_login_2.php"
        let postString = "username=\(username)&password=\(password)"
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Login success");
            
            let userId:Int = jsonData.valueForKey("id") as! Int
            let userUsername:String = jsonData.valueForKey("username") as! String
            let userFirstName:String = jsonData.valueForKey("firstname") as! String
            let userLastName:String = jsonData.valueForKey("lastname") as! String
            
            let loggedInUser = User(id : userId, username: userUsername, firstName: userFirstName, lastName: userLastName)
            
            PersistenceService.store("LoggedInUser", value: loggedInUser)
            PersistenceService.store("LoggedInUserId", value: loggedInUser.id)
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Sign in failed : " + (error_msg as String))
            
            return false
        }
        
        return true
    }
    
    public static func registerUser(username : String, password : String, firstname : String, lastname : String) -> Bool {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_register.php"
        let postString:NSString = "username=\(username)&password=\(password)&firstname=\(firstname)&lastname=\(lastname)"
        
        NSLog(postString as String)
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Registration success");
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Registration failed : " + (error_msg as String))
            
            return false
        }
        
        return true
    }
    
    public static func insertPomodoro(learnSessionId : Int, startTime : String) -> Bool {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_insert_pomodoro.php"
        let postString:NSString = "learnSessionId=\(learnSessionId)&startTime=\(startTime)"
        
        NSLog(postString as String)
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Inserting pomodoro succeeded");
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Inserting pomodoro failed : " + (error_msg as String))
            
            return false
        }
        
        return true
    }
    
    public static func insertPomodoroData(pomodoroId : Int, description : String, value : String, unit : String, time : String) -> Bool {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_insert_pomodorodata.php"
        let postString:NSString = "pomodoroId=\(pomodoroId)&description=\(description)&value=\(value)&unit=\(unit)&time=\(time)"
        
        NSLog(postString as String)
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Inserting pomodoro data succeeded");
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Inserting pomodoro data failed : " + (error_msg as String))
            
            return false
        }
        
        return true
    }
    
    public static func insertSleepData(start : String, end : String, userId : Int) -> Bool {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_insert_sleepdata.php"
        let postString:NSString = "start=\(start)&end=\(end)&userId=\(userId)"
        
        NSLog(postString as String)
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Inserting sleep data succeeded");
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Inserting sleep data failed : " + (error_msg as String))
            
            return false
        }
        
        return true
    }
    
    public static func insertLearnSession(pomodoroLength : Int, shortBreakLength : Int, longBreakLength : Int, toDoItemId : Int) -> Bool {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_new_learnsession.php"
        let postString:NSString = "pomodoroLength=\(pomodoroLength)&shortBreakLength=\(shortBreakLength)&longBreakLength=\(longBreakLength)&toDoItemId=\(toDoItemId)"
        
        NSLog(postString as String)
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Inserting learning session succeeded");
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Inserting learning session failed : " + (error_msg as String))
            
            return false
        }
        
        return true
    }
    
    public static func insertToDoItem(title : String, description : String, estPmdAmount : Int, userId : Int, deadline : String) -> Int {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_new_todo_item.php"
        let postString:NSString = "title=\(title)&description=\(description)&estPmdAmount=\(estPmdAmount)&userId=\(userId)&deadline=\(deadline)"
        
        NSLog(postString as String)
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        let newId:NSInteger = jsonData.valueForKey("newId") as! NSInteger
        
        NSLog("Success code (0 = failed, 1 = succeeded): %ld", success);
        
        if(success == 1)
        {
            NSLog("Inserting learning session succeeded");
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Inserting learning session failed : " + (error_msg as String))
            
            return -1
        }
        
        return Int(newId)
    }
    
    public static func getToDoItems(userId : Int) -> Array<ToDoItem> {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_get_todo_items.php"
        let postString = "userId=\(userId)"
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code: %ld", success);
        
        var toDoItems:Array<ToDoItem> = []
        
        if(success == 1)
        {
            NSLog("getToDoItems succeeded");
            
            //  Een array van dictionaries (die een groupmember) wordt uit de value van de key "eventgroup_members" gehaald.
            let toDoItemsJSON:NSArray = jsonData.valueForKey("toDoItems") as! NSArray
            
            for toDoItem in toDoItemsJSON {
                //  De dictionary van een enkele groupmember wordt uitgelezen en omgezet naar een User object.
                let toDoItemId:Int = Int(toDoItem.valueForKey("id") as! String)!
                let title:String = toDoItem.valueForKey("title") as! String
                let description:String = toDoItem.valueForKey("description") as! String
                let estPmdAmount:Int = Int(toDoItem.valueForKey("estPomodorAmount") as! String)!
                let deadline:String = toDoItem.valueForKey("deadline") as! String
                let completedInt:Int = Int(toDoItem.valueForKey("completed") as! String)!
                
                var completedBool:Bool = false
                if (completedInt == 1) {
                    completedBool = true
                }
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let deadlineDate = dateFormatter.dateFromString(deadline)
                
                toDoItems.append(ToDoItem(id: toDoItemId, title: title, description: description, estAmount: estPmdAmount, deadline: deadlineDate!))
            }
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Getting to do items failed: " + (error_msg as String))
            
            return toDoItems
        }
        
        return toDoItems
    }
    
    public static func getLearnSessions(toDoItemId : Int) -> Array<LearnSession> {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_get_learnsessions.php"
        let postString = "toDoItemId=\(toDoItemId)"
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code: %ld", success);
        
        var learnSessions:Array<LearnSession> = []
        
        if(success == 1)
        {
            NSLog("getLearningSessions succeeded");
            
            //  Een array van dictionaries (die een groupmember) wordt uit de value van de key "eventgroup_members" gehaald.
            let learningSessionsJSON:NSArray = jsonData.valueForKey("learnsessions") as! NSArray
            
            for learningSession in learningSessionsJSON {
                //  De dictionary van een enkele groupmember wordt uitgelezen en omgezet naar een User object.
                let learnSessionId:Int = learningSession.valueForKey("id") as! Int
                let pomodoroLength:Int = learningSession.valueForKey("pomodoroLength") as! Int
                let shortBreakLength:Int = learningSession.valueForKey("shortBreakLength") as! Int
                let longBreakLength:Int = learningSession.valueForKey("longBreakLength") as! Int
                
                learnSessions.append(LearnSession(id: learnSessionId, pomodoroLength: pomodoroLength, shortBreakLenght: shortBreakLength, longBreakLenght: longBreakLength))
            }
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Getting learnsessions failed: " + (error_msg as String))
            
            return learnSessions
        }
        
        return learnSessions
    }
    
    public static func getPomodoroDataSets(pomodoroId : Int) -> Array<PomodoroData> {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_get_pomodorodatasets.php"
        let postString = "pomodoroId=\(pomodoroId)"
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code: %ld", success);
        
        var pomodoroDataSet:Array<PomodoroData> = []
        
        if(success == 1)
        {
            NSLog("getPomodoroDataSets succeeded");
            
            //  Een array van dictionaries (die een groupmember) wordt uit de value van de key "eventgroup_members" gehaald.
            let pomodoroDataSetJSON:NSArray = jsonData.valueForKey("pomodorodataset") as! NSArray
            
            for pomodoroData in pomodoroDataSetJSON {
                //  De dictionary van een enkele groupmember wordt uitgelezen en omgezet naar een User object.
                let pomodoroDataId:Int = pomodoroData.valueForKey("id") as! Int
                let description:String = pomodoroData.valueForKey("description") as! String
                let value:String = pomodoroData.valueForKey("value") as! String
                let unit:String = pomodoroData.valueForKey("unit") as! String
                
                let newData:PomodoroData = PomodoroData(id: pomodoroDataId, description: description, value: value)
                
                for enumValue in EUnit.EUnitValues {
                    if (enumValue.rawValue == unit) {
                        newData.unit = enumValue
                    }
                }
                
                pomodoroDataSet.append(newData)
            }
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Getting pomodorodatasets failed: " + (error_msg as String))
            
            return pomodoroDataSet
        }
        
        return pomodoroDataSet
    }
    
    public static func getPomodoros(learnSessionId : Int) -> Array<Pomodoro> {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_get_pomodoros.php"
        let postString = "learnSessionId=\(learnSessionId)"
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code: %ld", success);
        
        var pomodoros:Array<Pomodoro> = []
        
        if(success == 1)
        {
            NSLog("getPomodoros succeeded");
            
            //  Een array van dictionaries (die een groupmember) wordt uit de value van de key "eventgroup_members" gehaald.
            let pomodorosJSON:NSArray = jsonData.valueForKey("pomodoros") as! NSArray
            
            for pomodoro in pomodorosJSON {
                //  De dictionary van een enkele groupmember wordt uitgelezen en omgezet naar een User object.
                let pomodoroId:Int = pomodoro.valueForKey("id") as! Int
                let startTimeString:String = pomodoro.valueForKey("startTime") as! String
                
                //  Convert string to NSDate
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                
                let startTimeDate = dateFormatter.dateFromString(startTimeString)
                
                pomodoros.append(Pomodoro(id: pomodoroId, startTime: startTimeDate!))
            }
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Getting pomodoros failed: " + (error_msg as String))
            
            return pomodoros
        }
        
        return pomodoros
    }

    public static func getSleep(userId : Int) -> Array<SleepData> {
        let url = "https://www.ninovrijman.nl/nomi/phpScripts/nomi_get_sleepdata.php"
        let postString = "userId=\(userId)"
        
        let jsonData:NSDictionary = executeDatabaseAction(postString, phpUrl: url)
        
        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
        
        NSLog("Success code: %ld", success);
        
        var sleepDataSet:Array<SleepData> = []
        
        if(success == 1)
        {
            NSLog("getSleepData succeeded");
            
            //  Een array van dictionaries (die een groupmember) wordt uit de value van de key "eventgroup_members" gehaald.
            let sleepJSON:NSArray = jsonData.valueForKey("sleepdata") as! NSArray
            
            for sleep in sleepJSON {
                //  De dictionary van een enkele groupmember wordt uitgelezen en omgezet naar een User object.
                let sleepId:Int = sleep.valueForKey("id") as! Int
                let startSleepString:String = sleep.valueForKey("start") as! String
                let endSleepString:String = sleep.valueForKey("end") as! String
                
                //  Convert string to NSDate
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                
                let startSleepDate = dateFormatter.dateFromString(startSleepString)
                let endSleepDate = dateFormatter.dateFromString(endSleepString)
                
                sleepDataSet.append(SleepData(id: sleepId, start: startSleepDate!, end: endSleepDate!, restless: 0))
            }
        } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
                error_msg = jsonData["error_message"] as! NSString
            } else {
                error_msg = "Unknown Error"
            }
            NSLog("Getting sleepdata failed: " + (error_msg as String))
            
            return sleepDataSet
        }
        
        return sleepDataSet
    }
    
    private static func executeDatabaseAction(postData : NSString, phpUrl : String) -> NSDictionary {
        //  Meesturen van username en password
        let post:NSString = postData
        
        NSLog("Data sent with post: %@", post);
        
        let url:NSURL = NSURL(string: phpUrl)!
        
        let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        let postLength:NSString = String( postData.length )
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        //  Opvangen van de return data die de .php pagina terugstuurt
        var urlData: NSData?
        do {
            urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
        } catch let error as NSError {
            reponseError = error
            urlData = nil
        }
        
        if (urlData != nil) {
            let res = response as! NSHTTPURLResponse!
            
            NSLog("Response code: %ld", res.statusCode)
            //NSLog("Response message: \(res.debugDescription) ")
            
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                NSLog("Response message (JSON): %@", responseData);
                
                //  De teruggestuurde data is een dictionary in JSON formaat, deze wordt naar NSDictionary gecast zodat er in de code met deze
                //  gegevens gewerkt kan worden.
                var jsonData:NSDictionary = [:]
                do {
                    jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                } catch {
                    NSLog("Exception when converting urldata to JSON / NSDictionary")
                }
                
                return jsonData
            } else {
                NSLog("Execution failed : error code in response")
                return ["success":0]
            }
        } else {
            NSLog("Connection Failed, url : \(phpUrl)")
            return ["success":0]
        }

    }
}
