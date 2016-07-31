//
//  ViewController.m
//  AccessingContacts
//
//  Created by Rajesh on 15/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
  @synthesize labelName,labelEmail,labelMobile;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionPickContact:(id)sender
{
    //show peoplePicker Controller
    ABPeoplePickerNavigationController *peoplePickerCon = [[ABPeoplePickerNavigationController alloc]init];
    
    peoplePickerCon.peoplePickerDelegate = self;
    [self presentViewController:peoplePickerCon animated:true completion:nil];
}

//delegate method to receive picked contact
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSLog(@"The Contact:%@",person);
    [peoplePicker dismissViewControllerAnimated:true completion:nil];
    
    //get first name from person record
   // CFTypeRef v = ABRecordCopyValue(<#ABRecordRef record#>, <#ABPropertyID property#>)
    
    CFTypeRef cftypeFName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    //convert core foundation type into NSString
    NSString *fname = (__bridge_transfer NSString *) cftypeFName;
    
    NSString *lastname = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    labelName.text=[NSString stringWithFormat:@"%@ %@",fname,lastname];
    
    //get multiple values like mobile or email from person record
    ABMultiValueRef phoneRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //get one phone at time from multivalue type
    long count = ABMultiValueGetCount(phoneRef);
    for (int i=0; i<count; i++)
    {
        CFTypeRef cfTypePhone = ABMultiValueCopyValueAtIndex(phoneRef, i);
        NSString *phone = (__bridge_transfer NSString *)cfTypePhone;
        labelMobile.text = phone;
        
        NSLog(@"%d, %@",i,phone);
    }
    
    
}
@end
