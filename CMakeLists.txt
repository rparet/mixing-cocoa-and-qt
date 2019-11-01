############################################################################
#    Copyright (C) 2017 by Vadim Peretokin - vperetokin@gmail.com          #
#    Copyright (C) 2017 by Florian Scheel - keneanung@googlemail.com       #
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

CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

IF(POLICY CMP0020)
  CMAKE_POLICY(SET CMP0020 NEW)
ENDIF()

PROJECT(cocoa-qt-glue)

set(HEADER_FILES
  SparkleAutoUpdater.h
  CocoaInitializer.h
  AutoUpdater.h
)
set(SOURCE_FILES
  SparkleAutoUpdater.mm
  CocoaInitializer.mm
  AutoUpdater.cpp
)

FIND_PACKAGE(Qt5Core REQUIRED)
FIND_PACKAGE(Qt5Widgets REQUIRED)

# Qt 5.7 or greater requires C++11 standard. Set this requirement conditionally to lower requirements where possible
IF (Qt5Core_VERSION VERSION_EQUAL 5.7 OR Qt5Core_VERSION VERSION_GREATER 5.7)
  set(CMAKE_CXX_STANDARD 11)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
ENDIF()

IF(Qt5_POSITION_INDEPENDENT_CODE)
  SET(CMAKE_POSITION_INDEPENDENT_CODE ON)
ENDIF()

ADD_DEFINITIONS(
  ${Qt5Core_DEFINITIONS}
  ${Qt5Widgets_DEFINTIONS}
)


SET(CMAKE_INCLUDE_CURRENT_DIR ON)
INCLUDE_DIRECTORIES(
  ${Qt5Core_INCLUDE_DIRS}
  ${Qt5Widgets_INCLUDE_DIRS}
)

add_library(
  cocoa-qt-glue
  STATIC
  ${HEADER_FILES}
  ${SOURCE_FILES}
)

find_package(Sparkle)

target_link_libraries( cocoa-qt-glue
  "-framework AppKit"
  Sparkle::Sparkle
)
