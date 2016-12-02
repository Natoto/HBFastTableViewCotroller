//
//  HBASViewController.m
//  HBCircleWidthDemo
//
//  Created by boob on 16/11/30.
//  Copyright © 2016年 YY.COM. All rights reserved.
//

#import "ASHBaseViewController.h"
#import "ASHBaseTableViewCell.h"
 


#ifndef	weakify
#if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else	// #if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	weakify

#ifndef	strongify
#if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
#else	// #if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	@normalize


@interface ASHBaseViewController ()<ASTableDelegate, ASTableDataSource>
{
    
#if DEBUG && TARGET_IPHONE_SIMULATOR
    HBKitDirWatchdog * watchDog;
#endif
}

// Data
//@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, assign) NSInteger curIndexPage;
@property (nonatomic, assign) BOOL haveMore;
@end

@implementation ASHBaseViewController

-(NSMutableDictionary *)dataDictionary{
    return self.datamodel.dataDictionary;
}

#pragma mark - life cycle

- (instancetype)init
{
    if (self = [super initWithNode:[ASDisplayNode new]]) {
        
        [self addTableNode];
    }
    return self;
}

- (instancetype)initWithNode:(ASDisplayNode *)node{
    self = [super initWithNode:node];
    if (self) {
        [self addTableNode];
    }
    return self;
}
- (void)addTableNode
{
    _tableView = [[ASTableNode alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.node addSubnode:_tableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self configureTableView];
    [self addRefreshHeader];
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tableView.frame = self.node.bounds;
}

- (void)configureTableView
{
    _tableView.view.tableFooterView = [[UIView alloc]init];
    _tableView.view.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)addRefreshHeader
{
    
}


- (void)loadData
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.datamodel.dataDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * key , CELL_STRUCT *  obj, BOOL * _Nonnull stop) {
        NSString * row = KEY_INDEXPATH_ROW_STR(key);
        NSString * section = KEY_INDEXPATH_SECTION_STR(key);
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:row.integerValue inSection:section.integerValue];
        [indexPaths addObject:indexpath];
    }];
    [_tableView.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)selectAction:(id)sender
{
    NSLog(@"%s",__func__);
}
#pragma mark - ASTableDataSource

- (BOOL)shouldBatchFetchForTableView:(ASTableView *)tableView
{
    return self.dataDictionary.count;
}

- (void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context
{
    //    [self loadMoreDataWithContext:context];
}


- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
        ASHBaseTableViewCell *cellNode = [self getcellWithIndexPath:indexPath];
        if ([[cellNode class] isSubclassOfClass:[ASHBaseTableViewCell class]]) {
            [self drawCell:cellNode withIndexPath:indexPath];
        }
        return cellNode;
    };
    return cellNodeBlock;
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

-(ASHBaseTableViewCell *)getcellWithIndexPath:(NSIndexPath *)indexPath{
    
    CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    ASHBaseTableViewCell *cell ;
    if (!cell) {
        NSString * Classname = [NSString stringWithFormat:@"%@",cellstruct.cellclass];
        if ([Classname isEqualToString:@"HBBaseTableViewCell"]) {
            Classname = @"ASHBaseTableViewCell";
        }else if ([Classname isEqualToString:@"BaseTableViewCell"]) {
            Classname = @"ASHBaseTableViewCell";
        }
        Class cls = NSClassFromString(Classname);
        {
                cell = [[cls alloc]  init];
            
        }
    }
    return cell;
}

- (void)drawCell:(ASHBaseTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary cellstructobjectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
//    NSString * identifier01 = cellstruct.cellclass;
    
    if ([[cell class] isSubclassOfClass:[ASHBaseTableViewCell class]]) {
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
        [cell setcellTitleFont:cellstruct.titleFont];
        [cell setcellTitleColor:cellstruct.titlecolor];
        [cell setcellTitleFontsize:cellstruct.titlefontsize];
        [cell setcellValue2:cellstruct.subvalue2];
        [cell setcellpicturecolor:cellstruct.picturecolor];
        [cell setcellValue:cellstruct.value];
        [cell setcellRightValue:cellstruct.rightValue];
        [cell setcellobject:cellstruct.object];
        [cell setcellobject2:cellstruct.object2];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellArray:cellstruct.array];
        [cell setcellTitle:cellstruct.title];
        [cell setcellProfile:cellstruct.picture];
        [cell setcellAttributeTitle:cellstruct.attributeTitle];
        [cell setcellimageCornerRadius:cellstruct.imageCornerRadius];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

#pragma mark -


-(void)reloadTableViewCellWithKeyindexpath:(NSString *)keyindexpath
{
    if (!keyindexpath || ![keyindexpath containsString:@"section"]) {
        return;
    }
    NSString * sectionstr = KEY_INDEXPATH_SECTION_STR(keyindexpath);
    NSString * rowstr = KEY_INDEXPATH_ROW_STR(keyindexpath);
    [self.tableView.view reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowstr.intValue inSection:sectionstr.intValue]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height - top - bottom);
    return self.tableView.frame;
}
//注册
-(void)configTableView
{
    
}

