############################################################################
#    Copyright (C) 2017 by Vadim Peretokin - vperetokin@gmail.com          #
#                                                                          #
#    This program is free software; you can redistribute it and/or modify  #
#    it under the terms of the GNU General Public License as published by  #
#    the Free Software Foundation; either version 2 of the License, or     #
#    (at your option) any later version.                                   #
#                                                                          #
#    This program is distributed in the hope that it will be useful,       #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                          #
#                                                                          #
#    You should have received a copy of the GNU General Public License     #
#    along with this program; if not, write to the                         #
#    Free Software Foundation, Inc.,                                       #
#    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
############################################################################


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

    QMAKE_LFLAGS += -Wl,-rpath,@loader_path/../Frameworks
    LIBS += -framework Sparkle -framework AppKit

    QMAKE_INFO_PLIST = Info.plist
    sparkle.path = Contents/Frameworks
    sparkle.files = $$SPARKLE_PATH/Sparkle.framework
    QMAKE_BUNDLE_DATA += sparkle
}
