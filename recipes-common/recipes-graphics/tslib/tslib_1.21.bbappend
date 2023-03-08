DESCRIPTION = "Add required file for touch of ILI9341 PCB"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit systemd

SYSTEMD_SERVICE_${PN} = " ts_uinput.service "
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

SRC_URI += "file://ts.conf \
            file://ts.env \
            file://ts_32.env \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0",   "file://pointercal_2_4.0", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "90",  "file://pointercal_2_4.90", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://pointercal_2_4.180", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "270", "file://pointercal_2_4.270", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0",   "file://pointercal_2_8.0", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "90",  "file://pointercal_2_8.90", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://pointercal_2_8.180", " ",d)} \
            ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "270", "file://pointercal_2_8.270", " ",d)} \
            file://ts_uinput.service \
            file://98-touchscreen.rules \
            file://devfb1_enable.service \
           "

do_install_append() {
    # install the configuration files
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/ts.conf    ${D}${sysconfdir}/ts.conf
    if [ "${TARGET_ARCH}" = "riscv64" ] ; then
        install -m 0644 ${WORKDIR}/ts_32.env     ${D}${sysconfdir}/ts.env
    else
        install -m 0644 ${WORKDIR}/ts.env     ${D}${sysconfdir}/ts.env
    fi
    
    # install the settings for the touch calibration data (this may or may not match)
    # please adpat the files to our used display if required
    if [ "${IS_PMOD0_ILI9341_SIZE}" = "2.4" ] ; then 
      case ${IS_PMOD0_ILI9341_ROT} in
      0) 
          install -m 0644 ${WORKDIR}/pointercal_2_4.0 ${D}${sysconfdir}/pointercal  
          ;;
      90) 
          install -m 0644 ${WORKDIR}/pointercal_2_4.90 ${D}${sysconfdir}/pointercal  
          ;;
      180) 
          install -m 0644 ${WORKDIR}/pointercal_2_4.180 ${D}${sysconfdir}/pointercal  
          ;;
      270) 
          install -m 0644 ${WORKDIR}/pointercal_2_4.270 ${D}${sysconfdir}/pointercal  
          ;;
      esac        
    elif [ "${IS_PMOD0_ILI9341_SIZE}" = "2.8" ] ; then
      case ${IS_PMOD0_ILI9341_ROT} in
      0) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.0 ${D}${sysconfdir}/pointercal  
          ;;
      90) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.90 ${D}${sysconfdir}/pointercal  
          ;;
      180) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.180 ${D}${sysconfdir}/pointercal  
          ;;
      270) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.270 ${D}${sysconfdir}/pointercal  
          ;;
      esac            
    else
      case ${IS_PMOD0_ILI9341_ROT} in
      0) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.0 ${D}${sysconfdir}/pointercal  
          ;;
      90) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.90 ${D}${sysconfdir}/pointercal  
          ;;
      180) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.180 ${D}${sysconfdir}/pointercal  
          ;;
      270) 
          install -m 0644 ${WORKDIR}/pointercal_2_8.270 ${D}${sysconfdir}/pointercal  
          ;;
      esac              
    fi
    
    # install the ts_uinput service to get the coordinate translation activated    
    install -d ${D}${systemd_unitdir}/system
	install -c -m 0644 ${WORKDIR}/ts_uinput.service ${D}${systemd_unitdir}/system    
    install -d ${D}${sysconfdir}/systemd/system
	ln -sf ${systemd_unitdir}/system/ts_uinput.service \
		   ${D}${sysconfdir}/systemd/system/ts_uinput.service 
              
    #install -d ${D}${sysconfdir}/systemd/system
	#install -c -m 0644 ${WORKDIR}/ts_uinput.service ${D}${sysconfdir}/systemd/system    

    install -d ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/98-touchscreen.rules ${D}${sysconfdir}/udev/rules.d/    
    
    # install the devfb1_enable.service    
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
	install -c -m 0644 ${WORKDIR}/devfb1_enable.service ${D}${systemd_unitdir}/system    
	ln -sf ${systemd_unitdir}/system/devfb1_enable.service \
		   ${D}${sysconfdir}/systemd/system/multi-user.target.wants/devfb1_enable.service 
           
}

do_install_append_riscv64() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/ts_32.env     ${D}${sysconfdir}/ts.env
}

FILES_${PN} += "${systemd_unitdir}/system/ts_uinput.service" 
FILES_${PN} += "${sysconfdir}/systemd/system/ts_uinput.service"       
FILES_${PN} += "${sysconfdir}/udev/rules.d/98-touchscreen.rules" 
FILES_${PN} += "${sysconfdir}/ts.env" 
FILES_${PN} += "${sysconfdir}/ts.conf" 
FILES_${PN} += "${sysconfdir}/pointercal" 
FILES_${PN} += "${systemd_unitdir}/system/devfb1_enable.service" 
FILES_${PN} += "${sysconfdir}/systemd/system/multi-user.target.wants/devfb1_enable.service"
