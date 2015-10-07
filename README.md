# Underscore
Generic DOS batch script library
## Description

These script are generic DOS batch scripts. They are ment to be used as a library and do contain dependencies.
Functionality is described in the header of each file and can be displayed using the what command or by using the -h flag.

## Naming convention
Naming | Description
-----|------------
.**cmd** | Ordinary batch script
.**bat** | Script to be preprocessed i.e. could contain VB code or likewise
**_** prefix | sub-functions ment to be used from within other function. I.e. these function may set environment variables or likewise. You may not directly "see" any output
**0** prefix | Template file 

*0template.cmd* is - a template to be used when creating new scripts.

## Variables

These scripts will not tamper with the environment - unless stated so in the documentation!
Sub scripts (with **_** prefix) will do so by default, since they are ment to be updating the parent scripts local environment

## Index

### Scripts
File | Description
---|---
`What.cmd`      | Search file for pattern "@(#)" and print remainder of string. Used for documentation

### Sub scripts
File | Description
---|---
`_GetOpt.cmd`   | (sub) Parse command line options and create environment vars
`_Debug.cmd`    | (sub) Setting up debug environment for batch scripts

## Examples

### What

Command | Output / Result
---|---
`what _debug.cmd`   | Prints documentation for `debug.cmd` to STDOUT
`what`   | Prints documentation for `what.com` script it self to STDOUT

#### Documentation for `What.cmd`
```
[What] v.[01.050] rev.[2011-10-13T18:41:00]

NAME
  What -- Search file for pattern '@(#)' and print remainder of string

SYNOPSIS
  What filename [pattern]

DESCRIPTION
  Reads each file name and searches for sequences of the form
  '@(#)', as inserted by the source code control system (SCCS)
  It prints the remainder of the string following this marker,
  up to a null character, newline, double quote, or

  So masking the VERY special characters is needed:
  ¤  ¤curren¤ Currency
  &  ¤amp¤    Ampersant
  ^  ¤caret¤  Caret
  >  ¤GT¤     Greater than
  >  ¤LT¤     Less than
  |  ¤pipe¤   Pipe or vertical bar
  (c)  ¤copy¤   Copyright

  A pattern may be given to replace the x in (x) like:

     What file pattern

  Will print alle lines the sequence: '@(pattern)'
  Note: Patterns are case insensitive

SOURCE
  c:\Bin\_\What.cmd

(c)2011 Erik Bachmann, ClicketyClick.dk (E_Bachmann@ClicketyClick.dk)
```

# History

2015-10-07T12:48 | Initiation : Currenty only a test version with some very old deprecated examles from http://clicketyclick.dk/development/dos/scripts/
