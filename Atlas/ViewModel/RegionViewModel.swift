//
//  RegionListViewModel.swift
//  Atlas
//
//  Created by Pavel on 7/6/18.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct Region {
    var name: String
}

struct SectionOfRegion {
    var header: String
    var items: [Item]
}

extension SectionOfRegion: SectionModelType {
    typealias Item = Region
    
    var identity: String {
        return header
    }
    
    init(original: SectionOfRegion, items: [Region]) {
        self = original
        self.items = items
    }
}
