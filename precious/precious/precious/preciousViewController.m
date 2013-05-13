//
//  preciousViewController.m
//  precious
//
//  Created by Scott Fustin on 3/11/13.
//  Copyright (c) 2013 Professor Fusion. All rights reserved.
//




#import "preciousViewController.h"

@interface preciousViewController ()
{
    NSMutableArray *prices;
    NSMutableData *data;
    NSURLConnection *connection;
}

@end


@implementation preciousViewController

@synthesize goldPrice, priceofGold, silverPrice, platinumPrice, palladiumPrice, rhodiumPrice, dateStamp, refreshBtn;

@synthesize goldHoldings, silverHoldings, platinumHoldings, palladiumHoldings, rhodiumHoldings;

@synthesize goldTotal, silverTotal, platinumTotal, palladiumTotal, rhodiumTotal, grandTotal;

@synthesize activityImageView, marketClosed;


- (void) viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *goldOunces = [goldHoldings text];
    [defaults setObject:goldOunces forKey:@"goldQuantity"];

    NSString *silverOunces = [silverHoldings text];
    [defaults setObject:silverOunces forKey:@"silverQuantity"];
    
    NSString *platinumOunces = [platinumHoldings text];
    [defaults setObject:platinumOunces forKey:@"platinumQuantity"];
    
    NSString *palladiumOunces = [palladiumHoldings text];
    [defaults setObject:palladiumOunces forKey:@"palladiumQuantity"];
    
    NSString *rhodiumOunces = [rhodiumHoldings text];
    [defaults setObject:rhodiumOunces forKey:@"rhodiumQuantity"];
    
    
    
    NSNumberFormatter *commas = [NSNumberFormatter new];
    commas.numberStyle = NSNumberFormatterDecimalStyle;
    
    double goldAmount = [goldHoldings.text doubleValue];
    double goldCurrent = [goldPrice.text doubleValue];
    
    double silverAmount = [silverHoldings.text doubleValue];
    double silverCurrent = [silverPrice.text doubleValue];
    
    double platinumAmount = [platinumHoldings.text doubleValue];
    double platinumCurrent = [platinumPrice.text doubleValue];
    
    double palladiumAmount = [palladiumHoldings.text doubleValue];
    double palladiumCurrent = [palladiumPrice.text doubleValue];
    
    double rhodiumAmount = [rhodiumHoldings.text doubleValue];
    double rhodiumCurrent = [rhodiumPrice.text doubleValue];
    

    goldTotal.text = [NSString stringWithFormat:@"%.2f", goldAmount * goldCurrent];
    silverTotal.text = [NSString stringWithFormat:@"%.2f", silverAmount * silverCurrent];
    platinumTotal.text = [NSString stringWithFormat:@"%.2f", platinumAmount * platinumCurrent];
    palladiumTotal.text = [NSString stringWithFormat:@"%.2f", palladiumAmount * palladiumCurrent];
    rhodiumTotal.text = [NSString stringWithFormat:@"%.2f", rhodiumAmount * rhodiumCurrent];
    
    double goldGrandTotal = [goldTotal.text doubleValue];
    double silverGrandTotal = [silverTotal.text doubleValue];
    double platinumGrandTotal = [platinumTotal.text doubleValue];
    double palladiumGrandTotal = [palladiumTotal.text doubleValue];
    double rhodiumGrandTotal = [rhodiumTotal.text doubleValue];

   
    grandTotal.text = [NSString stringWithFormat:@"%.2f", goldGrandTotal + silverGrandTotal + platinumGrandTotal + palladiumGrandTotal + rhodiumGrandTotal];


    NSString *goldLast = [goldPrice text];
    NSString *silverLast = [silverPrice text];
    NSString *platinumLast = [platinumPrice text];
    NSString *palladiumLast = [palladiumPrice text];
    NSString *rhodiumLast = [rhodiumPrice text];
//    
    NSString *updated = [dateStamp text];
    
    
    
    // Store the data
 //   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:goldLast forKey:@"gold"];
    [defaults setObject:silverLast forKey:@"silver"];
    [defaults setObject:platinumLast forKey:@"platinum"];
    [defaults setObject:palladiumLast forKey:@"palladium"];
    [defaults setObject:rhodiumLast forKey:@"rhodium"];
    
    [defaults setObject:updated forKey:@"lastupdated"];
    
    [defaults synchronize];
    



}


