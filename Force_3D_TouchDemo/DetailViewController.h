//
//  DetailViewController.h
//  Force_3D_TouchDemo
//
//  Created by Snow Wu on 11/25/15.
//  Copyright © 2015 rbbtsn0w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *detailItemTitle;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

