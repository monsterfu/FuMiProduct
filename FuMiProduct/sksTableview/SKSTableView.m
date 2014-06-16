//
//  SKSTableView.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import <objc/runtime.h>
CGFloat const rowHeight = 44.0f;
#pragma mark - NSArray (SKSTableView)

@interface NSMutableArray (SKSTableView)

- (void)initiateObjectsForCapacity:(NSInteger)numItems;

@end

@implementation NSMutableArray (SKSTableView)

- (void)initiateObjectsForCapacity:(NSInteger)numItems
{
    for (NSInteger index = [self count]; index < numItems; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [self addObject:array];
    }
}

@end

#pragma mark - SKSTableView


@interface SKSTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *expandedIndexPaths;

@property (nonatomic, strong) NSMutableDictionary *expandableCells;

@end

@implementation SKSTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _shouldExpandOnlyOneCell = NO;
    }
    
    return self;
}

- (void)setSKSTableViewDelegate:(id<SKSTableViewDelegate>)SKSTableViewDelegate
{
    self.dataSource = self;
    self.delegate = self;
    
    [self setSeparatorColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
    
    if (SKSTableViewDelegate){
        _SKSTableViewDelegate = SKSTableViewDelegate;
    }
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    [super setSeparatorColor:separatorColor];
}

- (NSMutableArray *)expandedIndexPaths
{
    if (!_expandedIndexPaths){
        _expandedIndexPaths = [NSMutableArray array];
    }
    
    return _expandedIndexPaths;
}

- (NSMutableDictionary *)expandableCells
{
    if (!_expandableCells){
        _expandableCells = [NSMutableDictionary dictionary];
    }
    
    return _expandableCells;
}

#pragma mark - UITableViewDataSource

#pragma mark - Required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_SKSTableViewDelegate tableView:tableView numberOfRowsInSection:section] + [[[self expandedIndexPaths] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.expandedIndexPaths[indexPath.section] containsObject:indexPath]) {
        NSIndexPath *tempIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
        SKSTableViewCell *cell = (SKSTableViewCell *)[_SKSTableViewDelegate tableView:tableView cellForRowAtIndexPath:tempIndexPath];
        
        if ([[self.expandableCells allKeys] containsObject:tempIndexPath]){
            [cell setIsExpanded:[[self.expandableCells objectForKey:tempIndexPath] boolValue]];
        }
        
        UIImageView *expandableImageView = (UIImageView *)cell.accessoryView;
        if (cell.isExpandable) {
            [self.expandableCells setObject:[NSNumber numberWithBool:[cell isExpanded]]
                                     forKey:indexPath];
            if (cell.isExpanded) {
                expandableImageView.image = [UIImage imageNamed:@"expanded.png"];
            } else {
                
                expandableImageView.image = [UIImage imageNamed:@"expandable.png"];
            }
            
        } else {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            expandableImageView.image = nil;
        }
        return cell;
        
    } else {
        NSIndexPath *indexPathForSubrow = [self correspondingIndexPathForSubRowAtIndexPath:indexPath];
        UITableViewCell *cell = [_SKSTableViewDelegate tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:indexPathForSubrow];
        cell.backgroundView = nil;
        cell.backgroundColor = [self separatorColor];
        cell.indentationLevel = 2;
        
        return cell;
        
    }
}

#pragma mark - Optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_SKSTableViewDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        
        NSInteger numberOfSections = [_SKSTableViewDelegate numberOfSectionsInTableView:tableView];
        
        if ([self.expandedIndexPaths count] != numberOfSections){
            [self.expandedIndexPaths initiateObjectsForCapacity:numberOfSections];
        }
        
        return numberOfSections;
        
    }
    return 1;
}


#pragma mark - UITableViewDelegate