- (void)viewDidLoad
{


    //load saved data
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *goldLast = [defaults objectForKey:@"gold"];
    NSString *silverLast = [defaults objectForKey:@"silver"];
    NSString *platinumLast = [defaults objectForKey:@"platinum"];
    NSString *palladiumLast = [defaults objectForKey:@"palladium"];
    NSString *rhodiumLast = [defaults objectForKey:@"rhodium"];
    
    NSString *updated = [defaults objectForKey:@"lastupdated"];
    
    NSString *goldOunces = [defaults objectForKey:@"goldQuantity"];
    NSString *silverOunces = [defaults objectForKey:@"silverQuantity"];
    NSString *platinumOunces = [defaults objectForKey:@"platinumQuantity"];
    NSString *palladiumOunces = [defaults objectForKey:@"palladiumQuantity"];
    NSString *rhodiumOunces = [defaults objectForKey:@"rhodiumQuantity"];
    // [defaults synchronize];
    
    
    // Update the UI elements with the saved data
    goldPrice.text = goldLast;
    silverPrice.text = silverLast;
    platinumPrice.text = platinumLast;
    palladiumPrice.text = palladiumLast;
    rhodiumPrice.text = rhodiumLast;
    dateStamp.text = updated;
    goldHoldings.text = goldOunces;
    silverHoldings.text = silverOunces;
    platinumHoldings.text = platinumOunces;
    palladiumHoldings.text = palladiumOunces;
    rhodiumHoldings.text = rhodiumOunces;

    [defaults synchronize];
    // end load data
    
    
//markets closed switch
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSTimeZoneCalendarUnit) fromDate:today];
    [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    NSInteger weekday   = [components weekday];
    NSInteger hour = [components hour];

    switch(weekday){
        case 1: // sunday
            
            if (hour == 17 || hour == 24) { // covers 8:00 - 9:59 PM
            marketClosed.text = [NSString stringWithFormat:@"Market Open"];
                break;
        case 2:
                marketClosed.text = [NSString stringWithFormat:@"Market Open"];
                break;

        case 3:
                marketClosed.text = [NSString stringWithFormat:@"Market Open"];
                break;

        case 4:
                marketClosed.text = [NSString stringWithFormat:@"Market Open"];
                break;

        case 5:
                marketClosed.text = [NSString stringWithFormat:@"Market Open"];
                break;

        case 6:
                marketClosed.text = [NSString stringWithFormat:@"Market Open"];
                if (hour ==17 || hour == 24)
                marketClosed.text = [NSString stringWithFormat:@"Market Closed"];
                break;

        case 7: // saturday
                marketClosed.text = [NSString stringWithFormat:@"Market Closed"];
            break;
        default:
                marketClosed.text = [NSString stringWithFormat:@"Market Open"];
            break;
    }
    }
        //end market closed switch
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // custom activity indicator
    UIImage *statusImage = [UIImage imageNamed:@"activity1.png"];
    
    activityImageView = [[UIImageView alloc] initWithImage:statusImage];
    
    
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"activity1.png"],
                                         [UIImage imageNamed:@"activity2.png"],
                                         [UIImage imageNamed:@"activity3.png"],
                                         [UIImage imageNamed:@"activity4.png"],
                                         [UIImage imageNamed:@"activity5.png"],
                                         [UIImage imageNamed:@"activity6.png"],
                                         [UIImage imageNamed:@"activity7.png"],
                                         [UIImage imageNamed:@"activity8.png"],
                                         [UIImage imageNamed:@"activity9.png"],
                                         [UIImage imageNamed:@"activity10.png"],
                                         [UIImage imageNamed:@"activity11.png"],
                                         [UIImage imageNamed:@"activity12.png"],
                                         nil];
    
    
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    activityImageView.animationDuration = 0.6;
    
    
    //Position the activity image view somewhere in
    //the middle of your current view
    activityImageView.frame = CGRectMake(249,379,36,36);
//                                         self.view.frame.size.width/2
//                                         -statusImage.size.width/2,
//                                         self.view.frame.size.height/1.2
//                                         -statusImage.size.height/1.2,
//                                         statusImage.size.width,
//                                         statusImage.size.height);

    [self.activityImageView startAnimating];
    [self.view addSubview:activityImageView];
    
    // end custom activity indicator

       
    
    NSURL *url = [NSURL URLWithString:@"http://appsrv.cse.cuhk.edu.hk/~rysun/goldprice/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    prices = [[NSMutableArray alloc] init];
    
    
  }

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [data setLength:0];
    data = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityImageView stopAnimating];
    [activityImageView removeFromSuperview];
    
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    

    NSDictionary *Gold = [allDataDictionary objectForKey:@"Gold"];
    NSString *goldBid = [Gold objectForKey:@"bid"];
    goldPrice.text = [NSString stringWithFormat:@"%@", goldBid ];
    
    NSDictionary *Silver = [allDataDictionary objectForKey:@"Silver"];
    NSString *silverBid = [Silver objectForKey:@"bid"];
    silverPrice.text = [NSString stringWithFormat:@"%@", silverBid ];

    NSDictionary *Platinum = [allDataDictionary objectForKey:@"Platinum"];
    NSString *platinumBid = [Platinum objectForKey:@"bid"];
    platinumPrice.text = [NSString stringWithFormat:@"%@", platinumBid ];
    
    NSDictionary *Palladium = [allDataDictionary objectForKey:@"Palladium"];
    NSString *palladiumBid = [Palladium objectForKey:@"bid"];
    palladiumPrice.text = [NSString stringWithFormat:@"%@", palladiumBid ];
    
    NSDictionary *Rhodium = [allDataDictionary objectForKey:@"Rhodium"];
    NSString *rhodiumBid = [Rhodium objectForKey:@"bid"];
    NSString* cleanedString = [[rhodiumBid stringByReplacingOccurrencesOfString:@"," withString:@""]
                               stringByTrimmingCharactersInSet: [NSCharacterSet symbolCharacterSet]];
    rhodiumPrice.text = [NSString stringWithFormat:@"%@", cleanedString ];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    dateStamp.text = currentTime;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The data could not be retrieved, be sure you are connected to 3G or WiFi" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickDone:(UITextField *)textField
{
    [self viewDidAppear:YES];
    

    
    NSLog(@"Data saved");
    NSLog(@"%@", textField.text);
}

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickCancel:(UITextField *)textField
{
    NSLog(@"Canceled: %@", [textField description]);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    DoneCancelNumberPadToolbar *toolbar = [[DoneCancelNumberPadToolbar alloc] initWithTextField:textField];
    toolbar.delegate = self;
    textField.inputAccessoryView = toolbar;
    
}

- (IBAction)refresh:(id)sender {
    [self viewDidLoad];
}
@end
