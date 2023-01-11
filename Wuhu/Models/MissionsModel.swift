//
//  MissionsModel.swift
//  Wuhu
//
//  Created by Awais on 04/06/2020.
//  Copyright © 2020 Afraz Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


class MissionsModel {
    
    var data : [MissionDatum]!
    var status : Bool!
    var upcoming : UpcomingMission!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [MissionDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = MissionDatum(fromJson: dataJson)
            data.append(value)
        }
        status = json["status"].boolValue
        let outcomesJson = json["upcoming_mission"]
        if !outcomesJson.isEmpty{
            upcoming = UpcomingMission(fromJson: outcomesJson)
        }
    }
}

class UpcomingMission {
    
    var completed : Bool!
    var longDescription : String!
    var missionDescription : String!
    var missionId : Int!
    var missionName : String!
    var missionType : String!
    var outcomes : Outcome!
    var startDate : String!
    var surveyId : String!
    var video : Video!
    var timeSecond : Int!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        completed = json["completed"].boolValue
        longDescription = json["long_description"].stringValue
        missionDescription = json["mission_description"].stringValue
        missionId = json["mission_id"].intValue
        timeSecond = json["time_in_seconds"].intValue
        missionName = json["mission_name"].stringValue
        missionType = json["mission_type"].stringValue
        let outcomesJson = json["outcomes"]
        if !outcomesJson.isEmpty{
            outcomes = Outcome(fromJson: outcomesJson)
        }
        startDate = json["start_date"].stringValue
        surveyId = json["survey_id"].stringValue
        let videoJson = json["video"]
        if !videoJson.isEmpty{
            video = Video(fromJson: videoJson)
        }
        
    }
}
class MissionDatum {
    
    var gameId : Int!
    var gameName : String!
    var missions : [Mission]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        gameId = json["game_id"].intValue
        gameName = json["game_name"].stringValue
        missions = [Mission]()
        let missionsArray = json["missions"].arrayValue
        for missionsJson in missionsArray{
            let value = Mission(fromJson: missionsJson)
            missions.append(value)
        }
    }
}
class Mission {
    
    var missionId : Int!
    var missionName : String!
    var missionDesc : String!
    var longDesc : String!
    var completed : Bool!
    var survey_id : String!
    var mission_type : String!
    var outcomes : Outcome!
    var video : Video!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        missionId = json["mission_id"].intValue
        missionName = json["mission_name"].stringValue
        mission_type = json["mission_type"].stringValue
        missionDesc = json["mission_description"].stringValue
        longDesc = json["long_description"].stringValue
        completed = json["completed"].boolValue
        survey_id = json["survey_id"].stringValue
        let outcomesJson = json["outcomes"]
        if !outcomesJson.isEmpty{
            outcomes = Outcome(fromJson: outcomesJson)
        }
        
        let videoJson = json["video"]
        if !videoJson.isEmpty{
            video = Video(fromJson: videoJson)
        }
    }
}
class Video {
    var videoId : Int!
    var vedioUrl : String!
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        videoId = json["video_id"].intValue
        vedioUrl = json["video_url"].stringValue
    }
}
class Outcome {
    
    var badgeId : Int!
    var badgeImage : String!
    var badgeName : String!
    var percentage : Int!
    var points : Int!
    var stateName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        badgeId = json["badge_id"].intValue
        badgeImage = json["badge_image"].stringValue
        badgeName = json["badge_name"].stringValue
        percentage = json["percentage"].intValue
        points = json["points"].intValue
        stateName = json["state_name"].stringValue
        
    }
}
