//
//  ForkModel.swift
//  GitReposViewer
//
//  Created by Abdelrahman Hussein on 24/04/2021.
//


// MARK: - ForkModelElement
struct ForkModel: Decodable {
    let id: Int
    let nodeID: String
    let name: ForkModelName
    let fullName: String
    let forkModelPrivate: Bool
    let owner: RepositoryOwnerModel
    let htmlURL: String
    let forkModelDescription: String
    let fork: Bool
    let url, forksURL: String
    let keysURL, collaboratorsURL: String
    let teamsURL, hooksURL: String
    let issueEventsURL: String
    let eventsURL: String
    let assigneesURL, branchesURL: String
    let tagsURL: String
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String
    let statusesURL: String
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String
    let subscriptionURL: String
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String
    let contentsURL, compareURL: String
    let mergesURL: String
    let archiveURL: String
    let downloadsURL: String
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String
    let labelsURL, releasesURL: String
    let deploymentsURL: String
    let gitURL, sshURL: String
    let cloneURL: String
    let svnURL: String
    let homepage: String
    let size, stargazersCount, watchersCount: Int
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool
    let hasPages: Bool
    let forksCount: Int
    let archived, disabled: Bool
    let openIssuesCount: Int
    let forks, openIssues, watchers: Int
    let defaultBranch: DefaultBranch

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case forkModelPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case forkModelDescription = "description"
        case fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case forksCount = "forks_count"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
    }
}

enum DefaultBranch: String, Codable {
    case master = "master"
}

enum Key: String, Codable {
    case mit = "mit"
}

enum LicenseName: String, Codable {
    case mitLicense = "MIT License"
}

enum NodeID: String, Codable {
    case mDc6TGljZW5ZZTEz = "MDc6TGljZW5zZTEz"
}

enum SpdxID: String, Codable {
    case mit = "MIT"
}

enum ForkModelName: String, Codable {
    case grit = "grit"
}
