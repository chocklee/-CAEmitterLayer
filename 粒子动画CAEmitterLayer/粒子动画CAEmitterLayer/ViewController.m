//
//  ViewController.m
//  粒子动画CAEmitterLayer
//
//  Created by chocklee on 16/9/13.
//  Copyright © 2016年 北京超信. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAEmitterLayer *fireEmitter; // 发射器对象

@end

@implementation ViewController

/*
 一、粒子发射器
    iOS中的粒子效果有两部分组成，一部分为发射器，设置例子发射的宏观属性，另一部分是粒子单元，用于设置相应的粒子属性。粒子发射器是基于Layer层，叫CAEmitterLayer。
    CAEmitterLayer的属性介绍：
        @property(nullable, copy) NSArray<CAEmitterCell *> *emitterCells; 粒子单元数组
        @property float birthRate; 粒子的创建速率，默认为1/s
        @property float lifetime; 粒子的存活时间，默认为1s
        @property CGPoint emitterPosition; 发射器中心点在XY平面的位置
        @property CGFloat emitterZPosition; 发射器在Z平面的位置
        @property CGSize emitterSize; 发射器尺寸的大小
        @property CGFloat emitterDepth; 发射器的深度，在某些模式下会产生立体效果
        @property(copy) NSString *emitterShape; 发射器的形状
        @property(copy) NSString *emitterMode; 发射器的发射模式
        @property(copy) NSString *renderMode; 发射器的渲染模式
        @property BOOL preservesDepth; 是否开启三维空间效果
        @property float velocity; 粒子的运动速度
        @property float scale; 粒子的缩放大小
        @property float spin; 粒子的旋转位置
        @property unsigned int seed; 初始化随机的粒子种子
 */

/*
 二、粒子单元
    设置好粒子发射器后，还需要初始化一些粒子单元，设置具体粒子的属性，需要使用到的类是CAEmitterCell。
    CAEmitterCell的方法及属性介绍：
        + (instancetype)emitterCell; 类方法创建发射单元
        @property(nullable, copy) NSString *name; 设置发射单元的名称
        @property(getter=isEnabled) BOOL enabled; 是否允许发射器渲染
        @property float birthRate; 粒子的创建速率
        @property float lifetime; 粒子的存活时间
        @property float lifetimeRange; 粒子的生存时间容差
        @property CGFloat emissionLatitude; 粒子在Z轴方向的发射角度
        @property CGFloat emissionLongitude; 粒子在xy平面的发射角度
        @property CGFloat emissionRange; 粒子发射角度的容差
        @property CGFloat velocity; 粒子的速度
        @property CGFloat velocityRange; 粒子速度的容差
        @property CGFloat xAcceleration; x方向的加速度
        @property CGFloat yAcceleration; y方向的加速度
        @property CGFloat zAcceleration; z方向的加速度
        @property CGFloat scale; 缩放大小
        @property CGFloat scaleRange; 缩放容差
        @property CGFloat scaleSpeed; 缩放速度
        @property CGFloat spin; 旋转度
        @property CGFloat spinRange; 旋转容差
        @property(nullable) CGColorRef color; 粒子的颜色
        @property float redRange;
        @property float greenRange;
        @property float blueRange;
        @property float alphaRange; 粒子在RGB三个色相上的容差和透明度的容差
        @property float redSpeed;
        @property float greenSpeed;
        @property float blueSpeed;
        @property float alphaSpeed; 粒子在RGB三个色相上的变化速度和透明度的变化速度
        @property(nullable, strong) id contents; 渲染粒子，可以设置为一个CGImage的对象
        @property CGRect contentsRect; 渲染的范围
        @property CGFloat contentsScale; 渲染的比例
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // 设置发射器
    _fireEmitter = [CAEmitterLayer layer];
    _fireEmitter.emitterPosition = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 20);
    _fireEmitter.emitterSize = CGSizeMake(self.view.frame.size.width - 100, 20);
    /*
        RenderMode:发射器的渲染模式
            kCAEmitterLayerUnordered 粒子是无序出现的，多个发射源将混合
            kCAEmitterLayerOldestFirst 声明久的粒子会被渲染在最上层
            kCAEmitterLayerOldestLast 年轻的粒子会被渲染在最上层
            kCAEmitterLayerBackToFront 粒子的渲染按照Z轴的前后顺序进行
            kCAEmitterLayerAdditive 这种模式会进行粒子混合
     */
    _fireEmitter.renderMode = kCAEmitterLayerAdditive;
    // 发射单元
    // 火焰
    CAEmitterCell *fire = [CAEmitterCell emitterCell];
    fire.birthRate = 800;
    fire.lifetime = 2.0;
    fire.lifetimeRange = 1.5;
    fire.color = [UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1].CGColor;
    fire.contents = (id)[UIImage imageNamed:@"Ball_red"].CGImage;
    fire.name = @"fire";
    
    fire.velocity = 160;
    fire.velocityRange = 80;
    fire.emissionLongitude = M_PI + M_PI_2;
    fire.emissionRange = M_PI_2;
    fire.scaleSpeed = 0.3;
    fire.spin = 0.2;
    
    //烟雾
    CAEmitterCell *smoke = [CAEmitterCell emitterCell];
    smoke.birthRate = 400;
    smoke.lifetime = 3.0;
    smoke.lifetimeRange = 1.5;
    smoke.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.05].CGColor;
    smoke.contents = (id)[UIImage imageNamed:@"spark"].CGImage;
    smoke.name = @"smoke";
    
    smoke.velocity = 250;
    smoke.velocityRange = 100;
    smoke.emissionLongitude = M_PI + M_PI_2;
    smoke.emissionRange = M_PI_2;
    
    _fireEmitter.emitterCells = @[fire,smoke];
    [self.view.layer addSublayer:_fireEmitter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
