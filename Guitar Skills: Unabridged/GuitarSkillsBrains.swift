//
//  File.swift
//  Guitar Skills: Unabridged
//
//  Created by Alfredo J. Velasco on 11/8/15.
//  Copyright © 2015 Wolf Picks. All rights reserved.
//

import Foundation
import UIKit


class GuitarSkillsBrains{
    class HistoryList{
        var completedLessonsCount = 0
        var completedObjectivesCount = 0
        var skillDictionary = [String:(Int, Int)]() //maps skill name to a tuple (number of lessons in that skill, max level in that skill)

        var completedObjectivesIDs = [Int]()
        var completedLessonsIDs = [(Int,Character)]() //tuples: (lesson id, skill initial)
        
        func addCompletedObjective(objectiveID:Int) {
            completedObjectivesIDs.append(objectiveID)
            completedObjectivesCount++
        }
        
        func addCompletedLesson(lessonID:Int, skillInitial: Character) {
            completedLessonsIDs.append(lessonID, skillInitial)
            completedLessonsCount++
        }
    }
    
    class Catalog{
        var lessonCount = 0
        var objectiveCount = 0
        var lessonsArray = [(Int, Int, Character, String)]() //a list of tuples <lesson id, level id, skill initial, url of video>
        var objectivesArray = [(Int, String, String)]() //tuples of <objective id, url to objective preview video, url to objective video>
    }
    
    class UserInfo{
        var photo = UIImage()
        var priorities:String = "xxxx"
        
        func updatePriorities(fourCharString: String) {
            assert(fourCharString.characters.count==4)
            priorities = fourCharString
        }
    }
    
    var historyList = HistoryList()
    var catalog = Catalog()
    var userInfo = UserInfo()
    var emailToDBID = [String:String]()
    init(userInfo: AnyObject, lessons: AnyObject, objectives: AnyObject) {
        //TODO
        emailToDBID = ["alb@cf.com":"Uyj1gkFx9j", "bla@cf.com":"PQNanZBTym"]
    }
    
    func getNextLesson()-> String {
        if (historyList.completedLessonsCount == catalog.lessonCount) {
            return ""
        }
        let randNum = arc4random_uniform(10)
        var returnLessonID: Int = 0;
        var skill = String()
        if (randNum < 7) {
            // get the first priority
            skill = Array(arrayLiteral: userInfo.priorities)[0]
        } else if (randNum < 9) {
            //get the second priority
            skill = Array(arrayLiteral: userInfo.priorities)[1]
        } else if (randNum == 9) {
            skill = Array(arrayLiteral: userInfo.priorities)[2]
        } else {
            skill = Array(arrayLiteral: userInfo.priorities)[3]
        }
        //get the max level in that skill
        let maxLevel = historyList.skillDictionary[skill]
        var haveNotSelectedALesson: Bool = true
        for lesson: (Int, Int, Character, String) in catalog.lessonsArray {
            if (lesson.3 == skill) {
                //if this lesson has not been completed
                var notCompleted = true
                for completedLesson: (Int, Character) in historyList.completedLessonsIDs {
                    if (completedLesson.0 == lesson.0) {
                        notCompleted = false
                        break;
                    }
                }
                if (notCompleted) {
                    returnLessonID = lesson.0
                    haveNotSelectedALesson = false;
                }
            }
        }
        //if no lesson is selected in that skill (because the user has completed all lessons in that skill), a new lesson is selected
        if (haveNotSelectedALesson) {
        for lesson: (Int, Int, Character, String) in catalog.lessonsArray {
                var notCompleted = true
                for completedLesson: (Int, Character) in historyList.completedLessonsIDs {
                    if (completedLesson.0 == lesson.0) {
                        notCompleted = false
                        break;
                    }
                }
                if (notCompleted) {
                    returnLessonID = lesson.0
                    haveNotSelectedALesson = false;
                }
        }
        }
        // get the url of by lesson id TODO
        return ""
    }
    
    /**
     * returns stats that will be displayed in pie charts
     * element 0 of returned array: number of lessons completed in skill 1 (F)
     * element 1 of returned array: number of lessons completed in skill 2 (T)
     * element 2 of returned array: number of lessons completed in skill 3 (E)
     * element 3 of returned array: number of lessons completed in skill 4 (I)
     * element 4: max level in skill 1
     * element 5: max level in skill 2
     * element 6: max level in skill 3
     * element 7: max level in skill 4
     */
    func getProgress() -> [Double] {
        var ret = [Double](count: 8, repeatedValue: 0);
        for tuple:(Int, Character) in historyList.completedLessonsIDs {
            if (tuple.1 == "F") {
                ret[0]+=1
            } else if (tuple.1 == "T") {
                ret[1]+=1
            } else if (tuple.1 == "E") {
                ret[2]+=1
            } else {
                ret[3]+=1
            }
        }
        for element:(String,(Int,Int)) in historyList.skillDictionary {
            if (element.0 == "F") {
                ret[4] = Double(element.1.1)
            } else if (element.0 == "T") {
                ret[5] = Double(element.1.1)
            } else if (element.0 == "E") {
                ret[6] = Double(element.1.1)
            } else {
                ret[7] = Double(element.1.1)
            }
        }
        return ret;
    }
    
    /** sends updated userinfo to database; called by the controller on app exit (call this in (void)applicationDidEnterBackground:(UIApplication *)application):
    
        take historyList data and userInfo data and send DB update query
     */
    func updateUserInfoInDB() {
        //TODO
    }
    
    // return the url for the lesson id (index into the catalog and look for the url)
    func review(lessonID:Int) -> String {
        
        //TODO
        return ""
    }
    
    
    
}
