/*
 * Copyright (C) 2008 Remko Troncon
 * Copyright (C) 2017 Vadim Peretokin
 */

#ifndef SPARKLEAUTOUPDATER_H
#define SPARKLEAUTOUPDATER_H

#include <QString>

#include "AutoUpdater.h"

class SparkleAutoUpdater : public AutoUpdater
{
	public:
		SparkleAutoUpdater();
		~SparkleAutoUpdater();

		void checkForUpdates() override;

		void setAutomaticallyChecksForUpdates(bool on) override;
		bool automaticallyChecksForUpdates() override;

		void setAutomaticallyDownloadsUpdates(bool on) override;
		bool automaticallyDownloadsUpdates() override;

	private:
		class Private;
		Private* d;
};

#endif
