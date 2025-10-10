#!/bin/bash
# Script para ejecutar la aplicación
cd /c/src/inventarioPlus/InitializrSpringbootProject
mvn clean compile
java -cp "target/classes:$(find ~/.m2/repository -name '*.jar' | tr '\n' ':')" com.example.InventarioPlus.InventarioPlusApplication