DESCRIPTION = "Add some patches to the build process"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
 
SRC_URI_append_rzg2l   = " file://kernel_disp_user.cfg"
SRC_URI_append_riscv64 = " file://kernel_disp_user.cfg"

#RZG2L
SRC_URI_append_r9a07g044l = " \
                           file://patches/g2l/0001-EVK-PMOD0-RSPI1-add-ILI9341-display-support.patch \
                           file://patches/g2l/0002-EVK-PMOD0-RSPI1-ILI9341-add-touch.patch \
                           file://patches/g2l/0003-EVK-PMOD0-disable-GPT4-to-allow-touch.patch \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/g2l/0004-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R0.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/g2l/0004-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R180.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "270", "file://patches/g2l/0004-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R270.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/g2l/0005-EVK-PMOD0-RSPI1-ILI9341-touch-no-xy-swap.patch.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/g2l/0005-EVK-PMOD0-RSPI1-ILI9341-touch-no-xy-swap.patch.patch", " ",d)} \
"

#RZV2L (same as RZG2L)
SRC_URI_append_r9a07g054l = " \
                           file://patches/g2l/0001-EVK-PMOD0-RSPI1-add-ILI9341-display-support.patch \
                           file://patches/g2l/0002-EVK-PMOD0-RSPI1-ILI9341-add-touch.patch \
                           file://patches/g2l/0003-EVK-PMOD0-disable-GPT4-to-allow-touch.patch \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/g2l/0004-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R0.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/g2l/0004-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R180.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "270", "file://patches/g2l/0004-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R270.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/g2l/0005-EVK-PMOD0-RSPI1-ILI9341-touch-no-xy-swap.patch.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/g2l/0005-EVK-PMOD0-RSPI1-ILI9341-touch-no-xy-swap.patch.patch", " ",d)} \
"

#RZG2UL (different port settings and dts/dtsi splitting)
SRC_URI_append_r9a07g043u = " \
                           file://patches/g2ul/0001-EVK-PMOD0-RSPI1-add-ILI9341-display-support.patch \
                           file://patches/g2ul/0002-EVK-PMOD0-RSPI1-ILI9341-add-touch-support.patch \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/g2ul/0003-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R0.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/g2ul/0003-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R180.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "270", "file://patches/g2ul/0003-EVK-PMOD0-RSPI1-ILI9341-Orientation-R90-to-R270.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/g2ul/0004-EVK-PMOD0-RSPI1-ILI9341-touch-no-xy-swap.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/g2ul/0004-EVK-PMOD0-RSPI1-ILI9341-touch-no-xy-swap.patch", " ",d)} \
                           file://patches/g2ul/0005-EVK-PMOD0-RSPI1-ILI9341-move-status.patch \
"

#RZFIVE (different port settings and dts/dtsi splitting)
SRC_URI_append_riscv64 = " \
                           file://patches/rzfive/0002-add-dma-support-to-spi.patch \
                           file://patches/rzfive/0003-add-ili9341-support.patch \
                           file://patches/rzfive/0004-tft-add-touch-controller-control.patch \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/rzfive/0005-set-ILI9341-orientation-from-90-to-0.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/rzfive/0005-set-ILI9341-orientation-from-90-to-180.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "270", "file://patches/rzfive/0005-set-ILI9341-orientation-from-90-to-270.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "0", "file://patches/rzfive/0006-touch-display-dtsi-tsc2046-remove-swap-xy-for-0-and-.patch", " ",d)} \
                           ${@oe.utils.conditional("IS_PMOD0_ILI9341_ROT", "180", "file://patches/rzfive/0006-touch-display-dtsi-tsc2046-remove-swap-xy-for-0-and-.patch", " ",d)} \
"

