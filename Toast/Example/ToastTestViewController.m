//
//  ToastTestViewController.m
//  ToastTest
//
//  Copyright 2014 Charles Scalesse. All rights reserved.
//

#import "ToastTestViewController.h"
#import "UIView+Toast.h"

static NSString * ZOToastSwitchCellId   = @"ZOToastSwitchCellId";
static NSString * ZOToastDemoCellId     = @"ZOToastDemoCellId";

@interface ToastTestViewController ()

@property (strong, nonatomic) IBOutlet UIButton *activityButton;
@property (assign, nonatomic, getter=isShowingActivity) BOOL showingActivity;

@end

@implementation ToastTestViewController

#pragma mark - Constructors

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Toast";
        self.showingActivity = NO;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZOToastDemoCellId];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Events

- (void)handleTapToDismissToggled {
    [CSToastManager setTapToDismissEnabled:![CSToastManager isTapToDismissEnabled]];
}

- (void)handleQueueToggled {
    [CSToastManager setQueueEnabled:![CSToastManager isQueueEnabled]];
}

#pragma mark - UITableViewDelegate & Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 9;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"SETTINGS";
    } else {
        return @"DEMOS";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZOToastSwitchCellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:ZOToastSwitchCellId];
                UISwitch *tapToDismissSwitch = [[UISwitch alloc] init];
                tapToDismissSwitch.onTintColor = [UIColor orangeColor];
                [tapToDismissSwitch addTarget:self action:@selector(handleTapToDismissToggled) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = tapToDismissSwitch;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            }
            cell.textLabel.text = @"Tap to Dismiss";
            [(UISwitch *)cell.accessoryView setOn:[CSToastManager isTapToDismissEnabled]];
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZOToastSwitchCellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:ZOToastSwitchCellId];
                UISwitch *queueSwitch = [[UISwitch alloc] init];
                queueSwitch.onTintColor = [UIColor orangeColor];
                [queueSwitch addTarget:self action:@selector(handleQueueToggled) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = queueSwitch;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:16.0];
            }
            cell.textLabel.text = @"Queue Toast";
            [(UISwitch *)cell.accessoryView setOn:[CSToastManager isQueueEnabled]];
            return cell;
        }
    } else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ZOToastDemoCellId forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Make toast";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Make toast on top for 3 seconds";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Make toast with a title";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Make toast with an image";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"Make toast with a title and image";
        } else if (indexPath.row == 5) {
            cell.textLabel.text = @"Make toast with a custom style";
        } else if (indexPath.row == 6) {
            cell.textLabel.text = @"Show a custom view as toast";
        } else if (indexPath.row == 7) {
            cell.textLabel.text = @"Show an image as toast at point\n(110, 110)";
        } else if (indexPath.row == 8) {
            cell.textLabel.text = (self.isShowingActivity) ? @"Hide toast activity" : @"Show toast activity";
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        // Make toast
        [self.navigationController.view makeToast:@"This is a piece of toast."];
        
    } else if (indexPath.row == 1) {
        
        // Make toast with a duration and position
        [self.navigationController.view makeToast:@"This is a piece of toast on top for 3 seconds"
                                         duration:3.0
                                         position:CSToastPositionTop
                                            style:nil];
        
    } else if (indexPath.row == 2) {
        
        // Make toast with a title
        [self.navigationController.view makeToast:@"This is a piece of toast with a title."
                                         duration:2.0
                                         position:CSToastPositionTop
                                            title:@"Toast Title"
                                            image:nil
                                            style:nil
                                       completion:nil];
        
    } else if (indexPath.row == 3) {
        
        // Make toast with an image
        [self.navigationController.view makeToast:@"This is a piece of toast with an image."
                                         duration:2.0
                                         position:CSToastPositionCenter
                                            title:nil
                                            image:[UIImage imageNamed:@"toast.png"]
                                            style:nil
                                       completion:nil];
        
    } else if (indexPath.row == 4) {
        
        // Make toast with an image & title
        [self.navigationController.view makeToast:@"This is a piece of toast with a title & image"
                                         duration:2.0
                                         position:CSToastPositionBottom
                                            title:@"Toast Title"
                                            image:[UIImage imageNamed:@"toast.png"]
                                            style:nil
                                       completion:nil];
        
    } else if (indexPath.row == 5) {
        
        // Make toast with a custom style
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.messageFont = [UIFont fontWithName:@"Zapfino" size:14.0];
        style.messageColor = [UIColor redColor];
        style.messageAlignment = NSTextAlignmentCenter;
        style.backgroundColor = [UIColor yellowColor];
        
        [self.navigationController.view makeToast:@"This is a piece of toast with a custom style"
                                         duration:3.0
                                         position:CSToastPositionBottom
                                            style:style];
        
        // @NOTE: Uncommenting the line below will set the shared style for all toast methods:
        // [CSToastManager setSharedStyle:style];
        
    } else if (indexPath.row == 6) {
        
        // Show a custom view as toast
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 400)];
        [customView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)]; // autoresizing masks are respected on custom views
        [customView setBackgroundColor:[UIColor orangeColor]];
        
        [self.navigationController.view showToast:customView
                                         duration:2.0
                                         position:CSToastPositionCenter];
        
    } else if (indexPath.row == 7) {
        
        // Show an imageView as toast, on center at point (110,110)
        UIImageView *toastView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toast.png"]];
        
        [self.navigationController.view showToast:toastView
                                         duration:2.0
                                         position:[NSValue valueWithCGPoint:CGPointMake(110, 110)]]; // wrap CGPoint in an NSValue object
        
    } else if (indexPath.row == 8) {
        
        // Make toast activity
        if (!self.isShowingActivity) {
            [_activityButton setTitle:@"Hide Activity" forState:UIControlStateNormal];
            [self.navigationController.view makeToastActivity:CSToastPositionCenter];
        } else {
            [_activityButton setTitle:@"Show Activity" forState:UIControlStateNormal];
            [self.navigationController.view hideToastActivity];
        }
        _showingActivity = !self.isShowingActivity;
        
        [tableView reloadData];
    }
}

@end