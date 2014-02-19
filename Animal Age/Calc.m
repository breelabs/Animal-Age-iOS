//
//  Calc.m
//  Animal Age
//
//  Created by Jon Brown on 2/17/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

#import "Calc.h"

@implementation Calc

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


- (IBAction)calcTapped {
    
    [ProgressHUD show:nil];
    
    calcText.lineBreakMode = NSLineBreakByWordWrapping;
    calcText.numberOfLines = 0;
    
    NSString *buttonTitle = AnimalButt.currentTitle;

	NSString *secondString = PeopleString.text;
    
    //Here we are creating three doubles
	float num2;
	float answer;
    float y;
    
	//Here we are assigning the values

	num2 = [secondString doubleValue];
    
    // Dog Calculation
    
    if ([buttonTitle isEqualToString: @"Dog"]) {
        
            // People Age to Animal
        
            y = ((num2>=21) ? ((num2-21)/4+2) : (num2/10.5));
            answer = (y * 100)/100;
        
            // Trigger Web View Graph
        
            [webView stringByEvaluatingJavaScriptFromString: @"loadDogData()" ];
    
        
    // Cat Calculation
        
    } else if ([buttonTitle isEqualToString: @"Cat"]) {
        
            // People Age to Animal
        
        
        if ((num2 >= 0) && (num2 <= 15)) {
            
            answer = 1;
            
            
        } else if ((num2 >= 16) && (num2 <= 24)) {
            
            answer = 2;
            
            
        } else {
            answer = ((num2 - 24)/4)+(2);
            
        }
        
            // Trigger Web View Graph

            [webView stringByEvaluatingJavaScriptFromString: @"loadCatData()" ];
    
        
    // Cow Calculation
        
    } else if ([buttonTitle isEqualToString: @"Cow"]) {
        
            // People Age to Animal
        
            answer = num2 * 6;
        
            // Trigger Web View Graph
        
            [webView stringByEvaluatingJavaScriptFromString: @"loadCowData()" ];
        
     // Rabbit Calculation
        
    } else if ([buttonTitle isEqualToString: @"Rabbit"]) {
        
        // People Age to Animal
        
        answer = num2 * 9.25;
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadRabbitData()" ];
        
    // Duck Calculation
        
    } else if ([buttonTitle isEqualToString: @"Duck"]) {
        
        // People Age to Animal
        
        answer = num2 * 6.25;
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadDuckData()" ];
    
    // Chicken Calculation
        
    } else {
        
        // People Age to Animal
        
        answer = num2 * 8.12;
        
        // Trigger Web View Graph
        
        [webView stringByEvaluatingJavaScriptFromString: @"loadChickenData()" ];
    }
    

    
    NSNumberFormatter *answerFormatter = [[NSNumberFormatter alloc] init];
    [answerFormatter setPositiveFormat: @"#,###;0;(#,##0)"];
    NSString *string = [answerFormatter stringFromNumber:[NSNumber numberWithInt:answer]];
    resultLabel.text =[NSString stringWithFormat:@"%@", string];
    
    if ([UIScreen mainScreen].scale == 2.f && [[UIScreen mainScreen] bounds].size.height-568)
    { [calcText setText:@""]; }
    else
    {
        NSString *results = resultLabel.text;
        NSString *animal = AnimalButt.currentTitle;
        [calcText setText:[NSString stringWithFormat:@"You are %@ years old in %@ years!", results, animal]];
    }
    
    [self performSelector:@selector(dogAnswer:) withObject:nil afterDelay:.50];
    
    
    
}

@end
