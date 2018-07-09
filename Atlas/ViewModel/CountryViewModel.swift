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

struct SectionOfCountry {
    var header: String
    var items: [Item]
}

extension SectionOfCountry: SectionModelType {
    typealias Item = Country
    
    var identity: String {
        return header
    }
    
    init(original: SectionOfCountry, items: [Country]) {
        self = original
        self.items = items
    }
}

