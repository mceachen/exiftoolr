# Ruby wrapper for ExifTool

[![Build Status](https://secure.travis-ci.org/mceachen/exiftoolr.png?branch=master)](http://travis-ci.org/mceachen/exiftoolr)
[![Gem Version](https://badge.fury.io/rb/exiftoolr.png)](http://rubygems.org/gems/exiftoolr)
[![Code Climate](https://codeclimate.com/github/mceachen/exiftoolr.png)](https://codeclimate.com/github/mceachen/exiftoolr)

This gem is the simplest thing that could possibly work that
reads the output of [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool)
and renders it into a ruby hash, with correctly typed values and symbolized keys.

Note that this gem was renamed from 'exiftoolr' to the less-ungainly 'exiftool'
as of version 0.2.0. This gem simply adds a "class alias" from Exiftoolr to Exiftool,
and is dependant on that new gem.

Consumers should switch to the new gem's namespace as soon as possible.

Go to [exiftool](https://github.com/mceachen/exiftool) for more information!

## Change history

### 0.2.0

* Renamed to 'exiftool' (but kept backward compatibility)

### 0.1.0

* Better timestamp parsing—now both sub-second and timezone offsets are handled correctly
* Switched to minitest-spec
* Ruby 1.8.7 is no longer supported, hence the minor version uptick.

### 0.0.9

* Explicitly added MIT licensing to the gemspec.

### 0.0.8

* Extracted methods in parsing to make the code complexity lower. FOUR DOT OH GPA

### 0.0.7

* Added warning values for EXIF headers that are corrupt
* Made initialize gracefully accept an empty array, or an array of Pathname instances
* Added support for ruby 1.9.3 and exiftool v8.15 (Ubuntu Natty) and v8.85 (current stable version)

### 0.0.5

Fixed homepage URL in gemspec

### 0.0.4

Added support for multiple file fetching (which is *much* faster for large directories)
