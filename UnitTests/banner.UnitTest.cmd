
::----------------------------------------------------------------------

:_UnitTest_banner
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        rem ECHO:banner is a template. No functional test
        ECHO:                                                                           
        ECHO: #     #                                #     #                            
        ECHO: #     # ###### #      #       ####     #  #  #  ####  #####  #      ##### 
        ECHO: #     # #      #      #      #    #    #  #  # #    # #    # #      #    #
        ECHO: ####### #####  #      #      #    #    #  #  # #    # #    # #      #    #
        ECHO: #     # #      #      #      #    #    #  #  # #    # #####  #      #    #
        ECHO: #     # #      #      #      #    #    #  #  # #    # #   #  #      #    #
        ECHO: #     # ###### ###### ######  ####      ## ##   ####  #    # ###### ##### 
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        rem ECHO:banner is a template. No functional test
        CALL %0 "Hello World"
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_banner ***

::----------------------------------------------------------------------