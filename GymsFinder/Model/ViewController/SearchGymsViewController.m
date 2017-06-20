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
#import "GymStore.h"
#import "GymsApi.h"

typedef NS_ENUM(NSUInteger, ButtonSeleted) {
    ButtonSeletedCity,
    ButtonSeletedGymKind,
};

@interface SearchGymsViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *gymType;

@property (nonatomic, assign) ButtonSeleted buttonSeleted;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, copy) NSArray *gymTypes;
@property (nonatomic, copy) NSArray *gymKinds;
@property (nonatomic, copy) NSArray *cityItems;
@property (nonatomic, copy) NSArray *countryItems;
@property (nonatomic, copy) NSString *currentCityName;
@property (nonatomic, copy) NSString *currentCountryName;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@end

@implementation SearchGymsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPickerView {
    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.pickerView];
    [self.pickerView reloadAllComponents];
    if (self.currentCityName == nil) {
        self.currentCityName = ((CityItems *)self.cityItems.firstObject).cityName;
    }
    NSArray *array = self.toolbar.items;
    ((UIBarButtonItem *)array.lastObject).enabled = NO;
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 44)];
        [_toolbar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"確認"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(doneClicked)];
        UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(cancelClicked)];
        barButtonDone.enabled = NO;
        _toolbar.items = @[barButtonCancel, flex, barButtonDone];
    }
    return _toolbar;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolbar.frame), [UIScreen mainScreen].bounds.size.width, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
//        _pickerView.backgroundColor = [UIColor magentaColor];
    }
    return _pickerView;
}

- (void)cancelClicked {
    [self.toolbar removeFromSuperview];
    [self.pickerView removeFromSuperview];
}

- (void)doneClicked {
    [self.toolbar removeFromSuperview];
    [self.pickerView removeFromSuperview];
    
    if (self.buttonSeleted == ButtonSeletedCity) {
        if (self.currentCountryName != nil) {
            [self.cityButton setTitle:[NSString stringWithFormat:@"%@-%@", self.currentCityName, self.currentCountryName] forState:UIControlStateNormal];
        }
        else {
            [self.cityButton setTitle:@"請選擇地點" forState:UIControlStateNormal];
        }
        [[CityStore sharedInstance] clearCountryItems];
        self.countryItems = nil;
    }
}

- (NSArray *)gymTypes {
    self.gymTypes = [GymStore sharedInstance].gymTypes;
    return _gymTypes;
}

- (NSArray *)gymKinds {
    if (!_gymKinds) {
        self.gymKinds = [GymStore sharedInstance].gymKind;
    }
    return _gymKinds;
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
    if (![self.cityButton.currentTitle isEqualToString:@"請選擇地點"]) {
        self.activityView.hidden = NO;
        [self.activityView startAnimating];
        
        [GymsApi downloadGymWithCity:self.currentCityName country:self.currentCountryName completionHandler:^(NSError *error) {
            if (!error) {
                [self.activityView stopAnimating];
                [self performSegueWithIdentifier:@"toGymResult" sender:sender];
            }
        }];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"請選擇完整地點" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toGymResult"]) {
        GymSearchResultCollectionViewController *nextVC = [segue destinationViewController];
        nextVC.city = self.currentCityName;
        nextVC.country = self.currentCountryName;
    }
}

- (IBAction)showPickerView:(UIButton *)sender {
    self.buttonSeleted = ButtonSeletedCity;
    [self createPickerView];
}

- (IBAction)showGymKindPickerView:(UIButton *)sender {
    self.buttonSeleted = ButtonSeletedGymKind;
    [self createPickerView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.buttonSeleted == ButtonSeletedCity) {
        if (self.countryItems.count > 0) {
            return 2;
        }
    }
    else if (self.buttonSeleted == ButtonSeletedGymKind) {
        if (self.gymTypes.count > 0) {
            return 2;
        }
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.buttonSeleted == ButtonSeletedCity) {
        if (component == 0) {
            return self.cityItems.count;
        }
        else if (component == 1) {
            return self.countryItems.count;
        }
    }
    else if (self.buttonSeleted == ButtonSeletedGymKind) {
        if (component == 0) {
            return self.gymKinds.count;
        }
        else if (component == 1) {
            return self.gymTypes.count;
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.buttonSeleted == ButtonSeletedCity) {
        if (component == 0) {
            return ((CityItems *)self.cityItems[row]).cityName;
        }
        else if (component == 1) {
            return ((CountryItems *)self.countryItems[row]).countryName;
        }
    }
    else if (self.buttonSeleted == ButtonSeletedGymKind) {
        if (component == 0) {
            return ((GymKindItem *)self.gymKinds[row]).gymKindItem;
        }
        else {
            return ((GymTypeItem *)self.gymTypes[row]).name;
        }
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.buttonSeleted == ButtonSeletedCity) {
        if (component == 0) {
            CityItems *cityItems = self.cityItems[row];
            self.currentCityName = cityItems.cityName;
            
            [CityApi downloadCountryListWithCityName:cityItems.cityName completionHandler:^(NSError *error) {
                if (!error) {
                    [[CityStore sharedInstance] parseCountryJSONArray:[FileManager parseJSONArrayWithFileName:[NSString stringWithFormat:@"%@.json", cityItems.cityName]]];
                    
                    self.countryItems = nil;
                    self.currentCountryName = ((CountryItems *)self.countryItems.firstObject).countryName;
                    [pickerView reloadAllComponents];
                    [pickerView selectRow:0 inComponent:1 animated:YES];
                    
                    NSArray *array = self.toolbar.items;
                    ((UIBarButtonItem *)array.lastObject).enabled = YES;
                }
            }];
        }
        else if (component == 1) {
            CountryItems *countryItem = self.countryItems[row];
            self.currentCountryName = countryItem.countryName;
        }
    }
    else if (self.buttonSeleted == ButtonSeletedGymKind) {
        if (component == 0) {
            NSString *gymKindItem = ((GymKindItem *)self.gymKinds[row]).gymKindItem;
            [GymsApi downloadGymTypeListWithGymKind:gymKindItem completionHandler:^(NSError *error) {
                [[GymStore sharedInstance] parseJSONArrayWithGymType:gymKindItem];
                [pickerView reloadAllComponents];
                if (self.gymTypes.count > 0) {
                    [pickerView selectRow:0 inComponent:1 animated:YES];
                }
                
                NSArray *array = self.toolbar.items;
                ((UIBarButtonItem *)array.lastObject).enabled = YES;
            }];
        }
        else if (component == 1) {
        
        }
    }
}


@end
