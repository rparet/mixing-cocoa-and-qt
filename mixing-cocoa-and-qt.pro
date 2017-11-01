TEMPLATE = app

QT += widgets

HEADERS += \
	$$PWD/AutoUpdater.h

SOURCES += \
	$$PWD/AutoUpdater.cpp \
	$$PWD/main.cpp

mac {
	HEADERS += \
		$$PWD/SparkleAutoUpdater.h \
		$$PWD/CocoaInitializer.h

	OBJECTIVE_SOURCES += \
		$$PWD/SparkleAutoUpdater.mm \
		$$PWD/CocoaInitializer.mm
	
	QMAKE_LFLAGS += -F.
	QMAKE_CXXFLAGS += -F.
	QMAKE_CFLAGS += -F.
	QMAKE_OBJECTIVE_CFLAGS += -F.
	SPARKLE_PATH = $$PWD/../sparkle
    QMAKE_LFLAGS += -F $$SPARKLE_PATH
    QMAKE_OBJECTIVE_CFLAGS += -F $$SPARKLE_PATH
	LIBS += -framework Sparkle -framework AppKit

        QMAKE_INFO_PLIST = Info.plist
    sparkle.path = Contents/Frameworks
    sparkle.files = $$SPARKLE_PATH/Sparkle.framework
    QMAKE_BUNDLE_DATA += sparkle
}
