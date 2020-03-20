cmake_minimum_required(VERSION 3.15)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(roest_dev_project NONE)

include(ExternalProject)

ExternalProject_Add(
        roest_runtime
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND cargo build --package roest_runtime
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/roest/target/debug/roest_runtime ${CMAKE_BINARY_DIR}/roest_runtime-prefix
        BUILD_ALWAYS True
        BINARY_DIR "${CMAKE_SOURCE_DIR}/roest"
        INSTALL_COMMAND ""
        BYPRODUCTS "${CMAKE_BINARY_DIR}/roest_runtime-prefix/roest_runtime"
        LOG_BUILD True
        LOG_OUTPUT_ON_FAILURE True
)


add_custom_command(
        TARGET roest_runtime POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/resources ${CMAKE_CURRENT_BINARY_DIR}/roest_runtime-prefix/resources
)

#add_custom_command(
#        TARGET roest_runtime PRE_BUILD
#        COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_BINARY_DIR}/roest_runtime-prefix/roest_runtime
#)

ExternalProject_Add(
        mesh_importer
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND cargo build --package mesh_importer
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/roest/target/debug/mesh_importer ${CMAKE_BINARY_DIR}/mesh_importer-prefix
        BUILD_ALWAYS True
        BINARY_DIR "${CMAKE_SOURCE_DIR}/roest"
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_BINARY_DIR}/mesh_importer-prefix/mesh_importer ${CMAKE_SOURCE_DIR}/tools
        BYPRODUCTS "${CMAKE_BINARY_DIR}/mesh_importer-prefix/mesh_importer"
        LOG_BUILD True
        LOG_OUTPUT_ON_FAILURE True
)

add_custom_command(
        TARGET mesh_importer PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_BINARY_DIR}/mesh_importer-prefix/mesh_importer
)
