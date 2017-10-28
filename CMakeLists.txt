CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

IF(POLICY CMP0020)
  CMAKE_POLICY(SET CMP0020 NEW)
ENDIF()

PROJECT(cocoa-qt-glue)

set(HEADER_FILES
    SparkleAutoUpdater.h
    CocoaInitializer.h
)
set(SOURCE_FILES
    SparkleAutoUpdater.mm
    CocoaInitializer.mm
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

target_compile_options( cocoa-qt-glue PUBLIC "-F .")

target_link_libraries( cocoa-qt-glue
    "-framework Sparkle"
    "-framework AppKit"
)
