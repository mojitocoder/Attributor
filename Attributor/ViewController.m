//
//  ViewController.m
//  Attributor
//
//  Created by Quynh on 25/09/2014.
//  Copyright (c) 2014 Quynh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textEditor;

@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (IBAction)touchOutline:(UIButton *)sender
{
    [self.textEditor.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3,
                                                 NSStrokeColorAttributeName: [UIColor blackColor]}
                                         range: self.textEditor.selectedRange];
}

- (IBAction)touchUnOutline:(UIButton *)sender
{
    [self.textEditor.textStorage removeAttribute:NSStrokeWidthAttributeName
                                           range:self.textEditor.selectedRange];
}

- (IBAction)touchColour:(UIButton *)sender
{
    [self.textEditor.textStorage addAttribute:NSForegroundColorAttributeName
                                        value:sender.backgroundColor
                                        range:self.textEditor.selectedRange];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    // => outlets are set by this point
    // => will be called only once in the life cycle
    // => geometry is NOT set yet here - be careful
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes: @{NSStrokeWidthAttributeName: @3,
                            NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, title.length)];
    
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void) preferredFontsChanged: (NSNotification *) notification
{
    [self usePreferredFonts];
}

- (void) usePreferredFonts
{
    self.textEditor.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIContentSizeCategoryDidChangeNotification
                                                  object: nil];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(preferredFontsChanged:)
                                                 name: UIContentSizeCategoryDidChangeNotification
                                               object: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
