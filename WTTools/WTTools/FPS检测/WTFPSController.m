//
//  WTFPSController.m
//  WTTools
//
//  Created by tianmaotao on 2019/3/5.
//  Copyright © 2019年 tianmaotao. All rights reserved.
//

#import "WTFPSController.h"

@interface WTFPSLabel : UILabel
@property (nonatomic, strong) CADisplayLink * displayLink;
- (void)stopDisplayLink;
@end

@implementation WTFPSLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.font = [UIFont fontWithName:@"AppleGothic" size:13];
        self.textAlignment = NSTextAlignmentCenter;
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)onDisplayLink:(CADisplayLink *)link {
    //屏幕刷新次数
    static NSInteger frameCount = 0;
    //前一次记录时间戳
    static CGFloat lastTimestamp = 0;
    
    frameCount++;
    if(lastTimestamp == 0){
        lastTimestamp = link.timestamp;
        return;
    }
    
    // 前一次和当前的时间间隔
    CFTimeInterval timePassed = link.timestamp - lastTimestamp;
    
    // 当时间间隔大于1秒的时候才去计算帧
    if(timePassed >= 0.5) {
        //// 帧数 = 这两次刷新的帧总数 / 屏幕前后某两次刷新的间隔时间
        CGFloat fps = frameCount / timePassed;
        self.text = [NSString stringWithFormat:@"FPS:%.0f", fps];
        
        //重置屏幕刷新次数和记录最后一次时间戳
        lastTimestamp = link.timestamp;
        frameCount = 0;
    }
}

- (void)stopDisplayLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end

@interface WTFPSController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WTFPSLabel *FPSLabel;
@end

@implementation WTFPSController
- (void)dealloc {
    [self.FPSLabel stopDisplayLink];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.FPSLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    self.FPSLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 64, 50, 30);
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld 模拟界面卡顿 实时FPS监控", indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"user"];
    for (int i = 0; i < 5000; i++) {
        // 模拟界面卡顿
        UIView *view = [[UIView alloc] init];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableviewID"];
    }
    return _tableView;
}

- (WTFPSLabel *)FPSLabel {
    if (!_FPSLabel) {
        _FPSLabel = [[WTFPSLabel alloc] initWithFrame:CGRectZero];
    }
    return _FPSLabel;
}

@end
