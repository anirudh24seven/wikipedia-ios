
#import <UIKit/UIKit.h>

@interface WMFArticleViewController : UIViewController

@property (nonatomic, assign) CGFloat contentTopInset;

@property (nonatomic, strong) MWKSavedPageList* savedPages;
@property (nonatomic, strong) MWKArticle* article;

@end