#pragma mark - Optional

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [_SKSTableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
    {
        [_SKSTableViewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SKSTableViewCell *cell = (SKSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[SKSTableViewCell class]] && cell.isExpandable) {
        
        cell.isExpanded = !cell.isExpanded;
        
        NSIndexPath *_indexPath = indexPath;
        if (cell.isExpanded && self.shouldExpandOnlyOneCell) {
            
            _indexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
            [self collapseCurrentlyExpandedIndexPaths];
        }
        
        NSInteger numberOfSubRows = [self numberOfSubRowsAtIndexPath:_indexPath];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSInteger row = _indexPath.row;
        NSInteger section = _indexPath.section;
        
        for (NSInteger index = 1; index <= numberOfSubRows; index++) {
            
            NSIndexPath *expIndexPath = [NSIndexPath indexPathForRow:row+index inSection:section];
            [indexPaths addObject:expIndexPath];
        }
        
        if (cell.isExpanded) {
            
            [self setIsExpanded:YES forCellAtIndexPath:_indexPath];
            [self insertExpandedIndexPaths:indexPaths forSection:_indexPath.section];
            
        } else {
            
            [self setIsExpanded:NO forCellAtIndexPath:indexPath];
            [self removeExpandedIndexPaths:indexPaths forSection:_indexPath.section];
            
        }
        
        UIImageView* tempImageView = (UIImageView*)cell.accessoryView;
        [UIView animateWithDuration:0.2 animations:^{
            if (cell.isExpanded) {
                tempImageView.image = [UIImage imageNamed:@"expanded.png"];
                
            } else {
                 tempImageView.image = [UIImage imageNamed:@"expandable.png"];
            }
        } completion:^(BOOL finished) {
            
//            if (!cell.isExpanded){
//                tempImageView.image = nil;
//            }
            
        }];
        
    }
}




#pragma mark - SKSTableViewUtils


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.expandedIndexPaths[indexPath.section] containsObject:indexPath]) {
        
        if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            
            NSIndexPath *mainIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
            return [_SKSTableViewDelegate tableView:tableView heightForRowAtIndexPath:mainIndexPath];
            
        }
        
        return rowHeight;
        
    } else {
        
        if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:heightForSubRowAtIndexPath:)]) {
            
            NSIndexPath *subIndexPath = [self correspondingIndexPathForSubRowAtIndexPath:indexPath];
            return [_SKSTableViewDelegate tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:subIndexPath];
            
        }
        
        return rowHeight;
        
    }
    
}

- (NSInteger)numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [_SKSTableViewDelegate tableView:self numberOfSubRowsAtIndexPath:[self correspondingIndexPathForRowAtIndexPath:indexPath]];
}

- (NSIndexPath *)correspondingIndexPathForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    NSInteger row = 0;
    
    while (index < indexPath.row) {
        
        NSIndexPath *tempIndexPath = [self correspondingIndexPathForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:indexPath.section]];
        BOOL isExpanded = [[self.expandableCells allKeys] containsObject:tempIndexPath] ? [[self.expandableCells objectForKey:tempIndexPath] boolValue] : NO;
        
        if (isExpanded) {
            
            NSInteger numberOfExpandedRows = [_SKSTableViewDelegate tableView:self numberOfSubRowsAtIndexPath:tempIndexPath];
            
            index += (numberOfExpandedRows + 1);
            
        } else
            index++;
        
        row++;
        
    }
    
    return [NSIndexPath indexPathForRow:row inSection:indexPath.section];
}

- (NSIndexPath *)correspondingIndexPathForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    NSInteger row = 0;
    NSInteger subrow = 0;
    
    while (1) {
        
        NSIndexPath *tempIndexPath = [self correspondingIndexPathForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:indexPath.section]];
        BOOL isExpanded = [[self.expandableCells allKeys] containsObject:tempIndexPath] ? [[self.expandableCells objectForKey:tempIndexPath] boolValue] : NO;
        
        if (isExpanded) {
            
            NSInteger numberOfExpandedRows = [_SKSTableViewDelegate tableView:self numberOfSubRowsAtIndexPath:tempIndexPath];
            
            if ((indexPath.row - index) <= numberOfExpandedRows) {
                subrow = indexPath.row - index;
                break;
            }
            
            index += (numberOfExpandedRows + 1);
            
        } else
            index++;
        
        row++;
    }
    
    return [NSIndexPath indexPathForSubRow:subrow inRow:row inSection:indexPath.section];
}

- (void)setIsExpanded:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
    [self.expandableCells setObject:[NSNumber numberWithBool:isExpanded] forKey:correspondingIndexPath];
}

