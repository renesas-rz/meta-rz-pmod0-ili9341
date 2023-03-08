DESCRIPTION = "Take touch device of ILI9341 PCB out of libinput control"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://99-ignore-mydevice.rules \
           "
do_install_append() {
    install -d ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/99-ignore-mydevice.rules ${D}${sysconfdir}/udev/rules.d/    
}

FILES_${PN} += "${sysconfdir}/udev/rules.d/99-ignore-mydevice.rules" 
