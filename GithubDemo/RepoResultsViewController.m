//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "RepoResultsTableViewCell.h"
#import "SettingsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "UIImageView+AFNetworking.h"

@interface RepoResultsViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@property (weak, nonatomic) IBOutlet UITableView *repoTableView;
@property (atomic, strong) NSArray *repoData;
@end

@implementation RepoResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repoTableView.estimatedRowHeight = 100;
    //self.repoTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.searchSettings = [[GithubRepoSearchSettings alloc] init];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    [self doSearch];
}

- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GithubRepo fetchRepos:self.searchSettings successCallback:^(NSArray *repos) {
        /*
        for (GithubRepo *repo in repos) {
            NSLog(@"%@", [NSString stringWithFormat:
                   @"Name:%@\n\tStars:%ld\n\tForks:%ld,Owner:%@\n\tAvatar:%@\n\tDesc:%@\n\t",
                          repo.name,
                          repo.stars,
                          repo.forks,
                          repo.ownerHandle,
                          repo.ownerAvatarURL,
                          repo.repoDescription
                   ]);
        }
        */
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.repoData = repos;
        [self.repoTableView reloadData];
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"settingsSegway"])
    {
        // Get reference to the destination view controller
        SettingsViewController *vs = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        //NSDictionary *dataObj = self.responseData[self.rowselected];
        //NSString *urlString = dataObj[@"images"][@"low_resolution"][@"url"];
        //NSURL *url = [[NSURL alloc] initWithString: urlString];
        
        //NSLog(@"response: %@", url);
        //[vc setPhotoURL:url];
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repoData.count;
}

- (RepoResultsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepoResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.repocell"];
    GithubRepo *repoObj = self.repoData[indexPath.row];
    cell.repoTitleLabel.text = repoObj.name;
    cell.repoByLabel.text = repoObj.ownerHandle;
    cell.repoDescText.text = repoObj.repoDescription;
    [cell.repoAvatarImage setImageWithURL:[NSURL URLWithString:repoObj.ownerAvatarURL]];
    cell.starsLabel.text = [NSString stringWithFormat:@"%li", repoObj.stars];
    cell.forkLabel.text = [NSString stringWithFormat:@"%li", repoObj.forks];
    return cell;
}


@end
