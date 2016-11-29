//
//  RHShowViewController.m
//  哇呜
//
//  Created by zero on 16/7/16.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHShowViewController.h"
#import <LFLiveKit.h>
#import "RHStartLiveView.h"
#import "RHBottomToolView.h"
#import "RHLiewTopView.h"
@interface RHShowViewController ()<LFLiveSessionDelegate>

@property(nonatomic,strong) UIButton *closeBtn; //<关闭按钮
@property(nonatomic,strong) UIButton *startBtn; //<开始直播
@property(nonatomic,strong) RHStartLiveView *startView; //<开始直播
@property(nonatomic,strong) RHBottomToolView *bottomToolView; //<<#description#>
@property(nonatomic,strong) RHLiewTopView *topView; //<<#description#>


/** RTMP地址 */
@property (nonatomic, copy) NSString *rtmpUrl;
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, weak) UIView *livingPreView;
@end

@implementation RHShowViewController

- (UIView *)livingPreView
{
    if (!_livingPreView) {
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        livingPreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}

- (RHStartLiveView *)startView{
    if (!_startView) {
        _startView = [[RHStartLiveView alloc]init];
        __weak typeof(self) weakSelf = self;

        [_startView setClickPareType:^(PareLiveType type) {
            switch (type) {
                case PareLiveTypeClose:
                    [weakSelf cancelLive];
                    break;
                case PareLiveTypeTransCam:
                    [weakSelf transCam];
                    break;
                case PareLiveTypeAddPic:
                    
                    break;
                case PareLiveTypeStartLive:
                    [weakSelf setup];
                    break;
                    
                    
                default:
                    break;
            }
        }];
        [self.view addSubview:_startView];
        
    }
    return _startView;
}

- (RHBottomToolView *)bottomToolView{
    if (!_bottomToolView) {
        RHBottomToolView *bottomToolView = [[RHBottomToolView alloc]init];
        __weak typeof(self) weakSelf = self;
        [bottomToolView setClickToolBlock:^(LiveToolType type) {
            switch (type) {
                case LiveToolTypePublicTalk:

                    
                    break;
                case LiveToolTypePrivateTalk:
                    
                    break;
                case LiveToolTypeGift:
                    
                    break;
                case LiveToolTypeRank:
                    
                    break;
                case LiveToolTypeShare:
                    
                    break;
                case LiveToolTypeClose:
                    [weakSelf didClickLiveAction];
                    break;
                default:
                    break;
            }
        }];
        [self.view insertSubview:bottomToolView aboveSubview:self.livingPreView];
        [bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@-10);
            make.height.equalTo(@40);
        }];
        _bottomToolView = bottomToolView;
    }
    return _bottomToolView;
}

- (RHLiewTopView *)topView{
    if (!_topView) {
        RHLiewTopView *topView = [[RHLiewTopView alloc]initWithFrame:CGRectMake(0, 0, RHScreenWidth, 70)];

        [self.view insertSubview:topView aboveSubview:self.bottomToolView];

        _topView = topView;

    }
    return _topView;
}

- (LFLiveSession*)session{
    if(!_session){
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
//        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2] liveType:LFLiveRTMP];
//        
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration liveType:LFLiveRTMP];
         */
        
        // 设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
    }
    return _session;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidAppear:(BOOL)animated{
    // 默认开启后置摄像头,
    
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self setRepareLive];
    //[self setup];
}

- (void)setRepareLive{
    self.startView.hidden = NO;
}

- (void)setup{
    
    if (_startView) {
        _startView.hidden = YES;
        _startView = nil;
    }
    
    self.bottomToolView.hidden = NO;
    self.topView.hidden = NO;

    LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
    // 
    stream.url = @"rtmp://192.168.1.102:1935/rtmplive/room";
    self.rtmpUrl = stream.url;
    [self.session startLive:stream];
}


#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cancelLive{
    if (_startView) {
        _startView.hidden = YES;
        _startView = nil;
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];

}

- (void)transCam{
    AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    NSLog(@"切换前置/后置摄像头");
}

- (void)didClickLiveAction{
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    
    if (_startView) {
        _startView.hidden = YES;
        _startView = nil;
    }
    
    
    
    [self dismissViewControllerAnimated:NO completion:nil];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
