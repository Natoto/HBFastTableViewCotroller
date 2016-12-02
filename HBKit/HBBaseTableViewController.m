//
//  BaseTableViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 YY.COM All rights reserved.
//
#import "CELL_STRUCT_Common.h"
#import "CELL_STRUCT.h"
#import "HBBaseTableViewController.h"
#import <objc/runtime.h>

@interface HBBaseTableViewController()

@end;

@implementation HBBaseTableViewController


-(void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.noAutoConfigTableView) {
        [self configTableView];
    }
}

//注册
-(void)configTableView
{
    if ([self tableView]) {
        [self setExtraCellLineHidden:self.tableView];
        //注册CELL 目前只考虑到两种情况 2个 section不同的时候 注册 其他的自己添加
        CELL_STRUCT * cell0struct= [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(0, 0)];
        if ([cell0struct.xibvalue isEqualToString:@"xib"]) {
            TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, cell0struct.cellclass)
        }
        CELL_STRUCT * cellstruct1 = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(1, 0)];
        if (cellstruct1) {
            if ([cellstruct1.xibvalue isEqualToString:@"xib"]) {
                TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, cellstruct1.cellclass)
            }
        }
    }
}

/**
 * 使用默认配置 供子类调用
 */
-(void)TableViewDefaultConfigWithTitle:(NSString *)title
{
//TODO:默认设置标题等
}

/**
 * 使用默认配置 供子类调用
 */
-(void)userDefaultConfigWithTitle:(NSString *)title
{
    [self TableViewDefaultConfigWithTitle:title];
}

-(void)observeTapgesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTap:)];
    [self.tableView addGestureRecognizer:tap];
}

-(void)tableViewTap:(UIGestureRecognizer *)gesture
{
     [[NSNotificationCenter defaultCenter] postNotificationName:notify_basetableview_tap object:gesture];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = TAG_TABLEVIEW;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(void)viewDidCurrentView
{
    
}
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(void)reloadTableViewCellWithKeyindexpath:(NSString *)keyindexpath
{
    if (!keyindexpath || ![keyindexpath containsString:@"section"]) {
        return;
    }
    NSString * sectionstr = KEY_INDEXPATH_SECTION_STR(keyindexpath);
    NSString * rowstr = KEY_INDEXPATH_ROW_STR(keyindexpath);
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowstr.intValue inSection:sectionstr.intValue]] withRowAnimation:UITableViewRowAnimationAutomatic];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 响应cell选择
-(void)cellDidSelect:(id)sender
{
    NSLog(@"%@",sender);
 
}

-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height - top - bottom);
    return self.tableView.frame;
}
#pragma mark - Table view data source
 
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionheight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionfooterheight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectiontitle.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cell_struce.sectionheight)];
        view.userInteractionEnabled = NO;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.bounds.size.width - 20, cell_struce.sectionheight)];
        label.center = CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2);
        label.text = cell_struce.sectiontitle;
        CGFloat sectionfont = (cell_struce.sectionfont > 0)?cell_struce.sectionfont:12;
        label.font = [UIFont systemFontOfSize:sectionfont];
        label.textColor = [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectioncolor];
        label.textAlignment = NSTextAlignmentLeft;
        UIColor * bgcolor =  [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectionbgcolor];
        view.backgroundColor = bgcolor?bgcolor:self.view.backgroundColor;
        [view addSubview:label];
        return view;
    }else {
        UIView * view = [UIView new];
        view.userInteractionEnabled = NO;
        return view;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectionfooter.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cell_struce.sectionfooterheight)];
        view.userInteractionEnabled = NO;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.bounds.size.width - 20, cell_struce.sectionfooterheight)];
        label.center = CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2);
        label.text = cell_struce.sectionfooter;
        CGFloat sectionfont = (cell_struce.sectionfooterfont >0)?cell_struce.sectionfooterfont:12;
        label.font = [UIFont systemFontOfSize:sectionfont];
        label.textColor = [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectionfootercolor];
        label.textAlignment = NSTextAlignmentLeft;
        UIColor * bgcolor =  [CELL_STRUCT_Common colorWithStructKey:cell_struce.sectionbgcolor];
        view.backgroundColor = bgcolor?bgcolor:self.view.backgroundColor;
        [view addSubview:label];
        return view;
    }else {
        UIView * view = [UIView new];
        view.userInteractionEnabled = NO;
        return view;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSInteger maxsection = 1;
    for (int index = 0; index < keys.count; index ++) {
         NSString * key =[keys objectAtIndex:index];
        
        NSString * sectionstr = KEY_SECTION_INDEX_STR(key);
        if ((sectionstr.integerValue +1) > maxsection) {
            maxsection = (sectionstr.integerValue + 1);
        }
     }
    return maxsection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSString * sectionx = KEY_SECTION_MARK(section);
    
    NSInteger sectioncount = 0;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        if ([key rangeOfString:sectionx].location != NSNotFound) {
            sectioncount ++;
        }
    }
    return sectioncount;
}

