=CIAPI.Flex= [Incomplete] [Not supported]
Flex client libraries and sample applications for the CityIndex TradingAPI



==REQUIRED to build===

===Install Maven 2 for api===
1) Install Maven 2 to C:\Program Files\apache-maven-2.2.1 from http://maven.apache.org/download.html
2) add C:\Program Files\apache-maven-2.2.1\bin to path
3) SET M2_HOME = C:\Program Files\apache-maven-2.2.1
4) Add c:\Users\<your name>\.m2\settings.xml containing <settings></settings>
5) "mvn --version" should work

===Install Flash Debug version 10.1 or later===
1) http://www.adobe.com/support/flashplayer/downloads.html#fp10

===Setup Maven dependencies===
1) Install the bundled 3rd party dependencies using ./register_3rdparty_libs_with_local_m2repo.cmd



==OPTIONAL==

===Setting up FlashBuilder4===
1) We're using FlashBuilder 4 premium (Eclipse plugin version, using the build in Eclipse)
2) Install Subclipse from http://subclipse.tigris.org/update_1.6.x
3) Install Maven2 Eclipse plugin from http://m2eclipse.sonatype.org/sites/m2e
4) Create a new workspace.  Checkout the trunk folder into a folder below the workspace folder 
  e.g C:\Dev\FlexITPWorkspace                      <--- workspace here
      C:\Dev\FlexITPWorkspace\cityindex_flexitp  <--- svn checkout of http://cityindex.unfuddle.com/svn/cityindex_flexitp/trunk here
5) Import > Maven > Existing Maven project - select C:\Dev\FlexChartsWorkspace\cityindex_flexcharts folder
6) Wait for build process, 
7) Run FlexUnit tests


==Known Issues==
1) Q: Flashbuilder code completion etc breaks.
   A: Make sure you checkout the project to a new workspace, such that the project is below the workspace directory
     e.g  C:\Dev\FlexITPWorkspace                    <--- workspace here
          C:\Dev\FlexITPWorkspace\cityindex_flexitp  <--- svn checkout of http://cityindex.unfuddle.com/svn/cityindex_flexitp/trunk here
          
 
