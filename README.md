# Tree View
Xojo example project

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Description
Hierarchical Listboxes are a bit tricky with Xojo. This example project shows
a reusable approach:
- A class named ```CTreeListedValues```.  
  This is basically a simple List with a couple of properties: ```name, hint, key, status, data, sublist```. The ```sublist``` is just another instance of a ```CTreeListedValues``` list, allowing you to build a hierarchical structure.
- A Control subclass ```lstTreeView```.
  All the required "magic" in Xojo's Listbox is handled here.  
  You just need to assign your hierarchical ```CTreeListedValues``` list,
  and this Subclass takes care of:
  - Populate the Control to show the hierarchical data
  - Expanding/collapsing logic *(all rows; just a single branch)* and
    contextual menus
  - Updates the ```CTreeListedValues``` list according to the current state
    *(row expanded/collapsed; user requested to change a status of an entry)*

You can assign icons for all the item statuses you have. And the example shows how to change the status of the items by pressing a key and/or create a contextmenu (or do it in your code: modify the ```CTreeListedValues``` and update the Listbox).

### An example usage in a productive application
We fill a ```CTreeListedValues``` while scanning the differences between a database and a user's offline working-copy (file). The tree is then displayed to the user to show which items are going to get synchronized and in which direction (db -> file, db <- file). The user can interact if needed *(e.g. change the direction of some entries, or ignore a whole branch)*. Finally, the always updated ```CTreeListedValues``` *(such as confirmed and/or modified by the user)* are being used as the 'Task-list' for the main synchronization-task... 

### ScreenShots
TreeView: Example app - macOS  
![ScreenShot: Example App macOS](screenshots/TreeView_macOS.png?raw=true)

TreeView: Example app - Windows  
![ScreenShot: Example App Windows](screenshots/TreeView_Windows.png?raw=true)

## Xojo
### Requirements
[Xojo](https://www.xojo.com/) is a rapid application development for Desktop, Web, Mobile & Raspberry Pi.  

The Desktop application Xojo example project ```TreeView.xojo_project``` is using:
- Xojo 2023r4
- API 2

### How to use in your own Xojo project?
1. Copy and paste the folder ```treeview``` *(containing the classes ```CTreeListedValues``` and ```CTreeItem```, as well as the Listbox Subclass ```lstTreeView```)* to your project.
2. Place an instance of the ListBox subclass ```lstTreeView``` on a Window.
3. Have a look at how the example projects is using the provided Methods.  
   - Build and show a Tree: ```Window1.Tree_Setup```
   - Handle Events: ```Window1.lstTree```

## About
Juerg Otter is a long term user of Xojo and working for [CM Informatik AG](https://cmiag.ch/). Their Application [CMI LehrerOffice](https://cmi-bildung.ch/) is a Xojo Design Award Winner 2018. In his leisure time Juerg provides some [bits and pieces for Xojo Developers](https://www.jo-tools.ch/).

### Contact
[![E-Mail](https://img.shields.io/static/v1?style=social&label=E-Mail&message=xojo@jo-tools.ch)](mailto:xojo@jo-tools.ch)
&emsp;&emsp;
[![Follow on Facebook](https://img.shields.io/static/v1?style=social&logo=facebook&label=Facebook&message=juerg.otter)](https://www.facebook.com/juerg.otter)
&emsp;&emsp;
[![Follow on Twitter](https://img.shields.io/twitter/follow/juergotter?style=social)](https://twitter.com/juergotter)

### Donation
Do you like this project? Does it help you? Has it saved you time and money?  
You're welcome - it's free... If you want to say thanks I'd appreciate a [message](mailto:xojo@jo-tools.ch) or a small [donation via PayPal](https://paypal.me/jotools).  

[![PayPal Dontation to jotools](https://img.shields.io/static/v1?style=social&logo=paypal&label=PayPal&message=jotools)](https://paypal.me/jotools)
