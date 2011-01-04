#
# This script runs a dashboard
# Usage:
#   ctest -S <nameofthisscript> -V
#
# It has 1 optional argument: the build model.
# The build model should be one of {Experimental, Continuous, Nightly}
# and defaults to Nightly.
# Usage:
#   ctest -S <nameofthisscript>,Model
#
# Setup: MacOSX 64bit, 10.6.5
# gcc 4.2.1
# Release mode, ITK 3.20.0
# PC: LKEB (MS), MacMini PC of Patrick de Koning


# Where to find the src directory, and where to build the binaries
SET( CTEST_SOURCE_DIRECTORY "/elastix-nightly/elastix-src/src" )
SET( CTEST_CHECKOUT_DIRECTORY "/elastix-nightly/elastix-src" )
SET( CTEST_BINARY_DIRECTORY "/elastix-nightly/elastix-src/release" )

# Where to find CMake on my system
SET( CTEST_CMAKE_COMMAND "/usr/bin/cmake" )

# Specify the kind of dashboard to submit
SET( MODEL Nightly )
IF( ${CTEST_SCRIPT_ARG} MATCHES Experimental )
  SET( MODEL Experimental )
ELSEIF( ${CTEST_SCRIPT_ARG} MATCHES Continuous )
  SET( MODEL Continuous )
ENDIF()
SET( CTEST_COMMAND
  "/usr/bin/ctest -D ${MODEL}" )

# Specify svn update command;
# todo: why use elastixguest username? why not just default user?
SET( CTEST_SVN_COMMAND "/usr/bin/svn" )
SET( $ENV{LC_MESSAGES}    "en_EN" )
SET( CTEST_UPDATE_COMMAND "${CTEST_SVN_COMMAND}" )
SET( CTEST_SVN_CHECKOUT
  "${CTEST_SVN_COMMAND} co --username elastixguest --password elastixguest https://svn.bigr.nl/elastix/trunkpublic \"${CTEST_CHECKOUT_DIRECTORY}\"" )

# Ctest should wipe the binary tree before running
# to keep harddisk space usage from growing
SET( CTEST_START_WITH_EMPTY_BINARY_DIRECTORY TRUE )

# Build elastix in release mode
SET( CTEST_BUILD_CONFIGURATION "Release" )

# The following does not seem to work:
# find_program( CTEST_SVN_COMMAND NAMES svn )
#SET( CTEST_SVN_COMMAND "C:/cygwin/bin/svn.exe" )
# should ctest wipe the binary tree before running

#SET( CTEST_BUILD_NAME "win7-64-vs2008" )
#set( CTEST_CMAKE_GENERATOR "Visual Studio 9 2008 Win64" )
#set(WITH_KWSTYLE FALSE)
#set(WITH_MEMCHECK FALSE)
#set(WITH_COVERAGE FALSE)
#set(WITH_DOCUMENTATION FALSE)

# Send this script as a note.
LIST( APPEND CTEST_NOTES_FILES "${CMAKE_CURRENT_LIST_FILE}" )

# Usage of the initial cache seems to do the trick:
# Configure the dashboard.
SET( CTEST_INITIAL_CACHE "
// Specify build, generator
SITE:STRING=LKEB-MacMini
BUILDNAME:STRING=macosx-64-gcc4.2.1
CMAKE_CONFIGURATION_TYPES:STRING=Release

// Specify svn command:
SVNCOMMAND:FILEPATH=/usr/bin/svn

// Which ITK to use
ITK_DIR:PATH=/elastix-nightly/itk/release

// Some elastix settings, defining the configuration
ELASTIX_BUILD_TESTING:BOOL=ON
ELASTIX_ENABLE_PACKAGER:BOOL=ON
ELASTIX_USE_CUDA:BOOL=OFF
ELASTIX_USE_MEVISDICOMTIFF:BOOL=OFF
ELASTIX_IMAGE_DIMENSION:STRING=2;3;4
ELASTIX_IMAGE_2D_PIXELTYPES:STRING=float
ELASTIX_IMAGE_3D_PIXELTYPES:STRING=float
ELASTIX_IMAGE_4D_PIXELTYPES:STRING=short

// Compile all elastix components; todo: automate this
USE_AffineDTITransformElastix:BOOL=ON
USE_BSplineInterpolatorFloat:BOOL=ON
USE_BSplineResampleInterpolatorFloat:BOOL=ON
USE_BSplineTransformWithDiffusion:BOOL=ON
USE_ConjugateGradientFRPR:BOOL=ON
USE_FixedShrinkingPyramid:BOOL=ON
USE_LinearInterpolator:BOOL=ON
USE_LinearResampleInterpolator:BOOL=ON
USE_MovingShrinkingPyramid:BOOL=ON
USE_MutualInformationHistogramMetric:BOOL=ON
USE_NearestNeighborInterpolator:BOOL=ON
USE_NearestNeighborResampleInterpolator:BOOL=ON
USE_RSGDEachParameterApart:BOOL=ON
USE_ViolaWellsMutualInformationMetric:BOOL=ON
")

