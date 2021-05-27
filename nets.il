/* CCShilightNets.il

Group		Custom IC, Cadence Design Systems
Language	SKILL
Revision No.	1.2
Date Created	Jun 10, 2003 
Last Modified	
Tested in	IC50
Lint score	100 (best is 100)
Description:

A set of functions to hilight wires on a named net in a schematic.
There is a procedural interface function CCShilightNets() that can
be used, as well as a function that is intended for use with a
bindkey (CCShiHilightNets).  A filter function CCSwireFilter() is
defined for use with CCShiHilightNets to prevent objects other than
paths or lines from being selected.  A seperate function is supplied
to remove hilights: CCSunhilightNets()

Usage:

  CCShilightNets( d_cv t_netName ) => t/nil

  ;; sets the bindkey for the "t" key to be CCShiHilightNets()
  ;; then press 't' over a wire in the schematic window to hilight
  ;; all wires on the net in this schematic
  hiSetBindKey("Schematics" "<Key>t" "CCShiHilightNets()")

  ;; selects all wires for the net "myNetName" if found
  CCShilightNets(geGetEditCellView() "myNetName")

  ;; graphically select and hilight nets:
  CCShiHilightNets()

  ;; remove all hilights
  CCSunhilightNets()
  ;; OR
  CCShilightNets(geGetEditCellView() "")

***************************************************

SCCS Info: @(#) CCShilightNets.il 05/19/05.23:57:11 1.2

********************************************************************
* DISCLAIMER: The following code is provided for Cadence customers *
* to use at their own risk. The code may require modification to   *
* satisfy the requirements of any user. The code and any           *
* modifications to the code may not be compatible with current or  *
* future versions of Cadence products.                             *
* THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, INCLUDING   *
* WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED WARRANTIES  *
* OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.              *
********************************************************************

*/

/********************************************************************
*                                                                   *
*                 CCShilightNets( d_cv t_netName )                  *
*                                                                   *
*  A function to hilight wires in a schematic based on the netName  *
*    supplied. The hilighting is done via a hilight set which is    *
*  automatically cleared of any previous highlights before adding   *
* new objects to the hilight set. The hilight set is stored on the  *
*  property list slot of the function so new global variables are   *
* used. A blank string can be supplied to the function to clear the *
* hilight set for the cellview. Returns 't' if hilights were added, *
*                     otherwise returns 'nil'.                      *
*                                                                   *
********************************************************************/
procedure(CCShilightNets(cv netName "dt")
let( (netObj hlSet)
  ;; when cv is a valid cellview object
  when(cv~>objType == "cellView"
    ;; if the highlight set already exists then delete it
    when(hlSet = CCShilightNets.hlSet
      when(geIsValidHilightSet(hlSet)
	geDeleteHilightSet(hlSet)
      )
    )
    ;; create the hilight set and store it on the property list slot
    ;; of the function, then enable it
    CCShilightNets.hlSet = geCreateHilightSet(cv list("annotate" "drawing") nil)
    CCShilightNets.hlSet->enable = t
    ;; when net name is not a blank string
    unless(blankstrp(netName)
      ;; when the net object can be found in the cellview
      when(netObj = dbFindNetByName(cv netName)
	;; add a higlight for each figure belonging to the net
	foreach(fig netObj~>figs
	  geAddHilightFig(CCShilightNets.hlSet fig t)
	)
	;; return 't'
        t
      ); when net object
    ); when net name not blank
  ); when cellview
); let
); procedure CCShilightNets


/************************************************************************
*                                                                       *
*                          CCShiHilightNets()                           *
*                                                                       *
*  A function that is intended to be called by a bindkey. The function  *
* uses the current cellview and window and uses the current location of *
*  the pointer/mouse to find the name of net that is at that position.  *
*  The function CCShilightNets() is then called with the cellview and   *
*        netname arguments to select all wires on the named net.        *
*                                                                       *
************************************************************************/
procedure(CCShiHilightNets()
let( (point obj
     (win hiGetCurrentWindow())
     (cv geGetEditCellView())
     )
  ;; when the window and cellview are valid
  when(and(windowp(win) dbobjectp(cv))
    ;; get the current point and get the object at that point
    ;; filtering out anything that is not a "wire" object
    when(point = hiGetCommandPoint(win)
      when(obj = gePointQuery(win point "CCSwireFilter")
	CCShilightNets(cv obj~>net~>name)
      ); when obj
    ); when point
  ); when window and cellview valid
); let
); procedure CCShiHilightNets

hiSetBindKey("Layout" "<Key>F12" "CCShiHilightNets()")
/******************************************************************
*                                                                 *
*                      CCSwireFilter(d_fig)                       *
*                                                                 *
* A procedure used by CCShiHilightNets to filter out objects that *
*        are neither narrow or wide wires in a schematic.         *
*                                                                 *
******************************************************************/
procedure(CCSwireFilter(fig)
  case( fig~>objType 
    (("line" "path") t)
    (t nil)
  ); case
); procedure CCSwireFilter


/***************************************************************
*                                                              *
*                      CCSunhilightNets()                      *
*                                                              *
* A function to unhilight nets hilighted by the CCShilightNets *
*   function. This is achieved by removing the hilight set.    *
*                                                              *
***************************************************************/
procedure(CCSunhilightNets()
let( (hlSet)
  ;; if the highlight set exists then delete it
  when(hlSet = CCShilightNets.hlSet
    ;; when hlSet is a valid hilight set
    when(geIsValidHilightSet(hlSet)
      geDeleteHilightSet(hlSet)
    ); when
    CCShilightNets.hlSet = nil
  ); when hlSet
); let
); procedure CCSunhilightNets
