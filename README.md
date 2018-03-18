# smart-object
scripted image transform. PoC

<figure>

![Inspiration came from this UI. It's basically hotspots on an image that allow you to embed other images. Cool web-based dialogue, but closed source, slow](https://github.com/CODESIGN2/smart-object/blob/master/imgs/place-it-look-and-feel.png)

<caption>Inspiration came from this UI. It's basically hotspots on an image that allow you to embed other images. Cool web-based dialogue, but closed source, slow</caption>
</figure>

## Remit?

As nothing on the linked site uses curved sides or any complex features (which could be supported via masks), then it seems easy to just store two sets of four points.
The second set are for `top-left`, `top-right`, `bottom-left` and `bottom-right` destinations for the passed in image. The first set can be derrived from the image, such that `(0,0)` will always be `top-left`, `(width-1,height-1)` will always be `bottom-right` (note in the initial test we overrun by 1px). `top-right` and `bottom-left` are `(width-1,0)` & `(0,height-1)` respectively.

<figure>

![Diagram attempting to visualise how the corners translate](https://github.com/CODESIGN2/smart-object/blob/master/test/basic-transform/diagram.png)

<caption>Diagram attempting to visualise how the corners translate</caption>
</figure>

## How does this enable smart-objects?

Firstly it enables output of a scripted, repeatable image from an original source image. From that point anything done to the source can be translated to the output. From there it can be put into the regular compositing chain, either via CLI tools like imagemagick (used here), or in more complex GUI applications.

<figure>

![How this fits into the larger picture](https://github.com/CODESIGN2/smart-object/blob/master/imgs/rationale.png)

<caption>How this fits into the larger picture</caption>
</figure>

## Work to be done

* GUI's & non-CLI scripts to demo
* Higher-order Structures
* Flourishes (like adding a sheen layer, working with SVG, etc)

