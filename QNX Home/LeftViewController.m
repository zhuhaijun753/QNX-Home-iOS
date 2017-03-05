//
//  LeftViewController.m
//  LGSideMenuControllerDemo
//

#import "LeftViewController.h"
#import "LeftViewCell.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "UIViewController+LGSideMenuController.h"
#import "ViewController.h"

@interface LeftViewController ()

@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) UIView *dash;
@property (retain, nonatomic) UIView *sen;
@property (retain, nonatomic) UIView *rel;


@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // -----
    
    self.titlesArray = @[@"Open Right View",
                         @"",
                         @"",
                         @"",
                         @"Dashboard",
                         @"Sensors",
                         @"Relays",
                         @"Automation\\Notifications",
                         @"User Account Settings",
                         @"System Configuration",
                         @"",
                         @"Logout"];
    
    
    // -----
    self.tableView.contentInset = UIEdgeInsetsMake(44.0, 0.0, 44.0, 0.0);
    //self.dash = [UIView new];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.titleLabel.text = self.titlesArray[indexPath.row];
    switch(indexPath.row){
        case 0:{
            break;
        }
        case 4:{
            [cell.imageView setImage:[UIImage imageNamed:@"home"]];
            break;
        }
        case 5:{
            [cell.imageView setImage:[UIImage imageNamed:@"sensor"]];
            break;
        }
        case 6:{
            [cell.imageView setImage:[UIImage imageNamed:@"relays"]];
            break;
        }
        case 7:{
            [cell.imageView setImage:[UIImage imageNamed:@"automation"]];
            break;
        }
        case 8:{
            [cell.imageView setImage:[UIImage imageNamed:@"user"]];
            break;
        }
        case 9:{
            [cell.imageView setImage:[UIImage imageNamed:@"settings"]];
            break;
        }
        case 11:{
            [cell.imageView setImage:[UIImage imageNamed:@"logout"]];
            break;
        }
    }
    cell.separatorView.hidden = (indexPath.row <= 3 || indexPath.row == self.titlesArray.count-1 || indexPath.row == 10);
    cell.userInteractionEnabled = (indexPath.row != 1 && indexPath.row != 3 && indexPath.row != 10 && indexPath.row != 2);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 10) ? 22.0 : 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewController *mainViewController = (MainViewController *)self.sideMenuController;
    
    if(!self.dash){
        self.dash = [UIView new];
        self.dash.backgroundColor = [UIColor whiteColor];
    }
    switch(indexPath.row){
        case 0:{
            if (mainViewController.isLeftViewAlwaysVisibleForCurrentOrientation) {
                [mainViewController showRightViewAnimated:YES completionHandler:nil];
            }
            else {
                [mainViewController hideLeftViewAnimated:YES completionHandler:^(void) {
                    [mainViewController showRightViewAnimated:YES completionHandler:nil];
                }];
            }
            break;
        }
        case 4:{
            mainViewController.rootViewController.childViewControllers[0].view = self.dash;
            [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
            break;
        }
        case 5:{
            UITableView *sensors = [UITableView new];
            mainViewController.rootViewController.childViewControllers[0].view = sensors;
            [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
            break;
        }
        case 6:{
            UITableView *relays = [UITableView new];
            mainViewController.rootViewController.childViewControllers[0].view = relays;
            [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
            break;
        }
        case 11:{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
            
            [navigationController setViewControllers:@[[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]]];
            
            LoginViewController *loginViewController = [storyboard instantiateInitialViewController];
            //loginViewController.rootViewController = navigationController;
            
            UIWindow *window = UIApplication.sharedApplication.delegate.window;
            window.rootViewController = loginViewController;
            
            [UIView transitionWithView:window
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
        }
    }
}

@end
