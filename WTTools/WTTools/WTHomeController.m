//
//  WTHomeController.m
//  WTTools
//
//  Created by tianmaotao on 2019/3/5.
//  Copyright © 2019年 tianmaotao. All rights reserved.
//

#import "WTHomeController.h"
@interface WTTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *img;
@end

@implementation WTTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.img];
        [self.contentView addSubview:self.label];
        [self layoutSubviewsConfigure];
    }
    return self;
}

- (void)layoutSubviewsConfigure {
    // imageView
    self.img.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *imgLeft = [NSLayoutConstraint constraintWithItem:self.img
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:15];
    NSLayoutConstraint *imgCenterX = [NSLayoutConstraint constraintWithItem:self.img
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0
                                                                   constant:0];
    NSLayoutConstraint *imgWidth = [NSLayoutConstraint constraintWithItem:self.img
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.img
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0
                                                                 constant:40];
    NSLayoutConstraint *imgHeight = [NSLayoutConstraint constraintWithItem:self.img
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.img
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:1.0
                                                                  constant:40];
    [self addConstraint:imgLeft];
    [self addConstraint:imgCenterX];
    [self.img addConstraint:imgWidth];
    [self.img addConstraint:imgHeight];
    
    // label
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:self.label
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.img
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0
                                                                  constant:8];
    NSLayoutConstraint *labelCenterX = [NSLayoutConstraint constraintWithItem:self.label
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0
                                                                     constant:0];
    [self addConstraint:labelLeft];
    [self addConstraint:labelCenterX];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"---";
    }
    
    return _label;
}

- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc] initWithFrame:CGRectZero];
        _img.image = [UIImage imageNamed:@"settings"];
    }
    return _img;
}

@end


@interface WTHomeController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleDatas;
@property (nonatomic, copy) NSArray *vcDatas;

@end

@implementation WTHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Home";
    self.titleDatas = @[@"FPS检测",
                        @"",
                        @"",
                        @"",
                        @""];
    self.vcDatas = @[
                     @"WTFPSController",
                     @"1",
                     @"",
                     @"",
                     @"",];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = [UIScreen mainScreen].bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewID" forIndexPath:indexPath];
    cell.label.text = self.titleDatas[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.vcDatas.count) {
        return;
    }
    
    switch (indexPath.row) {
        case 0: {
            NSString *vcString = self.vcDatas[indexPath.row];
            if (vcString && ![vcString isEqualToString:@""]) {
                Class vcClass = NSClassFromString(vcString);
                UIViewController *vc = [[vcClass alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
            
        case 1: {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"");
            });
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[WTTableViewCell class] forCellReuseIdentifier:@"tableviewID"];
    }
    return _tableView;
}

@end
