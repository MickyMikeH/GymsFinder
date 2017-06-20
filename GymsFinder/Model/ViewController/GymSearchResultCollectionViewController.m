//
//  GymSearchResultCollectionViewController.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/23.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "GymSearchResultCollectionViewController.h"
#import "GymSearchCollectionViewCell.h"
#import "GymStore.h"
#import "GymsApi.h"

@interface GymSearchResultCollectionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@property (nonatomic, copy) NSArray *gymItems;
@property (nonatomic, copy) GymStore *gymStore;
@end

@implementation GymSearchResultCollectionViewController

static NSString * const reuseIdentifier = @"GymCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GymStore *)gymStore {
    [[GymStore sharedInstance] parseJSONArrayWithCity:self.city country:self.country];
    return [GymStore sharedInstance];
}

- (NSArray *)gymItems {
    if (!_gymItems) {
        self.gymItems = self.gymStore.gymItems;
    }
    return _gymItems;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.noDataLabel.hidden = self.gymItems.count ? YES : NO;
    
    return self.gymItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GymSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    GymItems *gymItems = self.gymItems[indexPath.item];

    cell.gymTitle.text = gymItems.name;
    cell.gymTel.text = gymItems.tel;
    cell.gymAddress.text = gymItems.address;
    NSURL *gymPhotoURL = [NSURL URLWithString:[gymItems.photo1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    cell.gymImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:gymPhotoURL]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GymItems *gymItems = self.gymItems[indexPath.item];
    [GymsApi downloadGymWithGymID:gymItems.gymID.stringValue completionHandler:^(NSError *error) {
        [[GymStore sharedInstance] parseJSONArrayWithGymID:gymItems.gymID.stringValue];
        
        NSLog(@"%@", self.gymStore.gymDetailRateItems);
    }];
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
