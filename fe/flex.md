Before the Flexbox Layout module, there were four layout modes:

Block, for sections in a webpage
Inline, for text
Table, for two-dimensional table data
Positioned, for explicit position of an element
The Flexible Box Layout Module, makes it easier to design flexible responsive layout structure without using float or positioning.

The main idea behind the flex layout is to give the container the ability to alter its items’ width/height (and order) to best fill the available space (mostly to accommodate to all kind of display devices and screen sizes). A flex container expands items to fill available free space or shrinks them to prevent overflow.

Most importantly, the flexbox layout is direction-agnostic as opposed to the regular layouts (block which is vertically-based and inline which is horizontally-based).

lexbox layout is most appropriate to the components of an application, and small-scale layouts, while the Grid layout is intended for larger scale layouts.

If “regular” layout is based on both block and inline flow directions, the flex layout is based on “flex-flow directions”.

Items will be laid out following either the main axis (from main-start to main-end) or the cross axis (from cross-start to cross-end).

main axis – The main axis of a flex container is the primary axis along which flex items are laid out. Beware, it is not necessarily horizontal; it depends on the flex-direction property (see below).
main-start | main-end – The flex items are placed within the container starting from main-start and going to main-end.
main size – A flex item’s width or height, whichever is in the main dimension, is the item’s main size. The flex item’s main size property is either the ‘width’ or ‘height’ property, whichever is in the main dimension.
cross axis – The axis perpendicular to the main axis is called the cross axis. Its direction depends on the main axis direction.
cross-start | cross-end – Flex lines are filled with items and placed into the container starting on the cross-start side of the flex container and going toward the cross-end side.
cross size – The width or height of a flex item, whichever is in the cross dimension, is the item’s cross size. The cross size property is whichever of ‘width’ or ‘height’ that is in the cross dimension.

### Properties for the Parent (flex container)
* display: This defines a flex container; inline or block depending on the given value. It enables a flex context for all its direct children,i.e., display: flex;
* flex-direction: This establishes the main-axis, thus defining the direction flex items are placed in the flex container. Flexbox is (aside from optional wrapping) a single-direction layout concept. row (default): left to right in ltr; right to left in rtl
* flex-wrap: By default, flex items will all try to fit onto one line. You can change that and allow the items to wrap as needed with this property. nowrap (default): all flex items will be on one line
wrap: flex items will wrap onto multiple lines, from top to bottom.
* justify-content: flex-start (default): items are packed toward the start of the flex-direction.
flex-end: items are packed toward the end of the flex-direction.
start: items are packed toward the start of the writing-mode direction.
end: items are packed toward the end of the writing-mode direction.
left: items are packed toward left edge of the container, unless that doesn’t make sense with the flex-direction, then it behaves like start.
right: items are packed toward right edge of the container, unless that doesn’t make sense with the flex-direction, then it behaves like end.
center: items are centered along the line
space-between: items are evenly distributed in the line; first item is on the start line, last item on the end line
space-around: items are evenly distributed in the line with equal space around them. Note that visually the spaces aren’t equal, since all the items have equal space on both sides. The first item will have one unit of space against the container edge, but two units of space between the next item because that next item has its own spacing that applies.
space-evenly: items are distributed so that the spacing between any two items (and the space to the edges) is equal.
* align-items: This defines the default behavior for how flex items are laid out along the cross axis on the current line. Think of it as the justify-content version for the cross-axis (perpendicular to the main-axis).
* align-content: This aligns a flex container’s lines within when there is extra space in the cross-axis, similar to how justify-content aligns individual items within the main-axis. 

### Properties for the Children (flex items)
* flex-grow
* flex: This is the shorthand for flex-grow, flex-shrink and flex-basis combined.

 As with all properties in CSS, some initial values are defined, so when creating a flex container all of the contained flex items will behave in the following way.

Items display in a row (the flex-direction property's default is row).
The items start from the start edge of the main axis.
The items do not stretch on the main dimension, but can shrink.
The items will stretch to fill the size of the cross axis.
The flex-basis property is set to auto.
The flex-wrap property is set to nowrap.

The result of this is that your items will all line up in a row, using the size of the content as their size in the main axis. If there are more items than can fit in the container, they will not wrap but will instead overflow. If some items are taller than others, all items will stretch along the cross axis to fill its full size.

The live sample below contains items that have been given a width, the total width of the items being too wide for the flex container. As flex-wrap is set to wrap, the items wrap. Set it to nowrap, which is also the initial value, and they will instead shrink to fit the container because they are using initial flexbox values that allows items to shrink. Using nowrap would cause an overflow if the items were not able to shrink, or could not shrink small enough to fit.

The flex-basis is what defines the size of that item in terms of the space it leaves as available space. The initial value of this property is auto — in this case the browser looks to see if the items have a size. In the example above, all of the items have a width of 100 pixels and so this is used as the flex-basis.

If the items don’t have a size then the content's size is used as the flex-basis. This is why when we just declare display: flex on the parent to create flex items, the items all move into a row and take only as much space as they need to display their contents.

With the flex-grow property set to a positive integer, flex items can grow along the main axis from their flex-basis. This will cause the item to stretch and take up any available space on that axis, or a proportion of the available space if other items are allowed to grow too.

If we gave all of our items in the example above a flex-grow value of 1 then the available space in the flex container would be equally shared between our items and they would stretch to fill the container on the main axis.

The flex-grow property can be used to distribute space in proportion. If we give our first item a flex-grow value of 2, and the other items a value of 1 each, 2 parts will be given to the first item (100px out of 200px in the case of the example above), 1 part each the other two (50px each out of the 200px total).

You will very rarely see the flex-grow, flex-shrink, and flex-basis properties used individually; instead they are combined into the flex shorthand. The flex shorthand allows you to set the three values in this order — flex-grow, flex-shrink, flex-basis.

There are also some predefined shorthand values which cover most of the use cases. You will often see these used in tutorials, and in many cases these are all you will need to use. The predefined values are as follows:

flex: initial
flex: auto
flex: none
flex: <positive-number>
Setting flex: initial resets the item to the initial values of Flexbox. This is the same as flex: 0 1 auto. In this case the value of flex-grow is 0, so items will not grow larger than their flex-basis size. The value of flex-shrink is 1, so items can shrink if they need to rather than overflowing. The value of flex-basis is auto. Items will either use any size set on the item in the main dimension, or they will get their size from the content size.

Using flex: auto is the same as using flex: 1 1 auto; everything is as with flex:initial but in this case the items can grow and fill the container as well as shrink if required.

Using flex: none will create fully inflexible flex items. It is as if you wrote flex: 0 0 auto. The items cannot grow or shrink but will be laid out using flexbox with a flex-basis of auto.

The shorthand you often see in tutorials is flex: 1 or flex: 2 and so on. This is as if you used flex: 1 1 0. The items can grow and shrink from a flex-basis of 0.


