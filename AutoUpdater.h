/*
 * Copyright (C) 2008 Remko Troncon
 */

#ifndef AUTOUPDATER_H
#define AUTOUPDATER_H

class AutoUpdater
{
	public:
		virtual ~AutoUpdater();

		virtual void checkForUpdates() = 0;
		virtual void setAutomaticallyDownloadsUpdates(bool on) = 0;
		virtual bool automaticallyDownloadsUpdates() = 0;
};

#endif
