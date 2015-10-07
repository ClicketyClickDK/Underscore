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
What.cmd      | Search file for pattern "@(#)" and print remainder of string. Used for documentation

### Sub scripts
File | Description
---|---
_GetOpt.cmd   | (sub) Parse command line options and create environment vars
_Debug.cmd    | (sub) Setting up debug environment for batch scripts

## Examples

### What

Command | Output / Result
---|---
_what what.cmd_   | Prints documentation for _what.cmd_ to STDOUT
_what_   | Prints documentation for what script it self to STDOUT

