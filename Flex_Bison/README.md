# Flex Bison

First: Download Flex

Second: Download Bison

Once Flex and Bison are Downloaded: Download the files

Once Files are Downloaded: Put the Files into Documents

Once Files are in Documents: Open Terminal and put in the command bison -d bison.y

Once command bison -d bison.y is done: Put command flex  -o flex.l.c flex.l

Once command flex  -o flex.l.c flex.l is done: Put command gcc  -o flex flex.l.c bison.tab.c -lfl -lm 

Once command gcc  -o flex flex.l.c bison.tab.c -lfl -lm is done: Put command ./flex

Once command ./flex is done: The program will start and will ask expression as the input. Enter a expression

Once you have entered the expression: The program will start and show you the output. The program won't end until an invalid expression is put