-(HBBaseTableViewCell *)getcellWithIndexPath:(NSIndexPath *)indexPath{

    CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 = cellstruct.cellclass;
    HBBaseTableViewCell *cell ;
    if(cellstruct.xibvalue && [cellstruct.xibvalue isEqualToString:@"xib"])
    {
        cell =  [self.tableView dequeueReusableCellWithIdentifier:identifier01 forIndexPath:indexPath];
    }
    else
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier01];
    }
    
    if (!cell) {
        NSString * Classname = [NSString stringWithFormat:@"%@",cellstruct.cellclass];
        Class cls = NSClassFromString(Classname);
        if(cellstruct.xibvalue && [cellstruct.xibvalue isEqualToString:@"xib"])
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellstruct.cellclass owner:self options:nil] lastObject];
        }
        else
        {
            if(cellstruct.CellStyleValue == 1)
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier01];
            }
            else if(cellstruct.CellStyleValue == 2)
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier01];
            }
            else if(cellstruct.CellStyleValue == 3)// (Used in iPod).
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier01];
            }
            else
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier01];
            }
            
        }
    }
    return cell;
}

- (void)drawCell:(HBBaseTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 = cellstruct.cellclass;
    
    if ([[cell class] isSubclassOfClass:[HBBaseTableViewCell class]]) {
        cell.delegate = self;
        cell.showTopLine = cellstruct.showTopLine;
        cell.showBottomLine = cellstruct.showBottomLine;
        cell.indexPath = indexPath;
        cell.selector = cellstruct.sel_selector;
        cell.selectionStyle = cellstruct.selectionStyle?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
        cell.accessoryType = cellstruct.accessory?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        [cell setcellTitleLabelNumberOfLines:cellstruct.titleLabelNumberOfLines];
        [cell setcelldetailtitle:cellstruct.detailtitle];
        [cell setcellplaceholder:cellstruct.placeHolder];
        [cell setcellTitle:cellstruct.title];
        [cell setcellTitleFontsize:cellstruct.titlefontsize];
        [cell setcellTitleFont:cellstruct.titleFont];
        [cell setcellAttributeTitle:cellstruct.attributeTitle];
        [cell setcellValue2:cellstruct.subvalue2];
        [cell setcellProfile:cellstruct.picture];
        [cell setcellpicturecolor:cellstruct.picturecolor];
        [cell setcellValue:cellstruct.value];
        [cell setcellRightValue:cellstruct.rightValue];
        [cell setcellobject:cellstruct.object];
        [cell setcellobject2:cellstruct.object2];
        [cell setcellTitleColor:cellstruct.titlecolor];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellArray:cellstruct.array];
        [cell setcellimageCornerRadius:cellstruct.imageCornerRadius];
    }
}
    

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 = cellstruct.cellclass;
    HBBaseTableViewCell *cell = [self getcellWithIndexPath:indexPath];
    if ([[cell class] isSubclassOfClass:[HBBaseTableViewCell class]]) {
        [self drawCell:cell withIndexPath:indexPath];
    }
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.nodeselectRow) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    CELL_STRUCT * cellstruct = [self.dataDictionary  cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    if ( cellstruct.sel_selector && [self respondsToSelector:cellstruct.sel_selector])
    {
        [self performSelector:cellstruct.sel_selector withObject:cellstruct afterDelay:0];
    }
    else
    {
        NSString * sel_selector = cellstruct.sel_selector_str;
        SEL selector = NSSelectorFromString(sel_selector);
        if (sel_selector  && [self respondsToSelector:selector]) {
            [self performSelector:selector withObject:cellstruct afterDelay:0];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary  cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    return cellstruct.cellheight;
}

@end



//计算CELL的高度
@implementation UITableView (HBTemplateLayoutCell)

- (id)fd_templateCellForReuseIdentifier:(NSString *)identifier
{
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    
    return templateCell;
}

/**
 *  计算CELL的高度 实现的方法需要在cell的具体实现里面重载sizeThatFit:
 *
 *  @param identifier    identifier
 *  @param configuration cell加载数据的
 *
 *  @return 高度
 */
- (CGFloat)hb_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration
{
    if (!identifier) {
        return 0;
    }
    
    // Fetch a cached template cell for `identifier`.
    UITableViewCell *cell = [self fd_templateCellForReuseIdentifier:identifier];
    
    // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
    [cell prepareForReuse];
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(cell);
    }
    
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    
    // If a cell has accessory view or system accessory type, its content view's width is smaller
    // than cell's by some fixed values.
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    
    CGSize fittingSize = CGSizeZero;
    
    // If auto layout enabled, cell's contentView must have some constraints.
    BOOL autoLayoutEnabled = YES;
    if (autoLayoutEnabled) {
        
        // If not using auto layout, you have to override "-sizeThatFits:" to provide a fitting size by yourself.
        // This is the same method used in iOS8 self-sizing cell's implementation.
        // Note: fitting height should not include separator view.
        SEL selector = @selector(sizeThatFits:);
        BOOL inherited = ![cell isMemberOfClass:UITableViewCell.class];
        BOOL overrided = [cell.class instanceMethodForSelector:selector] != [UITableViewCell instanceMethodForSelector:selector];
        if (inherited && !overrided) {
            NSAssert(NO, @"Customized cell must override '-sizeThatFits:' method if not using auto layout.");
        }
        fittingSize = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)];
    }
    
    // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
    }
    
    
    return fittingSize.height;
}
@end;

