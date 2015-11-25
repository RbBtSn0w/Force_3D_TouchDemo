//
//  DetailViewController.m
//  Force_3D_TouchDemo
//
//  Created by Snow Wu on 11/25/15.
//  Copyright © 2015 rbbtsn0w. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item



- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItemTitle) {
        self.detailDescriptionLabel.text = self.detailItemTitle;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    
    
    if (self.splitViewController) {
        self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: Helper Methods

- (UIPreviewAction*)previewActionForTitle:(NSString*) title withStyle:(UIPreviewActionStyle)style {
    return [UIPreviewAction actionWithTitle:title style:style handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        if ([previewViewController isKindOfClass:[DetailViewController class]]) {
            id item = [(DetailViewController*)previewViewController detailItemTitle];
            NSLog(@"%@ triggered from DetailViewController for item:%@", action.title, [item description]);
        }
    }];
}

// MARK: Preview actions

- (NSArray <id <UIPreviewActionItem>> *)previewActionItems {
    
    UIPreviewAction *action1    = [self previewActionForTitle:@"Default Action" withStyle:UIPreviewActionStyleDefault];
    UIPreviewAction *action2    = [self previewActionForTitle:@"Destructive Action" withStyle:UIPreviewActionStyleDestructive];

    UIPreviewAction *subAction1 = [self previewActionForTitle:@"Sub Action 1" withStyle:UIPreviewActionStyleDefault];
    UIPreviewAction *subAction2 = [self previewActionForTitle:@"Sub Action 2" withStyle:UIPreviewActionStyleDefault];
    
    UIPreviewActionGroup *groupActions = [UIPreviewActionGroup actionGroupWithTitle:@"Sub Actions…" style:UIPreviewActionStyleDefault actions:@[subAction1, subAction2]];
    
    
    return @[action1, action2, groupActions];
}
@end
