//
//  RepeatAnimationViewController.m
//  sampleAssetCatalog
//
//  Created by satoutakeshi on 2015/06/25.
//  Copyright (c) 2015年 satoutakeshi. All rights reserved.
//

#import "RepeatAnimationViewController.h"

@interface RepeatAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (nonatomic, assign) NSInteger count;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
- (IBAction)btnAnimation:(UIButton *)sender;
@end

@implementation RepeatAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//viewのautolayoutが終わったあとに呼ばれる。
//CALayerでアニメーションするならここで呼ぶとうまくいく
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //形をアニメーションすることを示すtransformを指定する
    CABasicAnimation *btnAnime = [CABasicAnimation animationWithKeyPath:@"transform"];
    //アニメーションにかかる時間(秒)を指定
    btnAnime.duration = 0.3;
    //膨張させる割合　前からx,y,z軸　普通に使う場合はzは1.0としておき、 1.1,1.1,1.0のように使う
    btnAnime.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)];
    //繰り返し回数　HUGE_VALFで永久に繰り返すこともできる
    btnAnime.repeatCount = HUGE_VAL;
    //アニメーションリバース設定　YESだと鼓動
    btnAnime.autoreverses = YES;
    //アニメーション実行
    [self.myButton.layer addAnimation:btnAnime forKey:@"blink"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnimation:(UIButton *)sender;
{
    
    self.count++;
    self.countLabel.text = [NSString stringWithFormat:@"カウント：%ld", self.count];
    
    //CABasicAnimationでラベルを消してみる
    if (self.count == 10) {
        
        CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAni.duration = 1.0;
        opacityAni.fromValue = @1.0;
        opacityAni.toValue = @0.0;
        
        //アニメーション実行
        [self.countLabel.layer addAnimation:opacityAni forKey:@"animateOpacity"];
        
        //消すオブジェクトのレイヤーも設定する。そうしないとアニメーション終わったあとにもとに戻る
        self.countLabel.layer.opacity = 0.0;
        
    }
    
}
@end
