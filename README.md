FOScounting
===========

A script for Foswiki based accounting. Especially usefull if you live in a shared flat and share the cost for daily needs such as cleaning powder or spicery.

Usage
-----
Edit the user template to create an additional file for every user, in which the user can enter their buyings. Next create a Topic which accumulates the spendings. Examples can be found in the repo within the [examples](examples).

Update paths, usernames and the password in the [finalize script](finalize.sh) to fit your installation.

Run the [finalize script](finalize.sh) on the same machine as your foswiki installation whith a user that has read and write permissions in the foswiki directory and read permissions in the directory your templates are stored (your http-user should have those). Templates here are the additional topic created for each users buyings (you should copy it to your backup directory right after you created the user account).

Requirements
------------

* mutt to send mails
* sed 
* a PDF-creator and a plugin for Foswiki (see http://foswiki.org/Extensions/)
* the [SpreadSheetPlugin](http://foswiki.org/Extensions/SpreadSheetPlugin) to do the math


License
--------
Licensed under the GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
