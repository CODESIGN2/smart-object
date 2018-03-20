from gimpfu import *
import os
import subprocess

def smart_object_gimp(image, drw, path, tl_x, tl_y, tr_x, tr_y, bl_x, bl_y, br_x, br_y):
    tmpfile = '/tmp/smart-object-'+str(image.filename)+'.png';
    env_args = {
        "topLeftDestPoint":"{},{}".format(tl_x, tl_y),
        "topRightDestPoint":"{},{}".format(tr_x, tr_y), 
        "bottomLeftDestPoint":"{},{}".format(bl_x, bl_y),
        "bottomRightDestPoint":"{},{}".format(br_x, br_y),
        "destinationGraphicWidth":str(image.width),
        "destinationGraphicHeight":str(image.height)}
    try:
        ext = path.lower().split(".")[-1]
        if ext in ("png", "jpg", "svg", "gif"):
            conv_proc = subprocess.Popen(
                ['/bin/bash', os.path.expanduser('~/bin/smart-object.sh'), path, tmpfile],
                env=env_args)
            conv_proc.wait()
            returncode = conv_proc.returncode
            if(returncode == 0):
                image_id, layer_ids = pdb.gimp_file_load_layers(image, tmpfile)
                for id in layer_ids:
                    new_layer = gimp.Item.from_id(id)
                    pdb.gimp_image_add_layer(image, new_layer, 0)
            else:
                print "Command was unsuccesful, exited with code: {}, check ~/bin/smart-object.sh exists".format(returncode)
                print conv_proc.communicate()
                print "path: {}".format(path)
                print "tmpfile: {}".format(tmpfile)
                print env_args
        else:
            print "File type {} unsupported".format(ext)
    except Exception, error:
        print error



register(
        "smart_object_gimp",
        "Smart-Object",
        "Smart-Object",
        "Lewis Cowles",
        "Lewis Cowles",
        "2018. AGPL-v3.0",
        "Open Image and transform to Layer",
        "*",
        [(PF_IMAGE, "image", "the image", None),
         (PF_DRAWABLE, "drw", "the drawable", None),
         (PF_FILENAME,"path", "File Open", os.path.expanduser('~/')),
         (PF_INT,    "tl_x", "Top Left {X}", 0),
         (PF_INT,    "tl_y", "Top Left {Y}", 0),
         (PF_INT,    "tr_x", "Top Right {X}", 0),
         (PF_INT,    "tr_y", "Top Right {Y}", 0),
         (PF_INT,    "bl_x", "Bottom Left {X}", 0),
         (PF_INT,    "bl_y", "Bottom Left {Y}", 0),
         (PF_INT,    "br_x", "Bottom Right {X}", 0),
         (PF_INT,    "br_y", "Bottom Right {Y}", 0),],
        [],
        smart_object_gimp,
        menu="<Image>/Tools/")

main()
