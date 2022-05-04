add_executable(mergefonts
    mergeFonts.c
    help.h
    options.h
    usage.h
)

target_include_directories(mergefonts PUBLIC ${LIBXML2_INCLUDE_DIR} ${LIBXML2_INCLUDE_DIR_2} ../../shared/include ../../shared/resource ../../shared/source/tx_shared)
target_link_libraries(mergefonts PUBLIC tx_shared)
install(TARGETS mergefonts DESTINATION bin)