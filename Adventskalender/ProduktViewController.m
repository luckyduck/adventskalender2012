//
//  ProduktViewController.m
//  Adventskalender
//
//  Created by Jan Brinkmann on 12/2/12.
//  Copyright (c) 2012 Jan Brinkmann. All rights reserved.
//

#import "ProduktViewController.h"
#import "ProduktResource.h"
#import "SVProgressHUD.h"

@interface ProduktViewController ()

@property (strong, nonatomic) NSMutableArray *produkte;

@end

@implementation ProduktViewController

// manual setter implementation => reload table when it changes
- (void)setProdukte:(NSMutableArray *)produkte
{
    _produkte = produkte;
    
    [self.tableView reloadData];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // init produkte with empty array
    self.produkte = [@[] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [SVProgressHUD show];
    
    [[ProduktResource sharedInstance] fetchProducts:^(NSMutableArray *items) {
        self.produkte = items;
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        
    }];
}


#pragma mark -
#pragma mark TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.produkte count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProduktCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    cell.textLabel.text = [[self.produkte objectAtIndex:indexPath.row] produktName];
    
    return cell;
}


@end