- (void)insertExpandedIndexPaths:(NSArray *)indexPaths forSection:(NSInteger)section
{
    NSIndexPath *firstIndexPathToExpand = indexPaths[0];
    NSIndexPath *firstIndexPathExpanded = nil;
    
    if ([self.expandedIndexPaths[section] count] > 0) firstIndexPathExpanded = self.expandedIndexPaths[section][0];
    
    __block NSMutableArray *array = [NSMutableArray array];
    
    if (firstIndexPathExpanded && firstIndexPathToExpand.section == firstIndexPathExpanded.section && firstIndexPathToExpand.row < firstIndexPathExpanded.row) {
        
        [self.expandedIndexPaths[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *updated = [NSIndexPath indexPathForRow:([obj row] + [indexPaths count])
                                                      inSection:[obj section]];
            
            [array addObject:updated];
        }];
        
        [array addObjectsFromArray:indexPaths];
        
        self.expandedIndexPaths[section] = array;
        
    } else {
        
        [self.expandedIndexPaths[section] addObjectsFromArray:indexPaths];
        
    }
    
    [self sortExpandedIndexPathsForSection:section];
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}


- (void)removeExpandedIndexPaths:(NSArray *)indexPaths forSection:(NSInteger)section
{
    NSUInteger index = [self.expandedIndexPaths[section] indexOfObject:indexPaths[0]];
    
    [self.expandedIndexPaths[section] removeObjectsInArray:indexPaths];
    
    if (index == 0) {
        
        __block NSMutableArray *array = [NSMutableArray array];
        [self.expandedIndexPaths[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *updated = [NSIndexPath indexPathForRow:([obj row] - [indexPaths count])
                                                      inSection:[obj section]];
            
            [array addObject:updated];
        }];
        
        self.expandedIndexPaths[section] = array;
        
    }
    
    [self sortExpandedIndexPathsForSection:section];
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}

- (void)collapseCurrentlyExpandedIndexPaths
{
    NSArray *expandedCells = [self.expandableCells allKeysForObject:[NSNumber numberWithBool:YES]];
    
    if (expandedCells.count > 0) {
        
        __weak SKSTableView *_self = self;
        [expandedCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *indexPath = (NSIndexPath *)obj;
            [_self.expandableCells setObject:[NSNumber numberWithBool:NO] forKey:indexPath];
            
            if ([_self.expandedIndexPaths[indexPath.section] count] > 0)
                [_self removeExpandedIndexPaths:[_self.expandedIndexPaths[indexPath.section] copy] forSection:indexPath.section];
            
            SKSTableViewCell *cell = (SKSTableViewCell *)[_self cellForRowAtIndexPath:indexPath];
            cell.isExpanded = NO;
            
            UIImageView* tempImageView = (UIImageView*)cell.accessoryView;
            [UIView animateWithDuration:0.2 animations:^{
                if (cell.isExpanded) {
                    tempImageView.image = [UIImage imageNamed:@"expanded.png"];
                    
                } else {
                    tempImageView.image = [UIImage imageNamed:@"expandable.png"];
                }
            } completion:^(BOOL finished) {
                
//                if (!cell.isExpanded){
//                    tempImageView.image = nil;
//                }               
            }];
        }];
    }
}

- (BOOL)isExpandedForCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *tempIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
    
    if ([[self.expandableCells allKeys] containsObject:tempIndexPath])
        return [[self.expandableCells objectForKey:tempIndexPath] boolValue];
    
    return NO;
}

- (void)sortExpandedIndexPathsForSection:(NSInteger)section
{
    [self.expandedIndexPaths[section] sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 section] < [obj2 section])
            return (NSComparisonResult)NSOrderedAscending;
        else if ([obj1 section] > [obj2 section])
            return (NSComparisonResult)NSOrderedDescending;
        else {
            
            if ([obj1 row] < [obj2 row])
                return (NSComparisonResult)NSOrderedAscending;
            else
                return (NSComparisonResult)NSOrderedDescending;
            
        }
    }];
}

@end

#pragma mark - NSIndexPath (SKSTableView)

static void *SubRowObjectKey;

@implementation NSIndexPath (SKSTableView)

@dynamic subRow;

- (NSInteger)subRow
{
    id subRowObj = objc_getAssociatedObject(self, SubRowObjectKey);
    return [subRowObj integerValue];
}

- (void)setSubRow:(NSInteger)subRow
{
    id subRowObj = [NSNumber numberWithInteger:subRow];
    objc_setAssociatedObject(self, SubRowObjectKey, subRowObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSIndexPath *)indexPathForSubRow:(NSInteger)subrow inRow:(NSInteger)row inSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    indexPath.subRow = subrow;
    
    return indexPath;
}

@end

