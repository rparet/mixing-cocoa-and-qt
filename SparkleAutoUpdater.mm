/*
 * Copyright (C) 2008 Remko Troncon
 * Copyright (C) 2017 Vadim Peretokin
 */

#include "SparkleAutoUpdater.h"

#include <Cocoa/Cocoa.h>
#include <Sparkle/Sparkle.h>

#include <syslog.h>
static void SYSLOG(const char* format,...)
{
    va_list vaList;
    va_start( vaList,format );
    vsyslog(LOG_ERR,format,vaList);
    va_end(vaList);
}

class SparkleAutoUpdater::Private
{
public:
    SPUUpdater* updater;
};

@interface SparkleDelegate : NSObject <SPUUpdaterDelegate> {
  SparkleAutoUpdater* delegateHandler;
}

@end

@implementation SparkleDelegate
- (id) init:(SparkleAutoUpdater*)handler
{
    self = [super init];
    if (self) {
        delegateHandler = handler;
    }
    return self;
}
@end

SparkleAutoUpdater::SparkleAutoUpdater()
{
    d = new Private;

    SparkleDelegate *sparkleDelegate = [[SparkleDelegate alloc] init:this];

      // Create an SPUUpdater instance with SPUStandardUserDriver
    d->updater = [[SPUUpdater alloc] initWithHostBundle:[NSBundle mainBundle]
                                      applicationBundle:[NSBundle mainBundle]
                                            userDriver:[[SPUStandardUserDriver alloc] initWithHostBundle:[NSBundle mainBundle] delegate:nil]
                                               delegate:sparkleDelegate];
                                              
    [d->updater retain];

    // has to be started on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
      NSError *error = nil;
      BOOL started = [d->updater startUpdater:&error];
      if (!started) {
          NSLog(@"Failed to start the updater: %@", error);
      }
      // necessary because we used -setFeedURL: in the past and now Sparkle wants us to migrate to setting the feed url in Info.plist
      [d->updater clearFeedURLFromUserDefaults];
    });
}

SparkleAutoUpdater::~SparkleAutoUpdater()
{
    [d->updater release];
    delete d;
}

void SparkleAutoUpdater::checkForUpdates()
{
    [d->updater checkForUpdates];
}

void SparkleAutoUpdater::setAutomaticallyChecksForUpdates(bool on)
{
    [d->updater setAutomaticallyChecksForUpdates:on];
}

bool SparkleAutoUpdater::automaticallyChecksForUpdates()
{
    return [d->updater automaticallyChecksForUpdates];
}

void SparkleAutoUpdater::setAutomaticallyDownloadsUpdates(bool on)
{
    [d->updater setAutomaticallyDownloadsUpdates:on];
}

bool SparkleAutoUpdater::automaticallyDownloadsUpdates()
{
    return [d->updater automaticallyDownloadsUpdates];
}
