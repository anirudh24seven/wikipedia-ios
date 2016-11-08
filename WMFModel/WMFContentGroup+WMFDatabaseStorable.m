#import "WMFContentGroup+WMFDatabaseStorable.h"
#import "NSDate+Utilities.h"
#import "NSDateFormatter+WMFExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation WMFContentGroup (WMFDatabaseStorable)

+ (NSURL *)baseUrl {
    NSURL *url = [NSURL URLWithString:@"wikipedia://content/"];
    return url;
}

+ (NSString *)databaseKeyForURL:(NSURL *)url {
    NSParameterAssert(url);
    return [[url absoluteString] precomposedStringWithCanonicalMapping];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] baseUrl]];
}

+ (NSString *)databaseCollectionName {
    return NSStringFromClass([WMFContentGroup class]);
}
@end

@implementation WMFContinueReadingContentGroup (WMFDatabaseStorable)

+ (NSURL *)url {
    return [[self baseUrl] URLByAppendingPathComponent:@"continue-reading"];
}

- (NSURL *)url {
    return [[self class] url];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] url]];
}

@end

@implementation WMFMainPageContentGroup (WMFDatabaseStorable)

+ (nullable NSURL *)urlForSiteURL:(NSURL *)url {
    NSString *language = url.wmf_language;
    NSString *domain = url.wmf_domain;
    NSParameterAssert(domain);
    NSParameterAssert(language);
    if (!domain || !language) {
        return nil;
    }

    NSURL *theURL = [[self baseUrl] URLByAppendingPathComponent:@"main-page"];
    theURL = [theURL URLByAppendingPathComponent:domain];
    theURL = [theURL URLByAppendingPathComponent:language];
    return theURL;
}

- (NSURL *)url {
    //Assumes that self.siteURL.wmf_hasValidSite
    return [[self class] urlForSiteURL:self.siteURL];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForSiteURL:self.siteURL]];
}

@end

@implementation WMFRelatedPagesContentGroup (WMFDatabaseStorable)

+ (nullable NSURL *)urlForArticleURL:(NSURL *)url {
    NSString *title = url.wmf_title;
    NSString *domain = url.wmf_domain;
    NSString *language = url.wmf_language;
    NSParameterAssert(title);
    NSParameterAssert(domain);
    NSParameterAssert(language);
    if (!title || !domain || !language) {
        return nil;
    }
    NSURL *theURL = [[self baseUrl] URLByAppendingPathComponent:@"related-pages"];
    theURL = [theURL URLByAppendingPathComponent:domain];
    theURL = [theURL URLByAppendingPathComponent:language];
    theURL = [theURL URLByAppendingPathComponent:title];
    return theURL;
}

- (NSURL *)url {
    return [[self class] urlForArticleURL:self.articleURL];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForArticleURL:self.articleURL]];
}

@end

@implementation WMFLocationContentGroup (WMFDatabaseStorable)

+ (NSURL *)urlForLocation:(CLLocation *)location {
    NSURL *url = [[self baseUrl] URLByAppendingPathComponent:@"nearby"];
    url = [url URLByAppendingPathComponent:[location description]];
    return url;
}

- (NSURL *)url {
    return [[self class] urlForLocation:self.location];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForLocation:self.location]];
}

@end

@implementation WMFPictureOfTheDayContentGroup (WMFDatabaseStorable)

+ (nullable NSURL *)urlForSiteURL:(NSURL *)url date:(NSDate *)date {
    NSString *domain = url.wmf_domain;
    NSParameterAssert(domain);
    if (!domain) {
        return nil;
    }

    NSURL *urlKey = [[self baseUrl] URLByAppendingPathComponent:@"picture-of-the-day"];
    urlKey = [urlKey URLByAppendingPathComponent:domain];
    urlKey = [urlKey URLByAppendingPathComponent:[[NSDateFormatter wmf_englishUTCSlashDelimitedYearMonthDayFormatter] stringFromDate:date]];
    return urlKey;
}

- (NSURL *)url {
    return [[self class] urlForSiteURL:self.siteURL date:self.date];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForSiteURL:self.siteURL date:self.date]];
}

@end

@implementation WMFRandomContentGroup (WMFDatabaseStorable)

+ (nullable NSURL *)urlForSiteURL:(NSURL *)url date:(NSDate *)date {
    NSString *language = url.wmf_language;
    NSString *domain = url.wmf_domain;
    NSParameterAssert(domain);
    NSParameterAssert(language);
    if (!domain || !language) {
        return nil;
    }

    NSURL *urlKey = [[self baseUrl] URLByAppendingPathComponent:@"random"];
    urlKey = [urlKey URLByAppendingPathComponent:domain];
    urlKey = [urlKey URLByAppendingPathComponent:language];
    urlKey = [urlKey URLByAppendingPathComponent:[[NSDateFormatter wmf_englishUTCSlashDelimitedYearMonthDayFormatter] stringFromDate:date]];
    return urlKey;
}

- (NSURL *)url {
    return [[self class] urlForSiteURL:self.siteURL date:self.date];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForSiteURL:self.siteURL date:self.date]];
}

@end

@implementation WMFFeaturedArticleContentGroup (WMFDatabaseStorable)

+ (nullable NSURL *)urlForSiteURL:(NSURL *)url date:(NSDate *)date {
    NSString *language = url.wmf_language;
    NSString *domain = url.wmf_domain;
    NSParameterAssert(domain);
    NSParameterAssert(language);
    if (!domain || !language) {
        return nil;
    }

    NSURL *urlKey = [[self baseUrl] URLByAppendingPathComponent:@"featured-article"];
    urlKey = [urlKey URLByAppendingPathComponent:domain];
    urlKey = [urlKey URLByAppendingPathComponent:language];
    urlKey = [urlKey URLByAppendingPathComponent:[[NSDateFormatter wmf_englishUTCSlashDelimitedYearMonthDayFormatter] stringFromDate:date]];
    return urlKey;
}

- (NSURL *)url {
    return [[self class] urlForSiteURL:self.siteURL date:self.date];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForSiteURL:self.siteURL date:self.date]];
}

@end

@implementation WMFTopReadContentGroup (WMFDatabaseStorable)

+ (nullable NSURL *)urlForSiteURL:(NSURL *)url date:(NSDate *)date {
    NSString *language = url.wmf_language;
    NSString *domain = url.wmf_domain;
    NSParameterAssert(domain);
    NSParameterAssert(language);
    if (!domain || !language) {
        return nil;
    }

    NSURL *urlKey = [[self baseUrl] URLByAppendingPathComponent:@"top-read"];
    urlKey = [urlKey URLByAppendingPathComponent:domain];
    urlKey = [urlKey URLByAppendingPathComponent:language];
    urlKey = [urlKey URLByAppendingPathComponent:[[NSDateFormatter wmf_englishUTCSlashDelimitedYearMonthDayFormatter] stringFromDate:date]];
    return urlKey;
}

- (NSURL *)url {
    return [[self class] urlForSiteURL:self.siteURL date:self.date];
}

- (NSString *)databaseKey {
    return [[self class] databaseKeyForURL:[[self class] urlForSiteURL:self.siteURL date:self.date]];
}

@end

NS_ASSUME_NONNULL_END
