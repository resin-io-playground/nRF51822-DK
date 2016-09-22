PROJECT_NAME := ble_boilerplate_s130_pca10028

export OUTPUT_FILENAME
MAKEFILE_NAME := $(MAKEFILE_LIST)
MAKEFILE_DIR := $(dir $(MAKEFILE_NAME) )

TEMPLATE_PATH = /opt/nRF5_SDK_11.0.0_89a8197/components/toolchain/gcc
ifeq ($(OS),Windows_NT)
include $(TEMPLATE_PATH)/Makefile.windows
else
include $(TEMPLATE_PATH)/Makefile.posix
endif

MK := mkdir
RM := rm -rf

ifeq ("$(VERBOSE)","1")
NO_ECHO :=
else
NO_ECHO := @
endif

# Toolchain commands
CC              := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-gcc'
AS              := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-as'
AR              := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-ar' -r
LD              := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-ld'
NM              := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-nm'
OBJDUMP         := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-objdump'
OBJCOPY         := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-objcopy'
SIZE            := '$(GNU_INSTALL_ROOT)/bin/$(GNU_PREFIX)-size'

#function for removing duplicates in a list
remduplicates = $(strip $(if $1,$(firstword $1) $(call remduplicates,$(filter-out $(firstword $1),$1))))

#source common to all targets
C_SOURCE_FILES += \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/button/app_button.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/util/app_error.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/util/app_error_weak.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/timer/app_timer.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/trace/app_trace.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/util/app_util_platform.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/fstorage/fstorage.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/util/nrf_assert.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/util/nrf_log.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/uart/retarget.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/sensorsim/sensorsim.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/external/segger_rtt/RTT_Syscalls_GCC.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/external/segger_rtt/SEGGER_RTT.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/external/segger_rtt/SEGGER_RTT_printf.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/uart/app_uart.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/delay/nrf_delay.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/common/nrf_drv_common.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/gpiote/nrf_drv_gpiote.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/uart/nrf_drv_uart.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/pstorage/pstorage.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/examples/bsp/bsp.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/examples/bsp/bsp_btn_ble.c) \
$(abspath src/main.c) \
$(abspath src/resin_status_service.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/common/ble_advdata.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/ble_advertising/ble_advertising.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/common/ble_conn_params.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/common/ble_srv_common.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/device_manager/device_manager_peripheral.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/toolchain/system_nrf51.c) \
$(abspath src/libs/softdevice_handler.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/bootloader_dfu/bootloader_util.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/bootloader_dfu/dfu_app_handler.c) \
$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/ble_services/ble_dfu/ble_dfu.c) \

#assembly files common to all targets
ASM_SOURCE_FILES  = $(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/toolchain/gcc/gcc_startup_nrf51.s)

#includes common to all targets
#INC_PATHS  = -I$(abspath ../../../config/ble_app_template_s130_pca10028)
INC_PATHS  = -I$(abspath config)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/config)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/timer)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/fstorage/config)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/softdevice/s130/headers)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/delay)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/util)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/device_manager)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/uart)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/common)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/sensorsim)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/pstorage)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/uart)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/device)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/button)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/fstorage)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/experimental_section_vars)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/gpiote)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/external/segger_rtt)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/examples/bsp)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/toolchain/CMSIS/Include)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/hal)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/toolchain/gcc)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/toolchain)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/drivers_nrf/common)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/ble_advertising)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/softdevice/s130/headers/nrf51)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/trace)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/softdevice/common/softdevice_handler)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/device_manager/config)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/libraries/bootloader_dfu)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/ble_services/ble_dfu)
INC_PATHS += -I$(abspath /opt/nRF5_SDK_11.0.0_89a8197/components/ble/ble_services/ble_dfu)
INC_PATHS += -I$(abspath src/libs)

OBJECT_DIRECTORY = _build
LISTING_DIRECTORY = $(OBJECT_DIRECTORY)
OUTPUT_BINARY_DIRECTORY = $(OBJECT_DIRECTORY)

# Sorting removes duplicates
BUILD_DIRECTORIES := $(sort $(OBJECT_DIRECTORY) $(OUTPUT_BINARY_DIRECTORY) $(LISTING_DIRECTORY) )

#flags common to all targets
CFLAGS  = -DNRF_LOG_USES_UART=1
CFLAGS += -DBOARD_PCA10028
CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DNRF51
CFLAGS += -DS130
CFLAGS += -DBLE_STACK_SUPPORT_REQD
CFLAGS += -DSWI_DISABLE0
CFLAGS += -mcpu=cortex-m0
CFLAGS += -mthumb -mabi=aapcs --std=gnu99
CFLAGS += -Wall -Werror -O3 -g3
CFLAGS += -mfloat-abi=soft
# keep every function in separate section. This will allow linker to dump unused functions
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin --short-enums
# keep every function in separate section. This will allow linker to dump unused functions
LDFLAGS += -Xlinker -Map=$(LISTING_DIRECTORY)/$(OUTPUT_FILENAME).map
LDFLAGS += -mthumb -mabi=aapcs -L $(TEMPLATE_PATH) -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m0
# let linker to dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs -lc -lnosys

