//
//  Calc.m
//  Animal Age
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import "Calc.h"

@implementation Calc
@synthesize displayingFront;


- (void)viewDidLoad
{
    self.displayingFront = YES;
    
}

-(IBAction)showflip:(id)sender {
        
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  flipin = [defaults objectForKey:@"flipPref"];
    int flipValue = [flipin doubleValue];
    
    [UIView transitionWithView:self->masterFlip
                      duration:1.0
                       options:(displayingFront ? UIViewAnimationOptionTransitionFlipFromRight :
                                UIViewAnimationOptionTransitionFlipFromLeft)
                    animations: ^{
                        if(displayingFront)
                        {
                            self->frontView.hidden = true;
                            self->backView.hidden = false;
                            
                            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                            [defaults setBool:YES forKey:@"flipPref"];
                            NSLog(@"Flip Status 1: %d", flipValue);
                        }
                        else
                        {
                            self->frontView.hidden = false;
                            self->backView.hidden = true;
                            
                            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                            [defaults setBool:NO forKey:@"flipPref"];
                            NSLog(@"Flip Status 2: %d", flipValue);
                        }
                    }
     
                    completion:^(BOOL finished) {
                        if (finished) {
                            displayingFront = !displayingFront;
                            [self calcTapped];
                        }
                    }];
    
    
}

-(IBAction)closeKeyboard {
	//Here we are closing the keyboard for both of the textfields.
	[PeopleString resignFirstResponder];
}

-(void)hideHud:(NSTimer *)timer {
    
    [ProgressHUD dismiss];
}

-(void)dogAnswer:(NSTimer *)timer {
    
    [ProgressHUD showSuccess:nil];
    
    [self performSelector:@selector(hideHud:) withObject:nil afterDelay:.85];
    
}

- (IBAction)calcWithProg {
    
    [ProgressHUD show:nil];
    [self calcTapped];
    [self performSelector:@selector(dogAnswer:) withObject:nil afterDelay:.50];
    
}


