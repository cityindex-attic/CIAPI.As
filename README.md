# CIAPI.As

Actionscript3 client libraries for the CityIndex Trading API, suitable for Flex/Flash/Actionscript based projects

## Status

![Incomplete](http://labs.cityindex.com/wp-content/uploads/2012/01/lbl-incomplete.png)![Unsupported](http://labs.cityindex.com/wp-content/uploads/2012/01/lbl-unsupported.png)

This project has been retired and is no longer being supported by City Index Ltd.

* if you should choose to fork it outside of City Index, please let us know so we can link to your project

## Development Requirements

### Install Maven 2

1. Install [Maven 2](http://maven.apache.org/download.html) to `C:\Program Files\apache-maven-2.2.1`
1. Add `C:\Program Files\apache-maven-2.2.1\bin` to the path
1. Set environment variable `M2_HOME` to `C:\Program Files\apache-maven-2.2.1`
1. Add `C:\Users\<your name>\.m2\settings.xml` containing `<settings></settings>`
1. Verify `mvn --version` yields the expected result


### Install Flash Debug version 10.1 or later

1. http://www.adobe.com/support/flashplayer/downloads.html#fp10

### Setup Maven dependencies

1. Install the bundled 3rd party dependencies using `./register_3rdparty_libs_with_local_m2repo.cmd`

### (Optional) Setup FlashBuilder4

1. We're using FlashBuilder 4 premium (Eclipse plugin version, using the build in Eclipse)
1. Install Subclipse from http://subclipse.tigris.org/update_1.6.x
1. Install Maven2 Eclipse plugin from http://m2eclipse.sonatype.org/sites/m2e
1. Create a new workspace.  Checkout the trunk folder into a folder below the workspace folder 
  e.g C:\Dev\FlexITPWorkspace                      <--- workspace here
      C:\Dev\FlexITPWorkspace\cityindex_flexitp  <--- svn checkout of http://cityindex.unfuddle.com/svn/cityindex_flexitp/trunk here
1. Import > Maven > Existing Maven project - select C:\Dev\FlexChartsWorkspace\cityindex_flexcharts folder
1. Wait for build process, 
1. Run FlexUnit tests

## Known Issues

1. Q: Flashbuilder code completion etc breaks.
   A: Make sure you checkout the project to a new workspace, such that the project is below the workspace directory
     e.g  C:\Dev\FlexITPWorkspace                    <--- workspace here
          C:\Dev\FlexITPWorkspace\cityindex_flexitp  <--- svn checkout of http://cityindex.unfuddle.com/svn/cityindex_flexitp/trunk here
          
## License

Copyright 2010-2011 City Index Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
