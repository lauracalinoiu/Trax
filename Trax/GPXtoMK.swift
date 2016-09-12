//
//  GPXtoMK.swift
//  Trax
//
//  Created by Laura Calinoiu on 05/09/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import MapKit

extension GPX.Waypoint: MKAnnotation{
 
  var coordinate: CLLocationCoordinate2D{
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  var title: String?{
    return name
  }
  
  var subtitle: String?{
    return info
  }
  
  var thumbnailURL: NSURL?{
    return getImageURLofType("thumbnail")
  }
  
  private func getImageURLofType(type: String) -> NSURL?{
    for link in links{
      if link.type == type{
        return link.url
      } 
    }
    return nil
  }
  
  var imageURL: NSURL?{
    return getImageURLofType("large")
  }
}