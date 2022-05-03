add_executable(mergefonts
    mergeFonts.c
    help.h
    options.h
    usage.h
)

target_include_directories(mergefonts PRIVATE ../../shared/include ../../shared/resource ../../shared/source/tx_shared ${LIBXML2_INCLUDE_DIR} ${LIBXML2_INCLUDE_DIR_2})
target_link_libraries(mergefonts PUBLIC libxml2 tx_shared)
install(TARGETS mergefonts DESTINATION bin)

