//
//  ViewController.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/15.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "ViewController.h"
#import "GymsApi.h"
#import "GymStore.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;


@property (nonatomic, copy) NSArray *items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)items {
    if (!_items) {
        self.items = [GymStore sharedInstance].items;
    }
    return _items;
}

- (IBAction)showPickerView:(UIButton *)sender {
    if ([sender isEqual:self.cityButton]) {
        self.cityPicker.hidden = NO;
        self.countryPicker.hidden = YES;
    }
    else if ([sender isEqual:self.countryButton] && sender.isEnabled) {
        self.cityPicker.hidden = YES;
        self.countryPicker.hidden = NO;
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.cityPicker]) {
        return self.items.count;
    }
    else if ([pickerView isEqual:self.countryPicker]) {
        NSInteger cityPickerSelectedIndex = [self.cityPicker selectedRowInComponent:0];
        if (cityPickerSelectedIndex >= 0) {
            return ((CityItems *)self.items[cityPickerSelectedIndex]).countrys.count;
        }
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.cityPicker]) {
        return ((CityItems *)self.items[row]).cityName;
    }
    else if ([pickerView isEqual:self.countryPicker]) {
        NSInteger cityPickerSelectedIndex = [self.cityPicker selectedRowInComponent:0];
        if (cityPickerSelectedIndex >= 0) {
            NSArray *countrys = ((CityItems *)self.items[cityPickerSelectedIndex]).countrys;
            return ((CountryItems *)countrys[row]).countryName;
        }
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([pickerView isEqual:self.cityPicker]) {
        CityItems *cityItems = self.items[row];
        [self.cityButton setTitle:cityItems.cityName forState:UIControlStateNormal];
        self.countryButton.enabled = YES;
        [self.countryPicker reloadAllComponents];
        [self.countryButton setTitle:@"請選擇區域" forState:UIControlStateNormal];
        [self.countryPicker selectRow:0 inComponent:0 animated:NO];
    }
    else if ([pickerView isEqual:self.countryPicker]) {
        NSInteger cityPickerSelectedIndex = [self.cityPicker selectedRowInComponent:0];
        NSArray *countrys = ((CityItems *)self.items[cityPickerSelectedIndex]).countrys;
        [self.countryButton setTitle:((CountryItems *)countrys[row]).countryName forState:UIControlStateNormal];
    }

    
    pickerView.hidden = YES;
}
@end
