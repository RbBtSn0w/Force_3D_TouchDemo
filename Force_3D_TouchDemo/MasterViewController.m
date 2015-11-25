//
//  MasterViewController.m
//  Force_3D_TouchDemo
//
//  Created by Snow Wu on 11/25/15.
//  Copyright © 2015 rbbtsn0w. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface PreviewDetail : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat preferredHeight;

@end

@implementation PreviewDetail



@end

@interface MasterViewController ()<UIViewControllerPreviewingDelegate>

@property NSArray<PreviewDetail*> *objects;

@property UIAlertController *alertController;
@end

@implementation MasterViewController

- (void)createDatas{
    
    
    PreviewDetail *PreviewDetail1 = [PreviewDetail new];
    PreviewDetail1.title = @"small";
    PreviewDetail1.preferredHeight = 160.0;
    
    PreviewDetail *PreviewDetail2 = [PreviewDetail new];
    PreviewDetail2.title = @"Medium";
    PreviewDetail2.preferredHeight = 320.0;
    
    PreviewDetail *PreviewDetail3 = [PreviewDetail new];
    PreviewDetail3.title = @"Large";
    PreviewDetail3.preferredHeight = 0.0;
    
    self.objects = @[PreviewDetail1, PreviewDetail2, PreviewDetail3];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self createDatas];
    
    [self checkForceTouchFeature];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)checkForceTouchFeature{
    
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else{
        self.alertController = [UIAlertController alertControllerWithTitle:@"3D Touch Not Available"
                                                                   message:@"Unsupported device."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    }
    
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PreviewDetail *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.detailItemTitle = object.title;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    PreviewDetail *object = self.objects[indexPath.row];
    cell.textLabel.text = object.title;
    return cell;
}


// MARK: UIViewControllerPreviewingDelegate Force Touch

// If you return nil, a preview presentation will not be performed
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {

    
    UIViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    if ([detailViewController isKindOfClass:[DetailViewController class]]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
         
            PreviewDetail *previewDetail = self.objects[indexPath.row];
            
            [(DetailViewController*)detailViewController setDetailItemTitle:previewDetail.title];
            
            /*
             Set the height of the preview by setting the preferred content size of the detail view controller.
             Width should be zero, because it's not used in portrait.
             */
            [(DetailViewController*)detailViewController setPreferredContentSize:CGSizeMake(0.0, previewDetail.preferredHeight)];
            
            // Set the source rect to the cell frame, so surrounding elements are blurred.
            previewingContext.sourceRect = cell.frame;
        }else{
            detailViewController = nil;
        }
    }
    else{
        detailViewController = nil;
    }
    
    return detailViewController;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

@end
