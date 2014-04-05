//
//  NewUserViewCotroller.h
//  PayMyPocket
//
//  Created by eliran efron on 06/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewCotroller : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *createNew;
@property (weak, nonatomic) IBOutlet UIButton *connectToExist;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *helloText;

- (IBAction)openConnectionDialog:(id)sender;
- (IBAction)connectToExistingPocket:(id)sender;
- (IBAction)createNewPocket:(id)sender;

@end
