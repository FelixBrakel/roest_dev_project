cmake_minimum_required(VERSION 3.15)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(roest_dev_project NONE)

include(ExternalProject)

ExternalProject_Add(
        roest_runtime
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMAKE_COMMAND} -E env "FS_ROOT=${CMAKE_BINARY_DIR}" cargo build --package roest_runtime
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/roest/target/debug/roest_runtime ${CMAKE_BINARY_DIR}/roest_runtime-prefix
        BINARY_DIR "${CMAKE_SOURCE_DIR}/roest"
        INSTALL_COMMAND ""
#        BYPRODUCTS "${CMAKE_BINARY_DIR}/roest_runtime-prefix/roest_runtime"
        LOG_BUILD ON
        LOG_OUTPUT_ON_FAILURE True
)

#message(dir: ${CMAKE_CURRENT_BINARY_DIR}/roest_runtime-prefix)

add_custom_command(
        TARGET roest_runtime POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/resources ${CMAKE_CURRENT_BINARY_DIR}/roest_runtime-prefix/resources
)

ExternalProject_Add(
        mesh_importer
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMAKE_COMMAND} -E env "FS_ROOT=${CMAKE_SOURCE_DIR}" cargo build --package mesh_importer
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/roest/target/debug/mesh_importer ${CMAKE_BINARY_DIR}/mesh_importer-prefix
        BINARY_DIR "${CMAKE_SOURCE_DIR}/roest"
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/mesh_importer-prefix/mesh_importer ${CMAKE_SOURCE_DIR}/tools
        BYPRODUCTS "${CMAKE_BINARY_DIR}/mesh_importer-prefix/mesh_importer"
        LOG_BUILD ON
        LOG_OUTPUT_ON_FAILURE True
)