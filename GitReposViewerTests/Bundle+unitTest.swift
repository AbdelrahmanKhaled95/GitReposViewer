//
//  Bundle+unitTest.swift
//  GitReposViewerTests
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//

import Foundation

extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: RepoListViewModelTests.self)
    }
}
