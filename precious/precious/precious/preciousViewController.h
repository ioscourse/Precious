//
//  preciousViewController.h
//  precious
//
//  Created by Scott Fustin on 3/11/13.
//  Copyright (c) 2013 Professor Fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneCancelNumberPadToolbar.h"

@interface preciousViewController : UIViewController<NSURLConnectionDataDelegate, DoneCancelNumberPadToolbarDelegate>{

    NSDictionary *metalPrices;
    
    IBOutlet UITextField *goldHoldings;
    IBOutlet UILabel *goldTotal;
    
    IBOutlet UITextField *silverHoldings;
    IBOutlet UILabel *silverTotal;
    
    IBOutlet UITextField *platinumHoldings;
    IBOutlet UILabel *platinumTotal;
    
    IBOutlet UITextField *palladiumHoldings;
    IBOutlet UILabel *palladiumTotal;
    
    IBOutlet UITextField *rhodiumHoldings;
    IBOutlet UILabel *rhodiumTotal;
    
    IBOutlet UILabel *grandTotal;
    
    IBOutlet UILabel *goldPrice;
    IBOutlet UILabel *silverPrice;
    IBOutlet UILabel *platinumPrice;
    IBOutlet UILabel *palladiumPrice;
    IBOutlet UILabel *rhodiumPrice;
    IBOutlet UIButton *refreshBtn;
    IBOutlet UILabel *dateStamp;
    
    IBOutlet UILabel *marketClosed;

}
@property (strong, nonatomic) IBOutlet UITextField *goldHoldings;
@property (strong, nonatomic) IBOutlet UILabel *goldTotal;

@property (strong, nonatomic) IBOutlet UITextField *silverHoldings;
@property (strong, nonatomic) IBOutlet UILabel *silverTotal;

@property (strong, nonatomic) IBOutlet UITextField *platinumHoldings;
@property (strong, nonatomic) IBOutlet UILabel *platinumTotal;

@property (strong, nonatomic) IBOutlet UITextField *palladiumHoldings;
@property (strong, nonatomic) IBOutlet UILabel *palladiumTotal;

@property (strong, nonatomic) IBOutlet UITextField *rhodiumHoldings;
@property (strong, nonatomic) IBOutlet UILabel *rhodiumTotal;

@property (strong, nonatomic) IBOutlet UILabel *grandTotal;

@property (strong, nonatomic) IBOutlet UILabel *dateStamp;

@property (nonatomic, copy) NSDictionary *priceofGold;

@property (strong, nonatomic) IBOutlet UILabel *goldPrice;

@property (strong, nonatomic) IBOutlet UILabel *silverPrice;

@property (strong, nonatomic) IBOutlet UILabel *platinumPrice;

@property (strong, nonatomic) IBOutlet UILabel *palladiumPrice;

@property (strong, nonatomic) IBOutlet UILabel *rhodiumPrice;

@property (strong, nonatomic) IBOutlet UIButton *refreshBtn;

@property(nonatomic, retain) UIImageView *activityImageView;

@property (strong, nonatomic) IBOutlet UILabel *marketClosed;

- (IBAction)refresh:(id)sender;

@end