# Assembler flags
ASMFLAGS += -x assembler-with-cpp
ASMFLAGS += -DNRF_LOG_USES_UART=1
ASMFLAGS += -DBOARD_PCA10028
ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DNRF51
ASMFLAGS += -DS130
ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
ASMFLAGS += -DSWI_DISABLE0

#default target - first one defined
default: clean nrf51422_xxac_s130

#building all targets
all: clean
	$(NO_ECHO)$(MAKE) -f $(MAKEFILE_NAME) -C $(MAKEFILE_DIR) -e cleanobj
	$(NO_ECHO)$(MAKE) -f $(MAKEFILE_NAME) -C $(MAKEFILE_DIR) -e nrf51422_xxac_s130

#target for printing all targets
help:
	@echo following targets are available:
	@echo 	nrf51422_xxac_s130
	@echo 	flash_softdevice

C_SOURCE_FILE_NAMES = $(notdir $(C_SOURCE_FILES))
C_PATHS = $(call remduplicates, $(dir $(C_SOURCE_FILES) ) )
C_OBJECTS = $(addprefix $(OBJECT_DIRECTORY)/, $(C_SOURCE_FILE_NAMES:.c=.o) )

ASM_SOURCE_FILE_NAMES = $(notdir $(ASM_SOURCE_FILES))
ASM_PATHS = $(call remduplicates, $(dir $(ASM_SOURCE_FILES) ))
ASM_OBJECTS = $(addprefix $(OBJECT_DIRECTORY)/, $(ASM_SOURCE_FILE_NAMES:.s=.o) )

vpath %.c $(C_PATHS)
vpath %.s $(ASM_PATHS)

OBJECTS = $(C_OBJECTS) $(ASM_OBJECTS)

nrf51422_xxac_s130: OUTPUT_FILENAME := nrf51422_xxac_s130
nrf51422_xxac_s130: CFLAGS += -DBLE_DFU_APP_SUPPORT
nrf51422_xxac_s130: ASMFLAGS += -DBLE_DFU_APP_SUPPORT
nrf51422_xxac_s130: LINKER_SCRIPT=config/nrf_gcc_nrf51.ld

nrf51422_xxac_s130: $(BUILD_DIRECTORIES) $(OBJECTS)
	@echo Linking target: $(OUTPUT_FILENAME).out
	$(NO_ECHO)$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -lm -o $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out
	$(NO_ECHO)$(MAKE) -f $(MAKEFILE_NAME) -C $(MAKEFILE_DIR) -e finalize

## Create build directories
$(BUILD_DIRECTORIES):
	$(MK) $@

# Create objects from C SRC files
$(OBJECT_DIRECTORY)/%.o: %.c
	@echo Compiling file: $(notdir $<)
	$(NO_ECHO)$(CC) $(CFLAGS) $(INC_PATHS) -c -o $@ $<

# Assemble files
$(OBJECT_DIRECTORY)/%.o: %.s
	@echo Assembly file: $(notdir $<)
	$(NO_ECHO)$(CC) $(ASMFLAGS) $(INC_PATHS) -c -o $@ $<

# Link
$(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out: $(BUILD_DIRECTORIES) $(OBJECTS)
	@echo Linking target: $(OUTPUT_FILENAME).out
	$(NO_ECHO)$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -lm -o $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out

## Create binary .bin file from the .out file
$(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).bin: $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out
	@echo Preparing: $(OUTPUT_FILENAME).bin
	$(NO_ECHO)$(OBJCOPY) -O binary $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).bin

## Create binary .hex file from the .out file
$(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).hex: $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out
	@echo Preparing: $(OUTPUT_FILENAME).hex
	$(NO_ECHO)$(OBJCOPY) -O ihex $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).hex

finalize: genbin genhex echosize genzip clean

genbin:
	@echo Preparing: $(OUTPUT_FILENAME).bin
	$(NO_ECHO)$(OBJCOPY) -O binary $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).bin

genhex:
	@echo Preparing: $(OUTPUT_FILENAME).hex
	$(NO_ECHO)$(OBJCOPY) -O ihex $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).hex

echosize:
	@echo 'Size:'
	$(NO_ECHO)$(SIZE) $(OUTPUT_BINARY_DIRECTORY)/$(OUTPUT_FILENAME).out

genzip:
	@echo Generating application.zip
	nrfutil dfu genpkg --application _build/nrf51422_xxac_s130.bin  application.zip

clean:
	$(RM) $(BUILD_DIRECTORIES)

cleanobj:
	$(RM) $(BUILD_DIRECTORIES)/*.o