@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=an interface to the on-line reference manuals
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  %$Name% [page]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  %$Name% is the system's manual pager. Each page argument given to man is 
::@(#)  normally the name of a program, utility or function.  The manual page 
::@(#)  associated with each of these arguments is then found and displayed. A 
::@(#)  section, if provided, will direct man to look only in that section of the 
::@(#)  manual. The default action is to search in all of the available sections, 
::@(#)  following a pre-defined order and to show only the first page found, even 
::@(#)  if page exists in several sections.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#)  Requires pre-build documentation. If not found - use WHAT
::@(#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) 
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  what.cmd    Find and display reference manual information from file
::@(#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@ (#) 
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2010-10-13&SET $REVISION=14:01:00&SET $COMMENT=ErikBachmann/Initial [01.000]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.001]
::SET $VERSION=2015-02-18&SET $REVISION=14:30:00&SET $Comment=Path changed from ..\info to Documentation/ErikBachmann
::SET $VERSION=2015-02-19&SET $REVISION=03:06:53&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


IF NOT "%1!"=="!" (
    MORE %~dp0\Documentation\%1.txt
) ELSE (
    MORE %~dp0\Documentation\%$NAME%.txt

)
ENDLOCAL
::**********************************************************************

GOTO :EOF

NAME
       man - an interface to the on-line reference manuals

SYNOPSIS
       man [-c|-w|-tZ] [-H[browser]] [-T[device]] [-adhu7V] [-i|-I] [-m system[,...]] [-L locale] [-p string] [-C file] [-M path] [-P pager] [-r prompt] [-S list] [-e extension] [[section] page ...] ...
       man -l [-7] [-tZ] [-H[browser]] [-T[device]] [-p string] [-P pager] [-r prompt] file ...
       man -k [apropos options] regexp ...
       man -f [whatis options] page ...

DESCRIPTION
       man  is  the  system's  manual pager. Each page argument given to man is normally the name of 
       a program, utility or function.  The manual page associated with each of these arguments is then 
       found and displayed. A section, if provided, will direct man to look only in that section of 
       the manual.  The default action is to search in all of the available sections, following a 
       pre-defined order and to show only the first page found, even if page exists in several sections.

       The table below shows the section numbers of the manual followed by the types of pages they contain.

       1   Executable programs or shell commands
       2   System calls (functions provided by the kernel)
       3   Library calls (functions within program libraries)
       4   Special files (usually found in /dev)
       5   File formats and conventions eg /etc/passwd
       6   Games
       7   Miscellaneous  (including  macro  packages  and  conventions),  e.g.  man(7),
           groff(7)
       8   System administration commands (usually only for root)
       9   Kernel routines [Non standard]

       A manual page consists of several parts.

       They may be labelled NAME, SYNOPSIS, DESCRIPTION, OPTIONS, FILES, SEE ALSO, BUGS, and AUTHOR.

       The following conventions apply to the SYNOPSIS section and can be used as a guide in other sections.

       bold text          type exactly as shown.
       italic text        replace with appropriate argument.
       [-abc]             any or all arguments within [ ] are optional.
       -a|-b              options delimited by | cannot be used together.
       argument ...       argument is repeatable.
       [expression] ...   entire expression within [ ] is repeatable.

       The command or function illustration is a pattern that should match all possible invocations.  
       In some cases it is advisable to illustrate several exclusive invocations as is shown in 
       the SYNOPSIS section of this manual page.

EXAMPLES
       man ls
           Display the manual page for the item (program) ls.

       man -a intro
           Display, in succession, all of the available intro manual pages contained within the manual.  
           It is possible to quit between successive displays or skip any of them.

       man -t alias | lpr -Pps
           Format  the  manual  page  referenced  by  `alias', usually a shell manual page, into 
           the default troff or groff format and pipe it to the printer named ps.  The default output 
           for groff is usually PostScript.

       man --help
           should advise as to which processor is bound to the -t option.

 
OVERVIEW
       Many options are available to man in order to give as much flexibility as possible to the user.  
       Changes can be made to the search path, section order, output processor, and other behaviours 
       and operations detailed below.

       If set, various environment variables are interrogated to determine the operation of man.  
       It is possible to set the `catch all' variable $MANOPT to any string in command line format 
       with the exception that any spaces used as part of an option's argument must be escaped 
       (preceded by a backslash).  man will parse $MANOPT prior to parsing its own command line.  
       Those options requiring an argument will be overridden by the same options found  on  the
       command  line.   To  reset  all of the options set in $MANOPT, -D can be specified as the 
       initial command line option.  This will allow man to `forget' about the options specified 
       in $MANOPT although they must still have been valid.

       The manual pager utilities packaged as man-db make extensive use of index database caches.  These caches contain information such as where each manual page can be found on the filesystem and what its whatis  (short  one  line
       description  of  the  man  page)  contains, and allow man to run faster than if it had to search the filesystem each time to find the appropriate manual page.  If requested using the -u option, man will ensure that the caches
       remain consistent, which can obviate the need to manually run software to update traditional whatis text databases.

       If man cannot find a mandb initiated index database for a particular manual page hierarchy, it will still search for the requested manual pages, although file globbing will be necessary to search within  that  hierarchy.   If
       whatis or apropos fails to find an index it will try to extract information from a traditional whatis database instead.

       These utilities support compressed source nroff files having, by default, the extensions of .Z, .z and .gz.  It is possible to deal with any compression extension, but this information must be known at compile time.  Also, by
       default, any cat pages produced are compressed using gzip.  Each `global' manual page hierarchy such as /usr/share/man or /usr/X11R6/man may have any directory as its cat page  hierarchy.   Traditionally  the  cat  pages  are
       stored under the same hierarchy as the man pages, but for reasons such as those specified in the File Hierarchy Standard (FHS), it may be better to store them elsewhere.  For details on how to do this, please read manpath(5).
       For details on why to do this, read the standard.

       International support is available with this package.  Native language manual pages are accessible (if available on your system) via use of locale functions.  To activate such support, it is necessary to set  either  $LC_MES-
       SAGES, $LANG or another system dependent environment variable to your language locale, usually specified in the POSIX 1003.1 based format:

       <language>[_<territory>[.<character-set>[,<version>]]]

       If the desired page is available in your locale, it will be displayed in lieu of the standard (usually American English) page.

       Support  for international message catalogues is also featured in this package and can be activated in the same way, again if available.  If you find that the manual pages and message catalogues supplied with this package are
       not available in your native language and you would like to supply them, please contact the maintainer who will be coordinating such activity.

       For information regarding other features and extensions available with this manual pager, please read the documents supplied with the package.

DEFAULTS
       man will search for the desired manual pages within the index database caches. If the -u option is given, a cache consistency check is performed to ensure the databases accurately reflect the filesystem.  If  this  option  is
       always  given,  it is not generally necessary to run mandb after the caches are initially created, unless a cache becomes corrupt.  However, the cache consistency check can be slow on systems with many manual pages installed,
       so it is not performed by default, and system administrators may wish to run mandb every week or so to keep the database caches fresh.  To forestall problems caused by outdated caches, man will fall back to file globbing if a
       cache lookup fails, just as it would if no cache was present.

       Once a manual page has been located, a check is performed to find out if a relative preformatted `cat' file already exists and is newer than the nroff file.  If it does and is, this preformatted file is (usually) decompressed
       and then displayed, via use of a pager.  The pager can be specified in a number of ways, or else will fall back to a default is used (see option -P for details).  If no cat is found or is older than the nroff file, the  nroff
       is filtered through various programs and is shown immediately.

       If a cat file can be produced (a relative cat directory exists and has appropriate permissions), man will compress and store the cat file in the background.

       The  filters  are  deciphered by a number of means. Firstly, the command line option -p or the environment variable $MANROFFSEQ is interrogated. If -p was not used and the environment variable was not set, the initial line of the nroff file is parsed for a preprocessor string.  To contain a valid preprocessor string, the first line must resemble

 
 
 EXIT STATUS
       0      Successful program execution.
       1      Usage, syntax or configuration file error.
       2      Operational error.

ENVIRONMENT
       MANPATH
              If $MANPATH is set, its value is used as the path to search for manual pages.


FILES

 
SEE ALSO

HISTORY
