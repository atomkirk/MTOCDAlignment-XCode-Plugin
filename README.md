MTOCDAlignment-XCode-Plugin
===========================

An XCode plugin for aligning code so it's more readable.

## TODO:
* handle block properties
* if the result is exactly the same, dont add to undo manager
* seperate paragraphs is seperated by two generic lines
* fix comment alignment (its increasing by a tab every time you activate)
* fix problem where +=, /=, etc get alligned correctly
* needs to ingore equals sign if its in quotes


## Contribute:

I would read this if you'd like a basic understanding of XCode plugins: http://www.blackdogfoundry.com/blog/creating-an-xcode4-plugin/

run this to tail the xcode logs:

    tail -f /var/log/system.log
