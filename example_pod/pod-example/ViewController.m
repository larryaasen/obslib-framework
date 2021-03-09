//
//  ViewController.m
//  obslib-example
//
//  Created by Larry Aasen on 3/7/21.
//

#import "ViewController.h"
#import "setup_obs.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    CreateOBS();
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
