//
//  RepoResultsTableViewCell.h
//  GithubDemo
//
//  Created by Henry Ching on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoResultsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *repoByLabel;
@property (weak, nonatomic) IBOutlet UILabel *repoDescText;
@property (weak, nonatomic) IBOutlet UIImageView *repoAvatarImage;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *forkLabel;
@end
