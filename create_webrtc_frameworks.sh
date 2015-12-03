#!/bin/bash

# Get location of the script itself .. thanks SO ! http://stackoverflow.com/a/246128
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
PROJECT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

URL="https://s3.amazonaws.com/libjingle"
WEBRTC_REVISION=$1
BUILD_TYPE_STRING=$2
VERSION_BUILD=$3
WEBRTC_ARCHIVE_NAME='libWebRTC.tar.bz2'
WEBRTC_ARCHIVE_FILE="$PROJECT_DIR/$WEBRTC_ARCHIVE_NAME"
WEBRTC_FRAMEWORK_NAME="WebRTC"

function load_lib() {
  local  WEBRTC_ARCHIVE_URL="$URL/$WEBRTC_REVISION/$BUILD_TYPE_STRING/$VERSION_BUILD/$WEBRTC_ARCHIVE_NAME"
  curl -o "$WEBRTC_ARCHIVE_FILE" "$WEBRTC_ARCHIVE_URL"
}

function extract() {
  tar -C $PROJECT_DIR -xvf $WEBRTC_ARCHIVE_FILE libjingle_peerconnection
  if [ $? != '0' ]; then
    exit 1
  fi
}

function create_appl_framework () { #ARGS --> NAME LOCATION_DIR HEADER_DIR LIB_PATH VERSION {
    local NAME=$1
    local LOCATION_DIR=$2
    local HEADER_DIR=$3
    local LIB_PATH=$4
    local VERSION=$5

    mkdir -p $LOCATION_DIR
    rm -rf $LOCATION_DIR/$NAME.framework
    mkdir -p $LOCATION_DIR/$NAME.framework/Versions/A/Headers
    cp $HEADER_DIR/*.h $LOCATION_DIR/$NAME.framework/Versions/A/Headers
    cp $LIB_PATH $LOCATION_DIR/$NAME.framework/Versions/A/$NAME

    echo $VERSION >> $LOCATION_DIR/$NAME.framework/Version.txt

    pushd $LOCATION_DIR/$NAME.framework/Versions
    ln -sfh A Current
    popd
    pushd $LOCATION_DIR/$NAME.framework
    ln -sfh Versions/Current/Headers Headers
    ln -sfh Versions/Current/$NAME $NAME
    popd
}

load_lib
extract
create_appl_framework "$WEBRTC_FRAMEWORK_NAME" "$PROJECT_DIR/iOS" "$PROJECT_DIR/libjingle_peerconnection/Headers"  "$PROJECT_DIR/libjingle_peerconnection/libWebRTC.a" $WEBRTC_REVISION
rm $PROJECT_DIR/iOS/$WEBRTC_FRAMEWORK_NAME.framework/Versions/A/Headers/RTCNSGLVideoView.h
create_appl_framework "$WEBRTC_FRAMEWORK_NAME" "$PROJECT_DIR/OSX" "$PROJECT_DIR/libjingle_peerconnection/Headers"  "$PROJECT_DIR/libjingle_peerconnection/libWebRTC-osx.a" $WEBRTC_REVISION
rm $PROJECT_DIR/OSX/$WEBRTC_FRAMEWORK_NAME.framework/Versions/A/Headers/RTCEAGLVideoView.h
