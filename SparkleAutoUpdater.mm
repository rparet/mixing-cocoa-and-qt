/*
 * Copyright (C) 2008 Remko Troncon
 * Copyright (C) 2017 Vadim Peretokin
 */

#include "SparkleAutoUpdater.h"

#include <Cocoa/Cocoa.h>
#include <Sparkle/Sparkle.h>

class SparkleAutoUpdater::Private
{
public:
    SUUpdater* updater;
};

@interface SparkleDelegate : NSObject <SUUpdaterDelegate> {
    Sparkle* delegateHandler;
}

@implementation SparkleDelegate
- (id) init:(Sparkle*)handler
{
    self = [super init];
    if (self) {
        delegateHandler = handler;
    }
    return self;
}

- (void)updaterDidRelaunchApplication:(SUUpdater *)updater
{
    delegateHandler->setRelaunchFlag();
}

void SparkleAutoUpdater::setRelaunchFlag()
{
    relaunchedFromUpdate = true;
}

bool SparkleAutoUpdater::relaunchedFromUpdate()
{
    return relaunchedFromUpdate;
}

SparkleAutoUpdater::SparkleAutoUpdater(const QString& aUrl)
{
    d = new Private;

    d->updater = [SUUpdater sharedUpdater];
    [d->updater retain];

    NSURL* url = [NSURL URLWithString:
    [NSString stringWithUTF8String: aUrl.toUtf8().data()]];
    [d->updater setFeedURL: url];

    relaunchedFromUpdate = false;
}

SparkleAutoUpdater::~SparkleAutoUpdater()
{
    [d->updater release];
    delete d;
}

void SparkleAutoUpdater::checkForUpdates()
{
    [d->updater checkForUpdates:nil];
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