- (IBAction)calcTapped {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString*  flipin = [defaults objectForKey:@"flipPref"];
    int flipValue = [flipin doubleValue];
    
    
    
    
    calcText.lineBreakMode = NSLineBreakByWordWrapping;
    calcText.numberOfLines = 0;
    
    NSString *buttonTitle = AnimalButt.currentTitle;

    
	NSString *secondString = PeopleString.text;
    NSString *thirdString = PeopleString2.text;
    
    //Here we are creating three doubles
	float num2;
	float answer;
    float y;
    
	//Here we are assigning the values

    if (flipValue == 0 ) {
        
        NSLog(@"Flip Status 1: %d", flipValue);
        num2 = [thirdString floatValue];
        
    } else {
        
        NSLog(@"Flip Status 2: %d", flipValue);
        num2 = [secondString floatValue];
    }

    
    // Dog Calculation
    
    if ([buttonTitle isEqualToString: @"Dog"]) {
        
        if (flipValue == 0 ) {
            
            // People Age to Animal
        
            y = ((num2>=21) ? ((num2-21)/4+2) : (num2/10.5));
            answer = (y * 100)/100;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField1 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            
             NSLog(@"Answer: %@", numField1);
            [PeopleString setText:numField1];

        } else {
            
            // Animal Age to People
            
            y = ((num2>=2) ? (21 + ((num2 - 2) * 4)) : (num2*10.5));
            answer = (y * 100)/100;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField2 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField2);
            [PeopleString2 setText:numField2];
            
        }
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadDogData()" ];
        
    // Cat Calculation
        
    } else if ([buttonTitle isEqualToString: @"Cat"]) {
        
            // People Age to Animal
        
        if (flipValue == 0 ) {
            
            if ((num2 >= 0) && (num2 <= 15)) {
                
                answer = 1;
                
                
            } else if ((num2 >= 16) && (num2 <= 24)) {
                
                answer = 2;
                
                
            } else {
                answer = ((num2 - 24)/4)+(2);
                
            }
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField1 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];

            NSLog(@"Answer: %@", numField1);
            [PeopleString setText:numField1];
            
        } else {
            
            // Animal Age to People
            
            
            if ((num2 >= 0) && (num2 <= 1)) {
                
                answer = 15;
                
                
            } else if ((num2 >= 1) && (num2 <= 2)) {
                
                answer = 24;
                
                
            } else {
                answer = ((num2 - 2)*4)+(24);
                
            }
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField2 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField2);
            [PeopleString2 setText:numField2];
        }
        
            // Trigger Web View Graph

            [webView stringByEvaluatingJavaScriptFromString: @"loadCatData()" ];
    
        
    // Cow Calculation
        
    } else if ([buttonTitle isEqualToString: @"Cow"]) {
        
         if (flipValue == 0 ) {
             
             // People Age to Animal
             
             answer = num2 * 6;
             
             // Perform Conversion
             
             NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
             [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
             NSString *numField1 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
             
             NSLog(@"Answer: %@", numField1);
             [PeopleString setText:numField1];
             
             
         } else {
             
             // Animal Age to People
             
             answer = num2 / 6;
             
             // Perform Conversion
             
             NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
             [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
             NSString *numField2 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
             
             NSLog(@"Answer: %@", numField2);
             [PeopleString2 setText:numField2];
             
         }

            // Trigger Web View Graph
        
            [webView stringByEvaluatingJavaScriptFromString: @"loadCowData()" ];
        
     // Rabbit Calculation
        
    } else if ([buttonTitle isEqualToString: @"Rabbit"]) {
        
        if (flipValue == 0 ) {
            
            // People Age to Animal
            
            answer = num2 * 9.25;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField1 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField1);
            [PeopleString setText:numField1];
            
        } else {
            
            // Animal Age to People
            
            answer = num2 / 9.25;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField2 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField2);
            [PeopleString2 setText:numField2];
            
        }
        
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadRabbitData()" ];
        
    // Duck Calculation
        
    } else if ([buttonTitle isEqualToString: @"Duck"]) {
        
        if (flipValue == 0 ) {
            
            // People Age to Animal
            
            answer = num2 * 6.25;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField1 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField1);
            [PeopleString setText:numField1];
            
        } else {
            
            // Animal Age to People
            
            answer = num2 / 6.25;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField2 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField2);
            [PeopleString2 setText:numField2];
            
        }
        
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadDuckData()" ];
    
    // Chicken Calculation
        
    } else {
        
        if (flipValue == 0 ) {
            
            // People Age to Animal
            
            answer = num2 * 8.12;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField1 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField1);
            [PeopleString setText:numField1];
            
        } else {
            
            // Animal Age to People
            
            answer = num2 / 8.12;
            
            // Perform Conversion
            
            NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
            [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
            NSString *numField2 = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
            
            NSLog(@"Answer: %@", numField2);
            [PeopleString2 setText:numField2];
            
        }
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadChickenData()" ];
    }
    

    
    NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
    [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
    NSString *string = [answerFormatter stringFromNumber:[NSNumber numberWithFloat:answer]];
    
    resultLabel.numberOfLines = 1;
    [resultLabel setMinimumScaleFactor:10.0/[UIFont labelFontSize]];
    resultLabel.adjustsFontSizeToFitWidth = YES;
    resultLabel.text =[NSString stringWithFormat:@"%@", string];
    
    if ([UIScreen mainScreen].scale == 2.f && [[UIScreen mainScreen] bounds].size.height-568)
    { [calcText setText:@""]; }
    else
    {
        if (flipValue == 0 ) {
            NSString *results = resultLabel.text;
            NSString *animal = AnimalButt.currentTitle;
            [calcText setText:[NSString stringWithFormat:@"You are %@ years old in %@ years", results, animal]];
        } else {
            NSString *results = resultLabel.text;
            NSString *animal = AnimalButt2.currentTitle;
            [calcText setText:[NSString stringWithFormat:@"Your %@ is %@ years old in Human years", animal, results]];
        }
    }
    
   
    
    
    
}

@end
