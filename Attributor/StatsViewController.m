//
//  StatsViewController.m
//  Attributor
//
//  Created by Quynh Nguyen on 29/09/2014.
//  Copyright (c) 2014 Quynh. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colourfulLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedLabel;
@end

@implementation StatsViewController

- (void) setTextToAnalyse:(NSAttributedString *)textToAnalyse
{
    _textToAnalyse = textToAnalyse;
    
    if (self.view.window) [self updateUI];
    //This is a very useful pattern to avoid updateUI being triggered twice
    //  i.e. in viewWillAppear and here
    // => updateUI will only be triggered if this scene is on screen, otherwise, it is going to be ignored
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *) charactersWithAttribute: (NSString *) attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyse length])
    {
        NSRange range;
        id value = [self.textToAnalyse attribute:attributeName
                                         atIndex:index
                                  effectiveRange:&range];
        if (value)
        {
            [characters appendAttributedString: [self.textToAnalyse attributedSubstringFromRange: range]];
            index = range.location + range.length;
        }
        else
        {
            index ++;
        }
    }
    return characters;
}

- (void) updateUI
{
    self.colourfulLabel.text = [NSString stringWithFormat: @"%d colourful charaters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    
    self.outlinedLabel.text = [NSString stringWithFormat: @"%d outlined charaters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
//    self.textToAnalyse = [[NSAttributedString alloc] initWithString: @"This is some test string"
//                                                         attributes: @{ NSForegroundColorAttributeName: [UIColor blueColor],
//                                                                        NSStrokeWidthAttributeName: @-4}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
