#include "building_tree.h"

BuildingTree::BuildingTree() {
}

BuildingTree::~BuildingTree() {
}

void BuildingTree::insertarValor(int value) {
    arbol.insertar(value);
}


void BuildingTree::_bind_methods() {
    ClassDB::bind_method(D_METHOD("insertarValor", "value"), &BuildingTree::insertarValor);
}
