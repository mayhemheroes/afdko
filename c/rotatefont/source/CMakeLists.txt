add_executable(rotatefont
    rotateFont.c
    help.h
    options.h
    usage.h
)

target_include_directories(rotatefont PRIVATE ../../shared/include ../../shared/resource ../../shared/source/tx_shared ${LIBXML2_INCLUDE_DIR} ${LIBXML2_INCLUDE_DIR_2})
target_link_libraries(rotatefont PUBLIC libxml2 tx_shared)
install(TARGETS rotatefont DESTINATION bin)
