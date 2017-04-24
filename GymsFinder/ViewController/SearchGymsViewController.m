//
//  ViewController.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/15.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "SearchGymsViewController.h"
#import "GymsApi.h"
#import "CityApi.h"
#import "CityStore.h"
#import "GymSearchResultCollectionViewController.h"
#import "FileManager.h"

@interface SearchGymsViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;


@property (nonatomic, copy) NSArray *cityItems;
@property (nonatomic, copy) NSArray *countryItems;
@end

@implementation SearchGymsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)cityItems {
    if (!_cityItems) {
        self.cityItems = [CityStore sharedInstance].cityItems;
    }
    
    return _cityItems;
}

- (NSArray *)countryItems {
    if (!_countryItems) {
        self.countryItems = [CityStore sharedInstance].countryItems;
    }
    
    return _countryItems;
}

- (IBAction)search:(UIButton *)sender {
    if (![self.cityButton.currentTitle isEqualToString:@"請選擇城市"] &&
        ![self.countryButton.currentTitle isEqualToString:@"請選擇區域"]) {
        
        [GymsApi downloadGymWithCity:self.cityButton.currentTitle country:self.countryButton.currentTitle completionHandler:^(NSError *error) {
            if (!error) {
                [self performSegueWithIdentifier:@"toGymResult" sender:sender];
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toGymResult"]) {
        GymSearchResultCollectionViewController *nextVC = [segue destinationViewController];
        nextVC.city = self.cityButton.currentTitle;
        nextVC.country = self.countryButton.currentTitle;
    }
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
        return self.cityItems.count;
    }
    else if ([pickerView isEqual:self.countryPicker]) {
        return self.countryItems.count;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.cityPicker]) {
        return ((CityItems *)self.cityItems[row]).cityName;
    }
    else if ([pickerView isEqual:self.countryPicker]) {
        return ((CountryItems *)self.countryItems[row]).countryName;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([pickerView isEqual:self.cityPicker]) {
        CityItems *cityItems = self.cityItems[row];
        [self.cityButton setTitle:cityItems.cityName forState:UIControlStateNormal];
        
        [CityApi downloadCountryListWithCityName:cityItems.cityName completionHandler:^(NSError *error) {
            if (!error) {
                [[CityStore sharedInstance] parseCountryJSONArray:[FileManager parseJSONArrayWithFileName:[NSString stringWithFormat:@"%@.json", cityItems.cityName]]];
                [self.countryPicker reloadAllComponents];
                [self.countryPicker selectRow:0 inComponent:0 animated:NO];
                self.countryButton.enabled = YES;
                [self.countryButton setTitle:@"請選擇區域" forState:UIControlStateNormal];
            }
        }];
    }
    else if ([pickerView isEqual:self.countryPicker]) {
        [self.countryButton setTitle:((CountryItems *)self.countryItems[row]).countryName forState:UIControlStateNormal];
    }

    
    pickerView.hidden = YES;
}
@end
