# SPDX-License-Identifier: BSD-2-Clause
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.

# Qualcomm Cacao platform configuration.

include core/arch/arm/cpu/cortex-armv8-0.mk

$(call force,CFG_GIC,y)
$(call force,CFG_ARM_GICV4,y)
$(call force,CFG_QCOM_GENI_UART,y)
$(call force,CFG_CORE_ARM64_PA_BITS,40)

# The GENI UART is shared with the Linux kernel and an excessively long
# wait period may lead to RCU stall warnings depending on system load.
# Make this value configurable per platform.
CFG_QCOM_GENI_UART_RDY_WAIT_USEC ?= 1000

# PIL PAS authentication metadata slots, defaults to 1.
# Platform-specific configs may override this value.
CFG_PAS_MD_SLOTS ?= 1

$(call force,CFG_TEE_CORE_NB_CORE,3)

# DARE-TZ secure memory regions. DARE is an in-line memory encryption
# IP on Wildcat; it is set up by the TME root-of-trust before OP-TEE
# runs, so no specific OP-TEE driver is needed.
CFG_TZDRAM_START ?= 0x80fcd000
CFG_TEE_RAM_VA_SIZE ?= 0x147000
CFG_TA_RAM_VA_SIZE ?= 0x300000
CFG_TZDRAM_SIZE ?= (CFG_TEE_RAM_VA_SIZE + CFG_TA_RAM_VA_SIZE)
