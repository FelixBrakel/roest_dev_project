cmake_minimum_required(VERSION 3.15)

project(roest_dev_project)

include(ExternalProject)

ExternalProject_Add(
        roest_runtime
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMAKE_COMMAND} -E env "FS_ROOT=${CMAKE_BINARY_DIR}" cargo build --package roest_runtime
        COMMAND cp ${CMAKE_SOURCE_DIR}/roest/target/debug/roest_runtime ${CMAKE_BINARY_DIR}
        BINARY_DIR "${CMAKE_SOURCE_DIR}/roest"
        INSTALL_COMMAND ""
        BYPRODUCTS ${CMAKE_SOURCE_DIR}/roest/target/debug/roest_runtime ${CMAKE_BINARY_DIR}/roest_runtime
        LOG_BUILD ON
        LOG_OUTPUT_ON_FAILURE True)

ExternalProject_Add(
        mesh_importer
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ${CMAKE_COMMAND} -E env "FS_ROOT=${CMAKE_SOURCE_DIR}" cargo build --package mesh_importer
        COMMAND cp ${CMAKE_SOURCE_DIR}/roest/target/debug/mesh_importer ${CMAKE_SOURCE_DIR}/tools
        BINARY_DIR "${CMAKE_SOURCE_DIR}/roest"
        INSTALL_COMMAND ""
        BYPRODUCTS ${CMAKE_SOURCE_DIR}/roest/target/debug/mesh_importer ${CMAKE_SOURCE_DIR}/tools/mesh_importer
        LOG_BUILD ON
        LOG_OUTPUT_ON_FAILURE True)