/**
 * 使用默认配置 供子类调用
 */
-(void)TableViewDefaultConfigWithTitle:(NSString *)title
{
    
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
    
}


-(void)viewDidCurrentView
{
    
}

#pragma mark - getter setter
-(HBKitDataModel *)datamodel{
    if (!_datamodel) {
        _datamodel  = [HBKitDataModel new];
    }
    return _datamodel;
}
/**
 *  从PLIST 文件中加载配置信息
 *
 *  @param plistname plist文件的名字
 <string>$(SRCROOT)/$(TARGET_NAME)</string>
 
 */

-(void)loadplistConfig:(NSString *)plistname
{
    
#if DEBUG && TARGET_IPHONE_SIMULATOR
    
    NSString *rootPath = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"projectPath"];
    
    NSString *scriptRootPath = [rootPath stringByAppendingPathComponent:@"resource"];
    NSString *mainScriptPath = [NSString stringWithFormat:@"%@/%@.plist", scriptRootPath, plistname];
    
    @weakify(self)
    watchDog = [[HBKitDirWatchdog alloc] initWithPath:scriptRootPath update:^{
        @strongify(self)
        [self loadplistConfig:plistname filepath:mainScriptPath];
        [self loadData];
        [self.tableView.view reloadData];
    }];
    [watchDog start];
    [self loadplistConfig:plistname filepath:mainScriptPath];
    
#else
    NSString *rootPath = [[NSBundle mainBundle] pathForResource:plistname ofType:@"plist" inDirectory:@"resource"];
    [self loadplistConfig:plistname filepath:rootPath];
#endif
}



-(void)loadplistConfig:(NSString *)plistname filepath:(NSString *)filepath
{
    [self.datamodel loadplistConfig:plistname filepath:filepath configViewblock:^(NSMutableDictionary *dic) {
        [self loadplistviewConfig:dic];
    }];
}

/**
 *  从PLIST 文件中加载配置信息放到一个字典中而不是直接对datadictionary赋值
 *
 *  @param plistname plist文件的名字
 */

-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname{
    return [self loadplistConfigToDictionary:plistname filepath:nil];
}


-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname filepath:(NSString *)filepath
{
   return [self.datamodel loadplistConfigToDictionary:plistname filepath:filepath];
}

/**
 *  从json文件中配置信息
 *
 */

-(void)loadjsonfileConfig:(NSString *)jsonfilename{
    [self loadjsonfileConfig:jsonfilename filepath:nil];
}

-(void)loadjsonfileConfig:(NSString *)jsonfilename filepath:(NSString *)filepath
{
    [self.datamodel loadjsonfileConfig:jsonfilename filepath:filepath configViewblock:^(CELL_STRUCT_ARRAY *vclist) {
        NSString * title = vclist.title;
        if (title && [[title class] isSubclassOfClass:[NSString class]]) {
            self.title = title;
        }
        NSString * backgroundcolor = vclist.backgroundcolor;
        if (backgroundcolor && [[backgroundcolor class] isSubclassOfClass:[NSString class]]) {
            self.view.backgroundColor = [CELL_STRUCT_Common colorWithStructKey:backgroundcolor];
        }
    }];
    
}

-(void)loadplistviewConfig:(NSDictionary *)dic
{
    NSString * title = [dic objectForKey:@"title"];
    if (title && [[title class] isSubclassOfClass:[NSString class]]) {
        self.title = title;
    }
    NSString * backgroundcolor = [dic objectForKey:@"backgroundcolor"];
    if (backgroundcolor && [[backgroundcolor class] isSubclassOfClass:[NSString class]]) {
        self.view.backgroundColor = [CELL_STRUCT_Common colorWithStructKey:backgroundcolor];
    }
    
}

@end
